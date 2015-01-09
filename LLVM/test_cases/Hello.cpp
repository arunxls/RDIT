//===- Hello.cpp - Example code from "Writing an LLVM Pass" ---------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements two versions of the LLVM "Hello World" pass described
// in docs/WritingAnLLVMPass.html
//
//===----------------------------------------------------------------------===//

#include "llvm/Pass.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Transforms/Instrumentation.h"
#include "llvm/ADT/SmallSet.h"
#include "llvm/ADT/SmallString.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/ADT/StringExtras.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Metadata.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/MathExtras.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/ModuleUtils.h"

using namespace llvm;

static bool isAtomic(Instruction *I);
void chooseInstructionsToInstrument(SmallVectorImpl<Instruction*> &Local, SmallVectorImpl<Instruction*> &All);
bool addrPointsToConstantData(Value *Addr);
static bool isVtableAccess(Instruction *I);
bool instrumentLoadOrStore(Instruction *I);
int getMemoryAccessFuncIndex(Value *Addr);


namespace {
    // Hello - The first implementation, without getAnalysisUsage.
    struct Hello : public FunctionPass {
        static char ID; // Pass identification, replacement for typeid
        Hello() : FunctionPass(ID) {}

        bool runOnFunction(Function &F) override {
            SmallVector<Instruction*, 8> RetVec;
            SmallVector<Instruction*, 8> AllLoadsAndStores;
            SmallVector<Instruction*, 8> LocalLoadsAndStores;
            SmallVector<Instruction*, 8> AtomicAccesses;
            SmallVector<Instruction*, 8> MemIntrinCalls;
            bool Res = false;
            bool HasCalls = false;
            bool SanitizeFunction = F.hasFnAttribute(Attribute::SanitizeThread);

            // Traverse all instructions, collect loads/stores/returns, check for calls.
            for (auto &BB : F) {
                for (auto &Inst : BB) {
                    if (isAtomic(&Inst))
                        AtomicAccesses.push_back(&Inst);
                    else if (isa<LoadInst>(Inst) || isa<StoreInst>(Inst))
                        LocalLoadsAndStores.push_back(&Inst);
                    else if (isa<ReturnInst>(Inst))
                        RetVec.push_back(&Inst);
                    else if (isa<CallInst>(Inst) || isa<InvokeInst>(Inst)) {
                        if (isa<MemIntrinsic>(Inst))
                            MemIntrinCalls.push_back(&Inst);
                        HasCalls = true;
                        chooseInstructionsToInstrument(LocalLoadsAndStores, AllLoadsAndStores);
                    }
                }
                chooseInstructionsToInstrument(LocalLoadsAndStores, AllLoadsAndStores);
            }

            // We have collected all loads and stores.
            // FIXME: many of these accesses do not need to be checked for races
            // (e.g. variables that do not escape, etc).

            // Instrument memory accesses only if we want to report bugs in the function.
            if (SanitizeFunction)
                for (auto Inst : AllLoadsAndStores) {
                    Res |= instrumentLoadOrStore(Inst);
                }

            // // Instrument atomic memory accesses in any case (they can be used to
            // // implement synchronization).
            // if (ClInstrumentAtomics)
            //     for (auto Inst : AtomicAccesses) {
            //         Res |= instrumentAtomic(Inst);
            //     }

            // if (ClInstrumentMemIntrinsics && SanitizeFunction)
            //     for (auto Inst : MemIntrinCalls) {
            //         Res |= instrumentMemIntrinsic(Inst);
            //     }

            // // Instrument function entry/exit points if there were instrumented accesses.
            // if ((Res || HasCalls) && ClInstrumentFuncEntryExit) {
            //     IRBuilder<> IRB(F.getEntryBlock().getFirstNonPHI());
            //     Value *ReturnAddress = IRB.CreateCall(Intrinsic::getDeclaration(F.getParent(), Intrinsic::returnaddress),IRB.getInt32(0));
            //     IRB.CreateCall(TsanFuncEntry, ReturnAddress);
            //     for (auto RetInst : RetVec) {
            //         IRBuilder<> IRBRet(RetInst);
            //         IRBRet.CreateCall(TsanFuncExit);
            //     }
            //     Res = true;
            // }
            return Res;
        }
    };
}

static bool isAtomic(Instruction *I) {
    if (LoadInst *LI = dyn_cast<LoadInst>(I))
        return LI->isAtomic() && LI->getSynchScope() == CrossThread;
    if (StoreInst *SI = dyn_cast<StoreInst>(I))
        return SI->isAtomic() && SI->getSynchScope() == CrossThread;
    if (isa<AtomicRMWInst>(I))
        return true;
    if (isa<AtomicCmpXchgInst>(I))
        return true;
    if (isa<FenceInst>(I))
        return true;
    return false;
}

// Instrumenting some of the accesses may be proven redundant.
// Currently handled:
//  - read-before-write (within same BB, no calls between)
//
// We do not handle some of the patterns that should not survive
// after the classic compiler optimizations.
// E.g. two reads from the same temp should be eliminated by CSE,
// two writes should be eliminated by DSE, etc.
//
// 'Local' is a vector of insns within the same BB (no calls between).
// 'All' is a vector of insns that will be instrumented.
void chooseInstructionsToInstrument( SmallVectorImpl<Instruction*> &Local, SmallVectorImpl<Instruction*> &All) {
    SmallSet<Value*, 8> WriteTargets;
    // Iterate from the end.
    for (SmallVectorImpl<Instruction*>::reverse_iterator It = Local.rbegin(), E = Local.rend(); It != E; ++It) {
        Instruction *I = *It;
        if (StoreInst *Store = dyn_cast<StoreInst>(I)) {
            WriteTargets.insert(Store->getPointerOperand());
        } else {
            LoadInst *Load = cast<LoadInst>(I);
            Value *Addr = Load->getPointerOperand();
            if (WriteTargets.count(Addr)) {
                // We will write to this temp, so no reason to analyze the read.
                continue;
            }
            if (addrPointsToConstantData(Addr)) {
                // Addr points to some constant data -- it can not race with any writes.
                continue;
          }
        }
        All.push_back(I);
      }
      Local.clear();
}

bool addrPointsToConstantData(Value *Addr) {
    // If this is a GEP, just analyze its pointer operand.
    if (GetElementPtrInst *GEP = dyn_cast<GetElementPtrInst>(Addr))
        Addr = GEP->getPointerOperand();

    if (GlobalVariable *GV = dyn_cast<GlobalVariable>(Addr)) {
        if (GV->isConstant()) {
            // Reads from constant globals can not race with any writes.
            return true;
        }
    } else if (LoadInst *L = dyn_cast<LoadInst>(Addr)) {
        if (isVtableAccess(L)) {
            // Reads from a vtable pointer can not race with any writes.
            return true;
        }
    }
    return false;
}

static bool isVtableAccess(Instruction *I) {
    if (MDNode *Tag = I->getMetadata(LLVMContext::MD_tbaa))
       return Tag->isTBAAVtableAccess();
    return false;
}

// bool instrumentLoadOrStore(Instruction *I) {
//     IRBuilder<> IRB(I);
//     bool IsWrite = isa<StoreInst>(*I);
//     Value *Addr = IsWrite
//       ? cast<StoreInst>(I)->getPointerOperand()
//       : cast<LoadInst>(I)->getPointerOperand();
//     int Idx = getMemoryAccessFuncIndex(Addr);
//     if (Idx < 0)
//         return false;
//     if (IsWrite && isVtableAccess(I)) {
//         DEBUG(dbgs() << "  VPTR : " << *I << "\n");
//         Value *StoredValue = cast<StoreInst>(I)->getValueOperand();
//         // StoredValue may be a vector type if we are storing several vptrs at once.
//         // In this case, just take the first element of the vector since this is
//         // enough to find vptr races.
//         if (isa<VectorType>(StoredValue->getType()))
//             StoredValue = IRB.CreateExtractElement(StoredValue, ConstantInt::get(IRB.getInt32Ty(), 0));
//         if (StoredValue->getType()->isIntegerTy())
//             StoredValue = IRB.CreateIntToPtr(StoredValue, IRB.getInt8PtrTy());
//             // Call TsanVptrUpdate.
//         IRB.CreateCall2(TsanVptrUpdate,IRB.CreatePointerCast(Addr, IRB.getInt8PtrTy()), IRB.CreatePointerCast(StoredValue, IRB.getInt8PtrTy()));
//         return true;
//     }

//     if (!IsWrite && isVtableAccess(I)) {
//         IRB.CreateCall(TsanVptrLoad, IRB.CreatePointerCast(Addr, IRB.getInt8PtrTy()));
//         return true;
//     }

//     Value *OnAccessFunc = IsWrite ? TsanWrite[Idx] : TsanRead[Idx];
//     IRB.CreateCall(OnAccessFunc, IRB.CreatePointerCast(Addr, IRB.getInt8PtrTy()));
//     return true;
// }

int getMemoryAccessFuncIndex(Value *Addr) {
    Type *OrigPtrTy = Addr->getType();
    Type *OrigTy = cast<PointerType>(OrigPtrTy)->getElementType();
    assert(OrigTy->isSized());
    return Idx;
}

char Hello::ID = 0;
static RegisterPass<Hello> X("hello", "Hello World Pass");
