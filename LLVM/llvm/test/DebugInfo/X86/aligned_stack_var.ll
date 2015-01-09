; RUN: llc %s -mtriple=x86_64-pc-linux-gnu -O0 -filetype=obj -o %t
; RUN: llvm-dwarfdump -debug-dump=info %t | FileCheck %s

; If stack is realigned, we shouldn't describe locations of local
; variables by giving offset from the frame pointer (%rbp):
; push %rpb
; mov  %rsp,%rbp
; and  ALIGNMENT,%rsp ; (%rsp and %rbp are different now)
; It's better to use offset from %rsp instead.

; DW_AT_location of variable "x" shouldn't be equal to
; (DW_OP_fbreg: .*): DW_OP_fbreg has code 0x91

; CHECK: {{0x.* DW_TAG_variable}}
; CHECK-NOT: {{DW_AT_location.*DW_FORM_block1.*0x.*91}}
; CHECK: NULL

define void @_Z3runv() nounwind uwtable {
entry:
  %x = alloca i32, align 32
  call void @llvm.dbg.declare(metadata !{i32* %x}, metadata !9, metadata !{metadata !"0x102"}), !dbg !12
  ret void, !dbg !13
}

declare void @llvm.dbg.declare(metadata, metadata, metadata) nounwind readnone

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!15}

!0 = metadata !{metadata !"0x11\004\00clang version 3.2 (trunk 155696:155697) (llvm/trunk 155696)\000\00\000\00\000", metadata !14, metadata !1, metadata !1, metadata !3, metadata !1,  metadata !1} ; [ DW_TAG_compile_unit ]
!1 = metadata !{}
!3 = metadata !{metadata !5}
!5 = metadata !{metadata !"0x2e\00run\00run\00_Z3runv\001\000\001\000\006\00256\000\001", metadata !14, metadata !6, metadata !7, null, void ()* @_Z3runv, null, null, metadata !1} ; [ DW_TAG_subprogram ]
!6 = metadata !{metadata !"0x29", metadata !14} ; [ DW_TAG_file_type ]
!7 = metadata !{metadata !"0x15\00\000\000\000\000\000\000", i32 0, null, null, metadata !8, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null}
!9 = metadata !{metadata !"0x100\00x\002\000", metadata !10, metadata !6, metadata !11} ; [ DW_TAG_auto_variable ]
!10 = metadata !{metadata !"0xb\001\0012\000", metadata !14, metadata !5} ; [ DW_TAG_lexical_block ]
!11 = metadata !{metadata !"0x24\00int\000\0032\0032\000\000\005", null, null} ; [ DW_TAG_base_type ]
!12 = metadata !{i32 2, i32 7, metadata !10, null}
!13 = metadata !{i32 3, i32 1, metadata !10, null}
!14 = metadata !{metadata !"test.cc", metadata !"/home/samsonov/debuginfo"}
!15 = metadata !{i32 1, metadata !"Debug Info Version", i32 2}
