; ModuleID = 'test.bc'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

%struct._opaque_pthread_t = type { i64, %struct.__darwin_pthread_handler_rec*, [8176 x i8] }
%struct.__darwin_pthread_handler_rec = type { void (i8*)*, i8*, %struct.__darwin_pthread_handler_rec* }
%struct._opaque_pthread_attr_t = type { i64, [56 x i8] }

@Global = global i32 0, align 4
@.str = private unnamed_addr constant [11 x i8] c"Global %d\0A\00", align 1
@.str1 = private unnamed_addr constant [9 x i8] c"Temp %d\0A\00", align 1
@.str2 = private unnamed_addr constant [18 x i8] c"Final Value : %d\0A\00", align 1

; Function Attrs: ssp uwtable
define void @_Z11inc_counterv() #0 {
entry:
  %i = alloca i32, align 4
  %temp = alloca i32, align 4
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !49, metadata !50), !dbg !51
  store i32 0, i32* %i, align 4, !dbg !52
  br label %while.cond, !dbg !53

while.cond:                                       ; preds = %while.body, %entry
  %0 = load i32* %i, align 4, !dbg !53
  %cmp = icmp slt i32 %0, 1, !dbg !53
  br i1 %cmp, label %while.body, label %while.end, !dbg !53

while.body:                                       ; preds = %while.cond
  %1 = load i32* @Global, align 4, !dbg !54
  %call = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str, i32 0, i32 0), i32 %1), !dbg !54
  call void @llvm.dbg.declare(metadata !{i32* %temp}, metadata !56, metadata !50), !dbg !57
  %2 = load i32* @Global, align 4, !dbg !58
  %add = add nsw i32 %2, 1, !dbg !58
  store i32 %add, i32* %temp, align 4, !dbg !58
  %3 = load i32* %temp, align 4, !dbg !59
  %call1 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str1, i32 0, i32 0), i32 %3), !dbg !59
  %4 = load i32* %temp, align 4, !dbg !60
  store i32 %4, i32* @Global, align 4, !dbg !60
  %5 = load i32* @Global, align 4, !dbg !61
  %call2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str, i32 0, i32 0), i32 %5), !dbg !61
  %6 = load i32* %i, align 4, !dbg !62
  %inc = add nsw i32 %6, 1, !dbg !62
  store i32 %inc, i32* %i, align 4, !dbg !62
  br label %while.cond, !dbg !53

while.end:                                        ; preds = %while.cond
  ret void, !dbg !63
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: ssp uwtable
define i8* @_Z7Thread1Pv(i8* %x) #0 {
entry:
  %x.addr = alloca i8*, align 8
  store i8* %x, i8** %x.addr, align 8
  call void @llvm.dbg.declare(metadata !{i8** %x.addr}, metadata !64, metadata !50), !dbg !65
  %0 = load i32* @Global, align 4, !dbg !66
  %call = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str, i32 0, i32 0), i32 %0), !dbg !66
  call void @_Z11inc_counterv(), !dbg !67
  ret i8* null, !dbg !68
}

; Function Attrs: ssp uwtable
define void @missed_1(%struct._opaque_pthread_t* %t) #0 {
entry:
  %t.addr = alloca %struct._opaque_pthread_t*, align 8
  store %struct._opaque_pthread_t* %t, %struct._opaque_pthread_t** %t.addr, align 8
  call void @llvm.dbg.declare(metadata !{%struct._opaque_pthread_t** %t.addr}, metadata !69, metadata !50), !dbg !70
  %call = call i32 @pthread_create(%struct._opaque_pthread_t** %t.addr, %struct._opaque_pthread_attr_t* null, i8* (i8*)* @_Z7Thread1Pv, i8* null), !dbg !71
  ret void, !dbg !72
}

declare i32 @pthread_create(%struct._opaque_pthread_t**, %struct._opaque_pthread_attr_t*, i8* (i8*)*, i8*) #2

; Function Attrs: ssp uwtable
define i32 @main() #0 {
entry:
  %t = alloca [1 x %struct._opaque_pthread_t*], align 8
  call void @_Z11inc_counterv(), !dbg !73
  %0 = load i32* @Global, align 4, !dbg !74
  %call = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str2, i32 0, i32 0), i32 %0), !dbg !74
  call void @llvm.dbg.declare(metadata !{[1 x %struct._opaque_pthread_t*]* %t}, metadata !75, metadata !50), !dbg !79
  %arrayidx = getelementptr inbounds [1 x %struct._opaque_pthread_t*]* %t, i32 0, i64 0, !dbg !80
  %1 = load %struct._opaque_pthread_t** %arrayidx, align 8, !dbg !80
  call void @missed_1(%struct._opaque_pthread_t* %1), !dbg !80
  %arrayidx1 = getelementptr inbounds [1 x %struct._opaque_pthread_t*]* %t, i32 0, i64 0, !dbg !81
  %2 = load %struct._opaque_pthread_t** %arrayidx1, align 8, !dbg !81
  %call2 = call i32 @"\01_pthread_join"(%struct._opaque_pthread_t* %2, i8** null), !dbg !81
  %3 = load i32* @Global, align 4, !dbg !82
  %call3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str2, i32 0, i32 0), i32 %3), !dbg !82
  ret i32 0, !dbg !83
}

declare i32 @"\01_pthread_join"(%struct._opaque_pthread_t*, i8**) #2

attributes #0 = { ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!46, !47}
!llvm.ident = !{!48}

!0 = metadata !{metadata !"0x11\004\00clang version 3.6.0 (221053)\000\00\000\00\001", metadata !1, metadata !2, metadata !3, metadata !25, metadata !44, metadata !2} ; [ DW_TAG_compile_unit ] [/Users/arunk/Code/LLVM/test_cases/Example_7/test.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !"test.cpp", metadata !"/Users/arunk/Code/LLVM/test_cases/Example_7"}
!2 = metadata !{}
!3 = metadata !{metadata !4, metadata !16}
!4 = metadata !{metadata !"0x13\00_opaque_pthread_t\00103\0065536\0064\000\000\000", metadata !5, null, null, metadata !6, null, null, metadata !"_ZTS17_opaque_pthread_t"} ; [ DW_TAG_structure_type ] [_opaque_pthread_t] [line 103, size 65536, align 64, offset 0] [def] [from ]
!5 = metadata !{metadata !"/usr/include/sys/_pthread/_pthread_types.h", metadata !"/Users/arunk/Code/LLVM/test_cases/Example_7"}
!6 = metadata !{metadata !7, metadata !9, metadata !11}
!7 = metadata !{metadata !"0xd\00__sig\00104\0064\0064\000\000", metadata !5, metadata !"_ZTS17_opaque_pthread_t", metadata !8} ; [ DW_TAG_member ] [__sig] [line 104, size 64, align 64, offset 0] [from long int]
!8 = metadata !{metadata !"0x24\00long int\000\0064\0064\000\000\005", null, null} ; [ DW_TAG_base_type ] [long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!9 = metadata !{metadata !"0xd\00__cleanup_stack\00105\0064\0064\0064\000", metadata !5, metadata !"_ZTS17_opaque_pthread_t", metadata !10} ; [ DW_TAG_member ] [__cleanup_stack] [line 105, size 64, align 64, offset 64] [from ]
!10 = metadata !{metadata !"0xf\00\000\0064\0064\000\000", null, null, metadata !"_ZTS28__darwin_pthread_handler_rec"} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from _ZTS28__darwin_pthread_handler_rec]
!11 = metadata !{metadata !"0xd\00__opaque\00106\0065408\008\00128\000", metadata !5, metadata !"_ZTS17_opaque_pthread_t", metadata !12} ; [ DW_TAG_member ] [__opaque] [line 106, size 65408, align 8, offset 128] [from ]
!12 = metadata !{metadata !"0x1\00\000\0065408\008\000\000\000", null, null, metadata !13, metadata !14, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 65408, align 8, offset 0] [from char]
!13 = metadata !{metadata !"0x24\00char\000\008\008\000\000\006", null, null} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!14 = metadata !{metadata !15}
!15 = metadata !{metadata !"0x21\000\008176"}     ; [ DW_TAG_subrange_type ] [0, 8175]
!16 = metadata !{metadata !"0x13\00__darwin_pthread_handler_rec\0057\00192\0064\000\000\000", metadata !5, null, null, metadata !17, null, null, metadata !"_ZTS28__darwin_pthread_handler_rec"} ; [ DW_TAG_structure_type ] [__darwin_pthread_handler_rec] [line 57, size 192, align 64, offset 0] [def] [from ]
!17 = metadata !{metadata !18, metadata !23, metadata !24}
!18 = metadata !{metadata !"0xd\00__routine\0058\0064\0064\000\000", metadata !5, metadata !"_ZTS28__darwin_pthread_handler_rec", metadata !19} ; [ DW_TAG_member ] [__routine] [line 58, size 64, align 64, offset 0] [from ]
!19 = metadata !{metadata !"0xf\00\000\0064\0064\000\000", null, null, metadata !20} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!20 = metadata !{metadata !"0x15\00\000\000\000\000\000\000", null, null, null, metadata !21, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!21 = metadata !{null, metadata !22}
!22 = metadata !{metadata !"0xf\00\000\0064\0064\000\000", null, null, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!23 = metadata !{metadata !"0xd\00__arg\0059\0064\0064\0064\000", metadata !5, metadata !"_ZTS28__darwin_pthread_handler_rec", metadata !22} ; [ DW_TAG_member ] [__arg] [line 59, size 64, align 64, offset 64] [from ]
!24 = metadata !{metadata !"0xd\00__next\0060\0064\0064\00128\000", metadata !5, metadata !"_ZTS28__darwin_pthread_handler_rec", metadata !10} ; [ DW_TAG_member ] [__next] [line 60, size 64, align 64, offset 128] [from ]
!25 = metadata !{metadata !26, metadata !30, metadata !33, metadata !40}
!26 = metadata !{metadata !"0x2e\00inc_counter\00inc_counter\00_Z11inc_counterv\009\000\001\000\000\00256\000\009", metadata !1, metadata !27, metadata !28, null, void ()* @_Z11inc_counterv, null, null, metadata !2} ; [ DW_TAG_subprogram ] [line 9] [def] [inc_counter]
!27 = metadata !{metadata !"0x29", metadata !1}   ; [ DW_TAG_file_type ] [/Users/arunk/Code/LLVM/test_cases/Example_7/test.cpp]
!28 = metadata !{metadata !"0x15\00\000\000\000\000\000\000", null, null, null, metadata !29, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!29 = metadata !{null}
!30 = metadata !{metadata !"0x2e\00Thread1\00Thread1\00_Z7Thread1Pv\0023\000\001\000\000\00256\000\0023", metadata !1, metadata !27, metadata !31, null, i8* (i8*)* @_Z7Thread1Pv, null, null, metadata !2} ; [ DW_TAG_subprogram ] [line 23] [def] [Thread1]
!31 = metadata !{metadata !"0x15\00\000\000\000\000\000\000", null, null, null, metadata !32, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!32 = metadata !{metadata !22, metadata !22}
!33 = metadata !{metadata !"0x2e\00missed_1\00missed_1\00\0031\000\001\000\000\00256\000\0031", metadata !1, metadata !27, metadata !34, null, void (%struct._opaque_pthread_t*)* @missed_1, null, null, metadata !2} ; [ DW_TAG_subprogram ] [line 31] [def] [missed_1]
!34 = metadata !{metadata !"0x15\00\000\000\000\000\000\000", null, null, null, metadata !35, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!35 = metadata !{null, metadata !36}
!36 = metadata !{metadata !"0x16\00pthread_t\0030\000\000\000\000", metadata !37, null, metadata !38} ; [ DW_TAG_typedef ] [pthread_t] [line 30, size 0, align 0, offset 0] [from __darwin_pthread_t]
!37 = metadata !{metadata !"/usr/include/sys/_pthread/_pthread_t.h", metadata !"/Users/arunk/Code/LLVM/test_cases/Example_7"}
!38 = metadata !{metadata !"0x16\00__darwin_pthread_t\00118\000\000\000\000", metadata !5, null, metadata !39} ; [ DW_TAG_typedef ] [__darwin_pthread_t] [line 118, size 0, align 0, offset 0] [from ]
!39 = metadata !{metadata !"0xf\00\000\0064\0064\000\000", null, null, metadata !"_ZTS17_opaque_pthread_t"} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from _ZTS17_opaque_pthread_t]
!40 = metadata !{metadata !"0x2e\00main\00main\00\0038\000\001\000\000\00256\000\0038", metadata !1, metadata !27, metadata !41, null, i32 ()* @main, null, null, metadata !2} ; [ DW_TAG_subprogram ] [line 38] [def] [main]
!41 = metadata !{metadata !"0x15\00\000\000\000\000\000\000", null, null, null, metadata !42, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!42 = metadata !{metadata !43}
!43 = metadata !{metadata !"0x24\00int\000\0032\0032\000\000\005", null, null} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!44 = metadata !{metadata !45}
!45 = metadata !{metadata !"0x34\00Global\00Global\00\007\000\001", null, metadata !27, metadata !43, i32* @Global, null} ; [ DW_TAG_variable ] [Global] [line 7] [def]
!46 = metadata !{i32 2, metadata !"Dwarf Version", i32 2}
!47 = metadata !{i32 2, metadata !"Debug Info Version", i32 2}
!48 = metadata !{metadata !"clang version 3.6.0 (221053)"}
!49 = metadata !{metadata !"0x100\00i\0010\000", metadata !26, metadata !27, metadata !43} ; [ DW_TAG_auto_variable ] [i] [line 10]
!50 = metadata !{metadata !"0x102"}               ; [ DW_TAG_expression ]
!51 = metadata !{i32 10, i32 9, metadata !26, null}
!52 = metadata !{i32 10, i32 5, metadata !26, null}
!53 = metadata !{i32 11, i32 5, metadata !26, null}
!54 = metadata !{i32 12, i32 5, metadata !55, null}
!55 = metadata !{metadata !"0xb\0011\0018\000", metadata !1, metadata !26} ; [ DW_TAG_lexical_block ] [/Users/arunk/Code/LLVM/test_cases/Example_7/test.cpp]
!56 = metadata !{metadata !"0x100\00temp\0013\000", metadata !55, metadata !27, metadata !43} ; [ DW_TAG_auto_variable ] [temp] [line 13]
!57 = metadata !{i32 13, i32 13, metadata !55, null}
!58 = metadata !{i32 13, i32 9, metadata !55, null}
!59 = metadata !{i32 14, i32 5, metadata !55, null}
!60 = metadata !{i32 16, i32 9, metadata !55, null}
!61 = metadata !{i32 17, i32 5, metadata !55, null}
!62 = metadata !{i32 19, i32 9, metadata !55, null}
!63 = metadata !{i32 21, i32 1, metadata !26, null}
!64 = metadata !{metadata !"0x101\00x\0016777239\000", metadata !30, metadata !27, metadata !22} ; [ DW_TAG_arg_variable ] [x] [line 23]
!65 = metadata !{i32 23, i32 21, metadata !30, null}
!66 = metadata !{i32 24, i32 5, metadata !30, null}
!67 = metadata !{i32 25, i32 5, metadata !30, null}
!68 = metadata !{i32 26, i32 5, metadata !30, null}
!69 = metadata !{metadata !"0x101\00t\0016777247\000", metadata !33, metadata !27, metadata !36} ; [ DW_TAG_arg_variable ] [t] [line 31]
!70 = metadata !{i32 31, i32 29, metadata !33, null}
!71 = metadata !{i32 32, i32 9, metadata !33, null}
!72 = metadata !{i32 33, i32 9, metadata !33, null}
!73 = metadata !{i32 39, i32 5, metadata !40, null}
!74 = metadata !{i32 40, i32 5, metadata !40, null}
!75 = metadata !{metadata !"0x100\00t\0042\000", metadata !40, metadata !27, metadata !76} ; [ DW_TAG_auto_variable ] [t] [line 42]
!76 = metadata !{metadata !"0x1\00\000\0064\0064\000\000\000", null, null, metadata !36, metadata !77, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 64, align 64, offset 0] [from pthread_t]
!77 = metadata !{metadata !78}
!78 = metadata !{metadata !"0x21\000\001"}        ; [ DW_TAG_subrange_type ] [0, 0]
!79 = metadata !{i32 42, i32 15, metadata !40, null}
!80 = metadata !{i32 43, i32 5, metadata !40, null}
!81 = metadata !{i32 44, i32 5, metadata !40, null}
!82 = metadata !{i32 46, i32 5, metadata !40, null}
!83 = metadata !{i32 47, i32 1, metadata !40, null}
