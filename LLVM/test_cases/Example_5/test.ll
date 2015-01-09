; ModuleID = 'test.bc'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }
%struct._opaque_pthread_t = type { i64, %struct.__darwin_pthread_handler_rec*, [8176 x i8] }
%struct.__darwin_pthread_handler_rec = type { void (i8*)*, i8*, %struct.__darwin_pthread_handler_rec* }
%struct._opaque_pthread_attr_t = type { i64, [56 x i8] }

@Global = global i32 0, align 4
@lock = global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@y = global i32 0, align 4
@.str = private unnamed_addr constant [18 x i8] c"Final Value : %d\0A\00", align 1

; Function Attrs: nounwind ssp uwtable
define void @_Z11inc_counterv() #0 {
entry:
  %i = alloca i32, align 4
  %temp = alloca i32, align 4
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !56, metadata !57), !dbg !58
  store i32 0, i32* %i, align 4, !dbg !59
  br label %while.cond, !dbg !60

while.cond:                                       ; preds = %while.body, %entry
  %0 = load i32* %i, align 4, !dbg !60
  %cmp = icmp slt i32 %0, 1, !dbg !60
  br i1 %cmp, label %while.body, label %while.end, !dbg !60

while.body:                                       ; preds = %while.cond
  call void @llvm.dbg.declare(metadata !{i32* %temp}, metadata !61, metadata !57), !dbg !63
  %1 = load i32* @Global, align 4, !dbg !64
  %add = add nsw i32 %1, 1, !dbg !64
  store i32 %add, i32* %temp, align 4, !dbg !64
  %2 = load i32* %temp, align 4, !dbg !65
  store i32 %2, i32* @Global, align 4, !dbg !65
  %3 = load i32* %i, align 4, !dbg !66
  %inc = add nsw i32 %3, 1, !dbg !66
  store i32 %inc, i32* %i, align 4, !dbg !66
  br label %while.cond, !dbg !60

while.end:                                        ; preds = %while.cond
  ret void, !dbg !67
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind ssp uwtable
define void @missed_1() #0 {
entry:
  br label %while.cond, !dbg !68

while.cond:                                       ; preds = %while.body, %entry
  %0 = load i32* @y, align 4, !dbg !68
  %cmp = icmp ne i32 %0, 11, !dbg !68
  br i1 %cmp, label %while.body, label %while.end, !dbg !68

while.body:                                       ; preds = %while.cond
  br label %while.cond, !dbg !68

while.end:                                        ; preds = %while.cond
  ret void, !dbg !69
}

; Function Attrs: nounwind ssp uwtable
define void @missed_2() #0 {
entry:
  store i32 11, i32* @y, align 4, !dbg !70
  ret void, !dbg !71
}

; Function Attrs: nounwind ssp uwtable
define i8* @_Z7Thread1Pv(i8* %x) #0 {
entry:
  %x.addr = alloca i8*, align 8
  store i8* %x, i8** %x.addr, align 8
  call void @llvm.dbg.declare(metadata !{i8** %x.addr}, metadata !72, metadata !57), !dbg !73
  call void @missed_1(), !dbg !74
  call void @_Z11inc_counterv(), !dbg !75
  ret i8* null, !dbg !76
}

; Function Attrs: ssp uwtable
define i32 @main() #2 {
entry:
  %t = alloca [1 x %struct._opaque_pthread_t*], align 8
  store i32 10, i32* @y, align 4, !dbg !77
  call void @_Z11inc_counterv(), !dbg !78
  call void @missed_2(), !dbg !79
  call void @llvm.dbg.declare(metadata !{[1 x %struct._opaque_pthread_t*]* %t}, metadata !80, metadata !57), !dbg !88
  %arrayidx = getelementptr inbounds [1 x %struct._opaque_pthread_t*]* %t, i32 0, i64 0, !dbg !89
  %call = call i32 @pthread_create(%struct._opaque_pthread_t** %arrayidx, %struct._opaque_pthread_attr_t* null, i8* (i8*)* @_Z7Thread1Pv, i8* null), !dbg !89
  %arrayidx1 = getelementptr inbounds [1 x %struct._opaque_pthread_t*]* %t, i32 0, i64 0, !dbg !90
  %0 = load %struct._opaque_pthread_t** %arrayidx1, align 8, !dbg !90
  %call2 = call i32 @"\01_pthread_join"(%struct._opaque_pthread_t* %0, i8** null), !dbg !90
  %1 = load i32* @Global, align 4, !dbg !91
  %call3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str, i32 0, i32 0), i32 %1), !dbg !91
  ret i32 0, !dbg !92
}

declare i32 @pthread_create(%struct._opaque_pthread_t**, %struct._opaque_pthread_attr_t*, i8* (i8*)*, i8*) #3

declare i32 @"\01_pthread_join"(%struct._opaque_pthread_t*, i8**) #3

declare i32 @printf(i8*, ...) #3

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!53, !54}
!llvm.ident = !{!55}

!0 = metadata !{metadata !"0x11\004\00clang version 3.6.0 (221053)\000\00\000\00\001", metadata !1, metadata !2, metadata !3, metadata !32, metadata !46, metadata !2} ; [ DW_TAG_compile_unit ] [/Users/arunk/Code/LLVM/test_cases/Example_5/test.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !"test.cpp", metadata !"/Users/arunk/Code/LLVM/test_cases/Example_5"}
!2 = metadata !{}
!3 = metadata !{metadata !4, metadata !14, metadata !23}
!4 = metadata !{metadata !"0x13\00_opaque_pthread_mutex_t\0078\00512\0064\000\000\000", metadata !5, null, null, metadata !6, null, null, metadata !"_ZTS23_opaque_pthread_mutex_t"} ; [ DW_TAG_structure_type ] [_opaque_pthread_mutex_t] [line 78, size 512, align 64, offset 0] [def] [from ]
!5 = metadata !{metadata !"/usr/include/sys/_pthread/_pthread_types.h", metadata !"/Users/arunk/Code/LLVM/test_cases/Example_5"}
!6 = metadata !{metadata !7, metadata !9}
!7 = metadata !{metadata !"0xd\00__sig\0079\0064\0064\000\000", metadata !5, metadata !"_ZTS23_opaque_pthread_mutex_t", metadata !8} ; [ DW_TAG_member ] [__sig] [line 79, size 64, align 64, offset 0] [from long int]
!8 = metadata !{metadata !"0x24\00long int\000\0064\0064\000\000\005", null, null} ; [ DW_TAG_base_type ] [long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!9 = metadata !{metadata !"0xd\00__opaque\0080\00448\008\0064\000", metadata !5, metadata !"_ZTS23_opaque_pthread_mutex_t", metadata !10} ; [ DW_TAG_member ] [__opaque] [line 80, size 448, align 8, offset 64] [from ]
!10 = metadata !{metadata !"0x1\00\000\00448\008\000\000\000", null, null, metadata !11, metadata !12, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 448, align 8, offset 0] [from char]
!11 = metadata !{metadata !"0x24\00char\000\008\008\000\000\006", null, null} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!12 = metadata !{metadata !13}
!13 = metadata !{metadata !"0x21\000\0056"}       ; [ DW_TAG_subrange_type ] [0, 55]
!14 = metadata !{metadata !"0x13\00_opaque_pthread_t\00103\0065536\0064\000\000\000", metadata !5, null, null, metadata !15, null, null, metadata !"_ZTS17_opaque_pthread_t"} ; [ DW_TAG_structure_type ] [_opaque_pthread_t] [line 103, size 65536, align 64, offset 0] [def] [from ]
!15 = metadata !{metadata !16, metadata !17, metadata !19}
!16 = metadata !{metadata !"0xd\00__sig\00104\0064\0064\000\000", metadata !5, metadata !"_ZTS17_opaque_pthread_t", metadata !8} ; [ DW_TAG_member ] [__sig] [line 104, size 64, align 64, offset 0] [from long int]
!17 = metadata !{metadata !"0xd\00__cleanup_stack\00105\0064\0064\0064\000", metadata !5, metadata !"_ZTS17_opaque_pthread_t", metadata !18} ; [ DW_TAG_member ] [__cleanup_stack] [line 105, size 64, align 64, offset 64] [from ]
!18 = metadata !{metadata !"0xf\00\000\0064\0064\000\000", null, null, metadata !"_ZTS28__darwin_pthread_handler_rec"} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from _ZTS28__darwin_pthread_handler_rec]
!19 = metadata !{metadata !"0xd\00__opaque\00106\0065408\008\00128\000", metadata !5, metadata !"_ZTS17_opaque_pthread_t", metadata !20} ; [ DW_TAG_member ] [__opaque] [line 106, size 65408, align 8, offset 128] [from ]
!20 = metadata !{metadata !"0x1\00\000\0065408\008\000\000\000", null, null, metadata !11, metadata !21, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 65408, align 8, offset 0] [from char]
!21 = metadata !{metadata !22}
!22 = metadata !{metadata !"0x21\000\008176"}     ; [ DW_TAG_subrange_type ] [0, 8175]
!23 = metadata !{metadata !"0x13\00__darwin_pthread_handler_rec\0057\00192\0064\000\000\000", metadata !5, null, null, metadata !24, null, null, metadata !"_ZTS28__darwin_pthread_handler_rec"} ; [ DW_TAG_structure_type ] [__darwin_pthread_handler_rec] [line 57, size 192, align 64, offset 0] [def] [from ]
!24 = metadata !{metadata !25, metadata !30, metadata !31}
!25 = metadata !{metadata !"0xd\00__routine\0058\0064\0064\000\000", metadata !5, metadata !"_ZTS28__darwin_pthread_handler_rec", metadata !26} ; [ DW_TAG_member ] [__routine] [line 58, size 64, align 64, offset 0] [from ]
!26 = metadata !{metadata !"0xf\00\000\0064\0064\000\000", null, null, metadata !27} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!27 = metadata !{metadata !"0x15\00\000\000\000\000\000\000", null, null, null, metadata !28, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!28 = metadata !{null, metadata !29}
!29 = metadata !{metadata !"0xf\00\000\0064\0064\000\000", null, null, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!30 = metadata !{metadata !"0xd\00__arg\0059\0064\0064\0064\000", metadata !5, metadata !"_ZTS28__darwin_pthread_handler_rec", metadata !29} ; [ DW_TAG_member ] [__arg] [line 59, size 64, align 64, offset 64] [from ]
!31 = metadata !{metadata !"0xd\00__next\0060\0064\0064\00128\000", metadata !5, metadata !"_ZTS28__darwin_pthread_handler_rec", metadata !18} ; [ DW_TAG_member ] [__next] [line 60, size 64, align 64, offset 128] [from ]
!32 = metadata !{metadata !33, metadata !37, metadata !38, metadata !39, metadata !42}
!33 = metadata !{metadata !"0x2e\00inc_counter\00inc_counter\00_Z11inc_counterv\009\000\001\000\000\00256\000\009", metadata !1, metadata !34, metadata !35, null, void ()* @_Z11inc_counterv, null, null, metadata !2} ; [ DW_TAG_subprogram ] [line 9] [def] [inc_counter]
!34 = metadata !{metadata !"0x29", metadata !1}   ; [ DW_TAG_file_type ] [/Users/arunk/Code/LLVM/test_cases/Example_5/test.cpp]
!35 = metadata !{metadata !"0x15\00\000\000\000\000\000\000", null, null, null, metadata !36, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!36 = metadata !{null}
!37 = metadata !{metadata !"0x2e\00missed_1\00missed_1\00\0019\000\001\000\000\00256\000\0019", metadata !1, metadata !34, metadata !35, null, void ()* @missed_1, null, null, metadata !2} ; [ DW_TAG_subprogram ] [line 19] [def] [missed_1]
!38 = metadata !{metadata !"0x2e\00missed_2\00missed_2\00\0023\000\001\000\000\00256\000\0023", metadata !1, metadata !34, metadata !35, null, void ()* @missed_2, null, null, metadata !2} ; [ DW_TAG_subprogram ] [line 23] [def] [missed_2]
!39 = metadata !{metadata !"0x2e\00Thread1\00Thread1\00_Z7Thread1Pv\0029\000\001\000\000\00256\000\0029", metadata !1, metadata !34, metadata !40, null, i8* (i8*)* @_Z7Thread1Pv, null, null, metadata !2} ; [ DW_TAG_subprogram ] [line 29] [def] [Thread1]
!40 = metadata !{metadata !"0x15\00\000\000\000\000\000\000", null, null, null, metadata !41, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!41 = metadata !{metadata !29, metadata !29}
!42 = metadata !{metadata !"0x2e\00main\00main\00\0035\000\001\000\000\00256\000\0035", metadata !1, metadata !34, metadata !43, null, i32 ()* @main, null, null, metadata !2} ; [ DW_TAG_subprogram ] [line 35] [def] [main]
!43 = metadata !{metadata !"0x15\00\000\000\000\000\000\000", null, null, null, metadata !44, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!44 = metadata !{metadata !45}
!45 = metadata !{metadata !"0x24\00int\000\0032\0032\000\000\005", null, null} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!46 = metadata !{metadata !47, metadata !48, metadata !52}
!47 = metadata !{metadata !"0x34\00Global\00Global\00\005\000\001", null, metadata !34, metadata !45, i32* @Global, null} ; [ DW_TAG_variable ] [Global] [line 5] [def]
!48 = metadata !{metadata !"0x34\00lock\00lock\00\006\000\001", null, metadata !34, metadata !49, %struct._opaque_pthread_mutex_t* @lock, null} ; [ DW_TAG_variable ] [lock] [line 6] [def]
!49 = metadata !{metadata !"0x16\00pthread_mutex_t\0030\000\000\000\000", metadata !50, null, metadata !51} ; [ DW_TAG_typedef ] [pthread_mutex_t] [line 30, size 0, align 0, offset 0] [from __darwin_pthread_mutex_t]
!50 = metadata !{metadata !"/usr/include/sys/_pthread/_pthread_mutex_t.h", metadata !"/Users/arunk/Code/LLVM/test_cases/Example_5"}
!51 = metadata !{metadata !"0x16\00__darwin_pthread_mutex_t\00113\000\000\000\000", metadata !5, null, metadata !"_ZTS23_opaque_pthread_mutex_t"} ; [ DW_TAG_typedef ] [__darwin_pthread_mutex_t] [line 113, size 0, align 0, offset 0] [from _ZTS23_opaque_pthread_mutex_t]
!52 = metadata !{metadata !"0x34\00y\00y\00\007\000\001", null, metadata !34, metadata !45, i32* @y, null} ; [ DW_TAG_variable ] [y] [line 7] [def]
!53 = metadata !{i32 2, metadata !"Dwarf Version", i32 2}
!54 = metadata !{i32 2, metadata !"Debug Info Version", i32 2}
!55 = metadata !{metadata !"clang version 3.6.0 (221053)"}
!56 = metadata !{metadata !"0x100\00i\0010\000", metadata !33, metadata !34, metadata !45} ; [ DW_TAG_auto_variable ] [i] [line 10]
!57 = metadata !{metadata !"0x102"}               ; [ DW_TAG_expression ]
!58 = metadata !{i32 10, i32 9, metadata !33, null}
!59 = metadata !{i32 10, i32 5, metadata !33, null}
!60 = metadata !{i32 11, i32 5, metadata !33, null}
!61 = metadata !{metadata !"0x100\00temp\0012\000", metadata !62, metadata !34, metadata !45} ; [ DW_TAG_auto_variable ] [temp] [line 12]
!62 = metadata !{metadata !"0xb\0011\0018\000", metadata !1, metadata !33} ; [ DW_TAG_lexical_block ] [/Users/arunk/Code/LLVM/test_cases/Example_5/test.cpp]
!63 = metadata !{i32 12, i32 13, metadata !62, null}
!64 = metadata !{i32 12, i32 9, metadata !62, null}
!65 = metadata !{i32 13, i32 9, metadata !62, null}
!66 = metadata !{i32 14, i32 9, metadata !62, null}
!67 = metadata !{i32 16, i32 1, metadata !33, null}
!68 = metadata !{i32 20, i32 9, metadata !37, null}
!69 = metadata !{i32 21, i32 5, metadata !37, null}
!70 = metadata !{i32 24, i32 9, metadata !38, null}
!71 = metadata !{i32 25, i32 5, metadata !38, null}
!72 = metadata !{metadata !"0x101\00x\0016777245\000", metadata !39, metadata !34, metadata !29} ; [ DW_TAG_arg_variable ] [x] [line 29]
!73 = metadata !{i32 29, i32 21, metadata !39, null}
!74 = metadata !{i32 30, i32 5, metadata !39, null}
!75 = metadata !{i32 31, i32 5, metadata !39, null}
!76 = metadata !{i32 32, i32 5, metadata !39, null}
!77 = metadata !{i32 36, i32 5, metadata !42, null}
!78 = metadata !{i32 38, i32 5, metadata !42, null}
!79 = metadata !{i32 39, i32 5, metadata !42, null}
!80 = metadata !{metadata !"0x100\00t\0041\000", metadata !42, metadata !34, metadata !81} ; [ DW_TAG_auto_variable ] [t] [line 41]
!81 = metadata !{metadata !"0x1\00\000\0064\0064\000\000\000", null, null, metadata !82, metadata !86, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 64, align 64, offset 0] [from pthread_t]
!82 = metadata !{metadata !"0x16\00pthread_t\0030\000\000\000\000", metadata !83, null, metadata !84} ; [ DW_TAG_typedef ] [pthread_t] [line 30, size 0, align 0, offset 0] [from __darwin_pthread_t]
!83 = metadata !{metadata !"/usr/include/sys/_pthread/_pthread_t.h", metadata !"/Users/arunk/Code/LLVM/test_cases/Example_5"}
!84 = metadata !{metadata !"0x16\00__darwin_pthread_t\00118\000\000\000\000", metadata !5, null, metadata !85} ; [ DW_TAG_typedef ] [__darwin_pthread_t] [line 118, size 0, align 0, offset 0] [from ]
!85 = metadata !{metadata !"0xf\00\000\0064\0064\000\000", null, null, metadata !"_ZTS17_opaque_pthread_t"} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from _ZTS17_opaque_pthread_t]
!86 = metadata !{metadata !87}
!87 = metadata !{metadata !"0x21\000\001"}        ; [ DW_TAG_subrange_type ] [0, 0]
!88 = metadata !{i32 41, i32 15, metadata !42, null}
!89 = metadata !{i32 42, i32 5, metadata !42, null}
!90 = metadata !{i32 44, i32 5, metadata !42, null}
!91 = metadata !{i32 45, i32 5, metadata !42, null}
!92 = metadata !{i32 46, i32 1, metadata !42, null}
