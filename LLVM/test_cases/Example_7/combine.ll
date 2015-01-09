; ModuleID = 'combine.bc'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }
%struct._opaque_pthread_t = type { i64, %struct.__darwin_pthread_handler_rec*, [8176 x i8] }
%struct.__darwin_pthread_handler_rec = type { void (i8*)*, i8*, %struct.__darwin_pthread_handler_rec* }
%struct._opaque_pthread_attr_t = type { i64, [56 x i8] }
%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }
%struct._opaque_pthread_mutexattr_t = type { i64, [8 x i8] }

@Global = global i32 0, align 4
@.str = private unnamed_addr constant [11 x i8] c"Global %d\0A\00", align 1
@.str1 = private unnamed_addr constant [9 x i8] c"Temp %d\0A\00", align 1
@.str2 = private unnamed_addr constant [18 x i8] c"Final Value : %d\0A\00", align 1
@init = global i32 0, align 4
@.str3 = private unnamed_addr constant [6 x i8] c"%p %d\00", align 1
@.str14 = private unnamed_addr constant [8 x i8] c"HERE!!\0A\00", align 1
@.str25 = private unnamed_addr constant [11 x i8] c"func_entry\00", align 1
@.str36 = private unnamed_addr constant [10 x i8] c"func_exit\00", align 1
@.str4 = private unnamed_addr constant [4 x i8] c"l%p\00", align 1
@__arunk_unlock.str = private unnamed_addr constant [100 x i8] c"unlock \00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", align 16
@.str5 = private unnamed_addr constant [4 x i8] c"t%u\00", align 1
@mutexCounter = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@write_to_file.filename = private unnamed_addr constant [9 x i8] c"test.log\00", align 1
@.str6 = private unnamed_addr constant [2 x i8] c"a\00", align 1
@.str7 = private unnamed_addr constant [21 x i8] c"Error opening file!\0A\00", align 1
@.str8 = private unnamed_addr constant [8 x i8] c"t%u %s\0A\00", align 1

; Function Attrs: ssp uwtable
define void @_Z11inc_counterv() #0 {
entry:
  call void @__arunk_init()
  %i = alloca i32, align 4
  %temp = alloca i32, align 4
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !49, metadata !50), !dbg !51
  %0 = bitcast i32* %i to i8*, !dbg !52
  call void @__arunk_write4(i8* %0), !dbg !52
  store i32 0, i32* %i, align 4, !dbg !52
  br label %while.cond, !dbg !53

while.cond:                                       ; preds = %while.body, %entry
  %1 = bitcast i32* %i to i8*, !dbg !53
  call void @__arunk_read4(i8* %1), !dbg !53
  %2 = load i32* %i, align 4, !dbg !53
  %cmp = icmp slt i32 %2, 1, !dbg !53
  br i1 %cmp, label %while.body, label %while.end, !dbg !53

while.body:                                       ; preds = %while.cond
  call void @__arunk_read4(i8* bitcast (i32* @Global to i8*)), !dbg !54
  %3 = load i32* @Global, align 4, !dbg !54
  %call = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str, i32 0, i32 0), i32 %3), !dbg !54
  call void @llvm.dbg.declare(metadata !{i32* %temp}, metadata !56, metadata !50), !dbg !57
  call void @__arunk_read4(i8* bitcast (i32* @Global to i8*)), !dbg !58
  %4 = load i32* @Global, align 4, !dbg !58
  %add = add nsw i32 %4, 1, !dbg !58
  %5 = bitcast i32* %temp to i8*, !dbg !58
  call void @__arunk_write4(i8* %5), !dbg !58
  store i32 %add, i32* %temp, align 4, !dbg !58
  %6 = bitcast i32* %temp to i8*, !dbg !59
  call void @__arunk_read4(i8* %6), !dbg !59
  %7 = load i32* %temp, align 4, !dbg !59
  %call1 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str1, i32 0, i32 0), i32 %7), !dbg !59
  %8 = bitcast i32* %temp to i8*, !dbg !60
  call void @__arunk_read4(i8* %8), !dbg !60
  %9 = load i32* %temp, align 4, !dbg !60
  call void @__arunk_write4(i8* bitcast (i32* @Global to i8*)), !dbg !60
  store i32 %9, i32* @Global, align 4, !dbg !60
  call void @__arunk_read4(i8* bitcast (i32* @Global to i8*)), !dbg !61
  %10 = load i32* @Global, align 4, !dbg !61
  %call2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str, i32 0, i32 0), i32 %10), !dbg !61
  %11 = load i32* %i, align 4, !dbg !62
  %inc = add nsw i32 %11, 1, !dbg !62
  %12 = bitcast i32* %i to i8*, !dbg !62
  call void @__arunk_write4(i8* %12), !dbg !62
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
  call void @__arunk_init()
  %x.addr = alloca i8*, align 8
  %0 = bitcast i8** %x.addr to i8*
  call void @__arunk_write8(i8* %0)
  store i8* %x, i8** %x.addr, align 8
  call void @llvm.dbg.declare(metadata !{i8** %x.addr}, metadata !64, metadata !50), !dbg !65
  call void @__arunk_read4(i8* bitcast (i32* @Global to i8*)), !dbg !66
  %1 = load i32* @Global, align 4, !dbg !66
  %call = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str, i32 0, i32 0), i32 %1), !dbg !66
  call void @_Z11inc_counterv(), !dbg !67
  ret i8* null, !dbg !68
}

; Function Attrs: ssp uwtable
define void @missed_1(%struct._opaque_pthread_t* %t) #0 {
entry:
  %0 = call i8* @llvm.returnaddress(i32 0)
  call void @__arunk_func_entry(i8* %0)
  call void @__arunk_init()
  %t.addr = alloca %struct._opaque_pthread_t*, align 8
  %1 = bitcast %struct._opaque_pthread_t** %t.addr to i8*
  call void @__arunk_write8(i8* %1)
  store %struct._opaque_pthread_t* %t, %struct._opaque_pthread_t** %t.addr, align 8
  call void @llvm.dbg.declare(metadata !{%struct._opaque_pthread_t** %t.addr}, metadata !69, metadata !50), !dbg !70
  %call = call i32 @pthread_create(%struct._opaque_pthread_t** %t.addr, %struct._opaque_pthread_attr_t* null, i8* (i8*)* @_Z7Thread1Pv, i8* null), !dbg !71
  %2 = bitcast %struct._opaque_pthread_t** %t.addr to i8*, !dbg !72
  call void @__arunk_create(i8* %2), !dbg !72
  call void bitcast (void (i8*)* @__arunk_func_exit to void ()*)(), !dbg !72
  ret void, !dbg !72
}

declare i32 @pthread_create(%struct._opaque_pthread_t**, %struct._opaque_pthread_attr_t*, i8* (i8*)*, i8*) #2

; Function Attrs: ssp uwtable
define i32 @main() #0 {
entry:
  call void @__arunk_init()
  %t = alloca [1 x %struct._opaque_pthread_t*], align 8
  call void @_Z11inc_counterv(), !dbg !73
  call void @__arunk_read4(i8* bitcast (i32* @Global to i8*)), !dbg !74
  %0 = load i32* @Global, align 4, !dbg !74
  %call = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str2, i32 0, i32 0), i32 %0), !dbg !74
  call void @llvm.dbg.declare(metadata !{[1 x %struct._opaque_pthread_t*]* %t}, metadata !75, metadata !50), !dbg !79
  %arrayidx = getelementptr inbounds [1 x %struct._opaque_pthread_t*]* %t, i32 0, i64 0, !dbg !80
  %1 = bitcast %struct._opaque_pthread_t** %arrayidx to i8*, !dbg !80
  call void @__arunk_read8(i8* %1), !dbg !80
  %2 = load %struct._opaque_pthread_t** %arrayidx, align 8, !dbg !80
  call void @missed_1(%struct._opaque_pthread_t* %2), !dbg !80
  %arrayidx1 = getelementptr inbounds [1 x %struct._opaque_pthread_t*]* %t, i32 0, i64 0, !dbg !81
  %3 = bitcast %struct._opaque_pthread_t** %arrayidx1 to i8*, !dbg !81
  call void @__arunk_read8(i8* %3), !dbg !81
  %4 = load %struct._opaque_pthread_t** %arrayidx1, align 8, !dbg !81
  %call2 = call i32 @"\01_pthread_join"(%struct._opaque_pthread_t* %4, i8** null), !dbg !81
  %5 = bitcast %struct._opaque_pthread_t* %4 to i8*, !dbg !82
  call void @__arunk_join(i8* %5), !dbg !82
  call void @__arunk_read4(i8* bitcast (i32* @Global to i8*)), !dbg !82
  %6 = load i32* @Global, align 4, !dbg !82
  %call3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str2, i32 0, i32 0), i32 %6), !dbg !82
  ret i32 0, !dbg !83
}

declare i32 @"\01_pthread_join"(%struct._opaque_pthread_t*, i8**) #2

declare void @__arunk_read1(i8*)

declare void @__arunk_write1(i8*)

declare i8 @__arunk_atomic8_load(i8*, i32)

declare void @__arunk_atomic8_store(i8*, i8, i32)

declare i8 @__arunk_atomic8_exchange(i8*, i8, i32)

declare i8 @__arunk_atomic8_fetch_add(i8*, i8, i32)

declare i8 @__arunk_atomic8_fetch_sub(i8*, i8, i32)

declare i8 @__arunk_atomic8_fetch_and(i8*, i8, i32)

declare i8 @__arunk_atomic8_fetch_nand(i8*, i8, i32)

declare i8 @__arunk_atomic8_fetch_or(i8*, i8, i32)

declare i8 @__arunk_atomic8_fetch_xor(i8*, i8, i32)

declare i8 @__arunk_atomic8_compare_exchange_val(i8*, i8, i8, i32, i32)

declare void @__arunk_read2(i8*)

declare void @__arunk_write2(i8*)

declare i16 @__arunk_atomic16_load(i16*, i32)

declare void @__arunk_atomic16_store(i16*, i16, i32)

declare i16 @__arunk_atomic16_exchange(i16*, i16, i32)

declare i16 @__arunk_atomic16_fetch_add(i16*, i16, i32)

declare i16 @__arunk_atomic16_fetch_sub(i16*, i16, i32)

declare i16 @__arunk_atomic16_fetch_and(i16*, i16, i32)

declare i16 @__arunk_atomic16_fetch_nand(i16*, i16, i32)

declare i16 @__arunk_atomic16_fetch_or(i16*, i16, i32)

declare i16 @__arunk_atomic16_fetch_xor(i16*, i16, i32)

declare i16 @__arunk_atomic16_compare_exchange_val(i16*, i16, i16, i32, i32)

declare i32 @__arunk_atomic32_load(i32*, i32)

declare void @__arunk_atomic32_store(i32*, i32, i32)

declare i32 @__arunk_atomic32_exchange(i32*, i32, i32)

declare i32 @__arunk_atomic32_fetch_add(i32*, i32, i32)

declare i32 @__arunk_atomic32_fetch_sub(i32*, i32, i32)

declare i32 @__arunk_atomic32_fetch_and(i32*, i32, i32)

declare i32 @__arunk_atomic32_fetch_nand(i32*, i32, i32)

declare i32 @__arunk_atomic32_fetch_or(i32*, i32, i32)

declare i32 @__arunk_atomic32_fetch_xor(i32*, i32, i32)

declare i32 @__arunk_atomic32_compare_exchange_val(i32*, i32, i32, i32, i32)

declare i64 @__arunk_atomic64_load(i64*, i32)

declare void @__arunk_atomic64_store(i64*, i64, i32)

declare i64 @__arunk_atomic64_exchange(i64*, i64, i32)

declare i64 @__arunk_atomic64_fetch_add(i64*, i64, i32)

declare i64 @__arunk_atomic64_fetch_sub(i64*, i64, i32)

declare i64 @__arunk_atomic64_fetch_and(i64*, i64, i32)

declare i64 @__arunk_atomic64_fetch_nand(i64*, i64, i32)

declare i64 @__arunk_atomic64_fetch_or(i64*, i64, i32)

declare i64 @__arunk_atomic64_fetch_xor(i64*, i64, i32)

declare i64 @__arunk_atomic64_compare_exchange_val(i64*, i64, i64, i32, i32)

declare void @__arunk_read16(i8*)

declare void @__arunk_write16(i8*)

declare i128 @__arunk_atomic128_load(i128*, i32)

declare void @__arunk_atomic128_store(i128*, i128, i32)

declare i128 @__arunk_atomic128_exchange(i128*, i128, i32)

declare i128 @__arunk_atomic128_fetch_add(i128*, i128, i32)

declare i128 @__arunk_atomic128_fetch_sub(i128*, i128, i32)

declare i128 @__arunk_atomic128_fetch_and(i128*, i128, i32)

declare i128 @__arunk_atomic128_fetch_nand(i128*, i128, i32)

declare i128 @__arunk_atomic128_fetch_or(i128*, i128, i32)

declare i128 @__arunk_atomic128_fetch_xor(i128*, i128, i32)

declare i128 @__arunk_atomic128_compare_exchange_val(i128*, i128, i128, i32, i32)

declare void @__arunk_vptr_update(i8*, i8*)

declare void @__arunk_vptr_read(i8*)

declare void @__arunk_atomic_thread_fence(i32)

declare void @__arunk_atomic_signal_fence(i32)

declare i8* @memmove(i8*, i8*, i64)

declare i8* @memcpy(i8*, i8*, i64)

declare i8* @memset(i8*, i32, i64)

; Function Attrs: nounwind readnone
declare i8* @llvm.returnaddress(i32) #1

; Function Attrs: nounwind ssp uwtable
define void @__arunk_read(i8* %addr) #3 {
entry:
  %addr.addr = alloca i8*, align 8
  %str = alloca [100 x i8], align 16
  %address = alloca [200 x i8], align 16
  store i8* %addr, i8** %addr.addr, align 8
  %0 = bitcast [100 x i8]* %str to i8*
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 100, i32 16, i1 false)
  %1 = bitcast i8* %0 to [100 x i8]*
  %2 = getelementptr [100 x i8]* %1, i32 0, i32 0
  store i8 114, i8* %2
  %3 = getelementptr [100 x i8]* %1, i32 0, i32 1
  store i8 101, i8* %3
  %4 = getelementptr [100 x i8]* %1, i32 0, i32 2
  store i8 97, i8* %4
  %5 = getelementptr [100 x i8]* %1, i32 0, i32 3
  store i8 100, i8* %5
  %6 = getelementptr [100 x i8]* %1, i32 0, i32 4
  store i8 32, i8* %6
  %arraydecay = getelementptr inbounds [200 x i8]* %address, i32 0, i32 0
  %7 = load i8** %addr.addr, align 8
  %8 = load i8** %addr.addr, align 8
  %9 = bitcast i8* %8 to i32*
  %10 = load i32* %9, align 4
  %call = call i32 (i8*, i32, i64, i8*, ...)* @__sprintf_chk(i8* %arraydecay, i32 0, i64 200, i8* getelementptr inbounds ([6 x i8]* @.str3, i32 0, i32 0), i8* %7, i32 %10)
  %arraydecay1 = getelementptr inbounds [100 x i8]* %str, i32 0, i32 0
  %arraydecay2 = getelementptr inbounds [200 x i8]* %address, i32 0, i32 0
  %call3 = call i8* @__strcat_chk(i8* %arraydecay1, i8* %arraydecay2, i64 100) #4
  %arraydecay4 = getelementptr inbounds [100 x i8]* %str, i32 0, i32 0
  call void @write_to_file(i8* %arraydecay4)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #4

declare i32 @__sprintf_chk(i8*, i32, i64, i8*, ...) #2

; Function Attrs: nounwind
declare i8* @__strcat_chk(i8*, i8*, i64) #5

; Function Attrs: nounwind ssp uwtable
define void @write_to_file(i8* %text) #3 {
entry:
  %text.addr = alloca i8*, align 8
  %filename = alloca [9 x i8], align 1
  %f = alloca %struct.__sFILE*, align 8
  store i8* %text, i8** %text.addr, align 8
  %call = call i32 @pthread_mutex_lock(%struct._opaque_pthread_mutex_t* @mutexCounter)
  %0 = bitcast [9 x i8]* %filename to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([9 x i8]* @write_to_file.filename, i32 0, i32 0), i64 9, i32 1, i1 false)
  %arraydecay = getelementptr inbounds [9 x i8]* %filename, i32 0, i32 0
  %call1 = call %struct.__sFILE* @"\01_fopen"(i8* %arraydecay, i8* getelementptr inbounds ([2 x i8]* @.str6, i32 0, i32 0))
  store %struct.__sFILE* %call1, %struct.__sFILE** %f, align 8
  %1 = load %struct.__sFILE** %f, align 8
  %cmp = icmp eq %struct.__sFILE* %1, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str7, i32 0, i32 0))
  call void @exit(i32 1) #7
  unreachable

if.end:                                           ; preds = %entry
  %2 = load %struct.__sFILE** %f, align 8
  %call3 = call %struct._opaque_pthread_t* @pthread_self()
  %3 = ptrtoint %struct._opaque_pthread_t* %call3 to i32
  %4 = load i8** %text.addr, align 8
  %call4 = call i32 (%struct.__sFILE*, i8*, ...)* @fprintf(%struct.__sFILE* %2, i8* getelementptr inbounds ([8 x i8]* @.str8, i32 0, i32 0), i32 %3, i8* %4)
  %5 = load %struct.__sFILE** %f, align 8
  %call5 = call i32 @fclose(%struct.__sFILE* %5)
  %call6 = call i32 @pthread_mutex_unlock(%struct._opaque_pthread_mutex_t* @mutexCounter)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @__arunk_read4(i8* %addr) #3 {
entry:
  %addr.addr = alloca i8*, align 8
  store i8* %addr, i8** %addr.addr, align 8
  %0 = load i8** %addr.addr, align 8
  call void @__arunk_read(i8* %0)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @__arunk_read8(i8* %addr) #3 {
entry:
  %addr.addr = alloca i8*, align 8
  store i8* %addr, i8** %addr.addr, align 8
  %0 = load i8** %addr.addr, align 8
  call void @__arunk_read(i8* %0)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @__arunk_write4(i8* %addr) #3 {
entry:
  %addr.addr = alloca i8*, align 8
  store i8* %addr, i8** %addr.addr, align 8
  %0 = load i8** %addr.addr, align 8
  call void @__arunk_write(i8* %0)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @__arunk_write(i8* %addr) #3 {
entry:
  %addr.addr = alloca i8*, align 8
  %str = alloca [100 x i8], align 16
  %address = alloca [200 x i8], align 16
  store i8* %addr, i8** %addr.addr, align 8
  %0 = bitcast [100 x i8]* %str to i8*
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 100, i32 16, i1 false)
  %1 = bitcast i8* %0 to [100 x i8]*
  %2 = getelementptr [100 x i8]* %1, i32 0, i32 0
  store i8 119, i8* %2
  %3 = getelementptr [100 x i8]* %1, i32 0, i32 1
  store i8 114, i8* %3
  %4 = getelementptr [100 x i8]* %1, i32 0, i32 2
  store i8 105, i8* %4
  %5 = getelementptr [100 x i8]* %1, i32 0, i32 3
  store i8 116, i8* %5
  %6 = getelementptr [100 x i8]* %1, i32 0, i32 4
  store i8 101, i8* %6
  %7 = getelementptr [100 x i8]* %1, i32 0, i32 5
  store i8 32, i8* %7
  %arraydecay = getelementptr inbounds [200 x i8]* %address, i32 0, i32 0
  %8 = load i8** %addr.addr, align 8
  %9 = load i8** %addr.addr, align 8
  %10 = bitcast i8* %9 to i32*
  %11 = load i32* %10, align 4
  %call = call i32 (i8*, i64, i32, i64, i8*, ...)* @__snprintf_chk(i8* %arraydecay, i64 199, i32 0, i64 200, i8* getelementptr inbounds ([6 x i8]* @.str3, i32 0, i32 0), i8* %8, i32 %11)
  %arraydecay1 = getelementptr inbounds [100 x i8]* %str, i32 0, i32 0
  %arraydecay2 = getelementptr inbounds [200 x i8]* %address, i32 0, i32 0
  %call3 = call i8* @__strcat_chk(i8* %arraydecay1, i8* %arraydecay2, i64 100) #4
  %arraydecay4 = getelementptr inbounds [100 x i8]* %str, i32 0, i32 0
  call void @write_to_file(i8* %arraydecay4)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @__arunk_write8(i8* %addr) #3 {
entry:
  %addr.addr = alloca i8*, align 8
  store i8* %addr, i8** %addr.addr, align 8
  %0 = load i8** %addr.addr, align 8
  call void @__arunk_write(i8* %0)
  ret void
}

declare i32 @__snprintf_chk(i8*, i64, i32, i64, i8*, ...) #2

; Function Attrs: nounwind ssp uwtable
define void @__arunk_set_line_num(i8* %line) #3 {
entry:
  %line.addr = alloca i8*, align 8
  store i8* %line, i8** %line.addr, align 8
  %call = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str14, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @__arunk_func_entry(i8* %func_name) #3 {
entry:
  %func_name.addr = alloca i8*, align 8
  store i8* %func_name, i8** %func_name.addr, align 8
  call void @write_to_file(i8* getelementptr inbounds ([11 x i8]* @.str25, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @__arunk_func_exit(i8* %thr) #3 {
entry:
  %thr.addr = alloca i8*, align 8
  store i8* %thr, i8** %thr.addr, align 8
  call void @write_to_file(i8* getelementptr inbounds ([10 x i8]* @.str36, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @__arunk_lock(i8* %lock) #3 {
entry:
  %lock.addr = alloca i8*, align 8
  %str = alloca [100 x i8], align 16
  %address = alloca [20 x i8], align 16
  store i8* %lock, i8** %lock.addr, align 8
  %0 = bitcast [100 x i8]* %str to i8*
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 100, i32 16, i1 false)
  %1 = bitcast i8* %0 to [100 x i8]*
  %2 = getelementptr [100 x i8]* %1, i32 0, i32 0
  store i8 108, i8* %2
  %3 = getelementptr [100 x i8]* %1, i32 0, i32 1
  store i8 111, i8* %3
  %4 = getelementptr [100 x i8]* %1, i32 0, i32 2
  store i8 99, i8* %4
  %5 = getelementptr [100 x i8]* %1, i32 0, i32 3
  store i8 107, i8* %5
  %6 = getelementptr [100 x i8]* %1, i32 0, i32 4
  store i8 32, i8* %6
  %arraydecay = getelementptr inbounds [20 x i8]* %address, i32 0, i32 0
  %7 = load i8** %lock.addr, align 8
  %call = call i32 (i8*, i32, i64, i8*, ...)* @__sprintf_chk(i8* %arraydecay, i32 0, i64 20, i8* getelementptr inbounds ([4 x i8]* @.str4, i32 0, i32 0), i8* %7)
  %arraydecay1 = getelementptr inbounds [100 x i8]* %str, i32 0, i32 0
  %arraydecay2 = getelementptr inbounds [20 x i8]* %address, i32 0, i32 0
  %call3 = call i8* @__strcat_chk(i8* %arraydecay1, i8* %arraydecay2, i64 100) #4
  %arraydecay4 = getelementptr inbounds [100 x i8]* %str, i32 0, i32 0
  call void @write_to_file(i8* %arraydecay4)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @__arunk_unlock(i8* %lock) #3 {
entry:
  %lock.addr = alloca i8*, align 8
  %str = alloca [100 x i8], align 16
  %address = alloca [20 x i8], align 16
  store i8* %lock, i8** %lock.addr, align 8
  %0 = bitcast [100 x i8]* %str to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([100 x i8]* @__arunk_unlock.str, i32 0, i32 0), i64 100, i32 16, i1 false)
  %arraydecay = getelementptr inbounds [20 x i8]* %address, i32 0, i32 0
  %1 = load i8** %lock.addr, align 8
  %call = call i32 (i8*, i32, i64, i8*, ...)* @__sprintf_chk(i8* %arraydecay, i32 0, i64 20, i8* getelementptr inbounds ([4 x i8]* @.str4, i32 0, i32 0), i8* %1)
  %arraydecay1 = getelementptr inbounds [100 x i8]* %str, i32 0, i32 0
  %arraydecay2 = getelementptr inbounds [20 x i8]* %address, i32 0, i32 0
  %call3 = call i8* @__strcat_chk(i8* %arraydecay1, i8* %arraydecay2, i64 100) #4
  %arraydecay4 = getelementptr inbounds [100 x i8]* %str, i32 0, i32 0
  call void @write_to_file(i8* %arraydecay4)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #4

; Function Attrs: nounwind ssp uwtable
define void @__arunk_create(i8* %t) #3 {
entry:
  %t.addr = alloca i8*, align 8
  %str = alloca [100 x i8], align 16
  %address = alloca [20 x i8], align 16
  store i8* %t, i8** %t.addr, align 8
  %0 = bitcast [100 x i8]* %str to i8*
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 100, i32 16, i1 false)
  %1 = bitcast i8* %0 to [100 x i8]*
  %2 = getelementptr [100 x i8]* %1, i32 0, i32 0
  store i8 102, i8* %2
  %3 = getelementptr [100 x i8]* %1, i32 0, i32 1
  store i8 111, i8* %3
  %4 = getelementptr [100 x i8]* %1, i32 0, i32 2
  store i8 114, i8* %4
  %5 = getelementptr [100 x i8]* %1, i32 0, i32 3
  store i8 107, i8* %5
  %6 = getelementptr [100 x i8]* %1, i32 0, i32 4
  store i8 32, i8* %6
  %arraydecay = getelementptr inbounds [20 x i8]* %address, i32 0, i32 0
  %7 = load i8** %t.addr, align 8
  %8 = bitcast i8* %7 to %struct._opaque_pthread_t**
  %9 = load %struct._opaque_pthread_t** %8, align 8
  %10 = ptrtoint %struct._opaque_pthread_t* %9 to i32
  %call = call i32 (i8*, i32, i64, i8*, ...)* @__sprintf_chk(i8* %arraydecay, i32 0, i64 20, i8* getelementptr inbounds ([4 x i8]* @.str5, i32 0, i32 0), i32 %10)
  %arraydecay1 = getelementptr inbounds [100 x i8]* %str, i32 0, i32 0
  %arraydecay2 = getelementptr inbounds [20 x i8]* %address, i32 0, i32 0
  %call3 = call i8* @__strcat_chk(i8* %arraydecay1, i8* %arraydecay2, i64 100) #4
  %arraydecay4 = getelementptr inbounds [100 x i8]* %str, i32 0, i32 0
  call void @write_to_file(i8* %arraydecay4)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @__arunk_join(i8* %t) #3 {
entry:
  %t.addr = alloca i8*, align 8
  %str = alloca [100 x i8], align 16
  %address = alloca [20 x i8], align 16
  store i8* %t, i8** %t.addr, align 8
  %0 = bitcast [100 x i8]* %str to i8*
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 100, i32 16, i1 false)
  %1 = bitcast i8* %0 to [100 x i8]*
  %2 = getelementptr [100 x i8]* %1, i32 0, i32 0
  store i8 106, i8* %2
  %3 = getelementptr [100 x i8]* %1, i32 0, i32 1
  store i8 111, i8* %3
  %4 = getelementptr [100 x i8]* %1, i32 0, i32 2
  store i8 105, i8* %4
  %5 = getelementptr [100 x i8]* %1, i32 0, i32 3
  store i8 110, i8* %5
  %6 = getelementptr [100 x i8]* %1, i32 0, i32 4
  store i8 32, i8* %6
  %arraydecay = getelementptr inbounds [20 x i8]* %address, i32 0, i32 0
  %7 = load i8** %t.addr, align 8
  %8 = bitcast i8* %7 to i32*
  %9 = bitcast i32* %8 to %struct._opaque_pthread_t*
  %10 = ptrtoint %struct._opaque_pthread_t* %9 to i32
  %call = call i32 (i8*, i32, i64, i8*, ...)* @__sprintf_chk(i8* %arraydecay, i32 0, i64 20, i8* getelementptr inbounds ([4 x i8]* @.str5, i32 0, i32 0), i32 %10)
  %arraydecay1 = getelementptr inbounds [100 x i8]* %str, i32 0, i32 0
  %arraydecay2 = getelementptr inbounds [20 x i8]* %address, i32 0, i32 0
  %call3 = call i8* @__strcat_chk(i8* %arraydecay1, i8* %arraydecay2, i64 100) #4
  %arraydecay4 = getelementptr inbounds [100 x i8]* %str, i32 0, i32 0
  call void @write_to_file(i8* %arraydecay4)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @__arunk_init() #3 {
entry:
  %0 = load i32* @init, align 4
  %cmp = icmp eq i32 %0, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call = call i32 @pthread_mutex_init(%struct._opaque_pthread_mutex_t* @mutexCounter, %struct._opaque_pthread_mutexattr_t* null)
  store i32 1, i32* @init, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

declare i32 @pthread_mutex_init(%struct._opaque_pthread_mutex_t*, %struct._opaque_pthread_mutexattr_t*) #2

declare i32 @pthread_mutex_lock(%struct._opaque_pthread_mutex_t*) #2

declare %struct.__sFILE* @"\01_fopen"(i8*, i8*) #2

; Function Attrs: noreturn
declare void @exit(i32) #6

declare i32 @fprintf(%struct.__sFILE*, i8*, ...) #2

declare %struct._opaque_pthread_t* @pthread_self() #2

declare i32 @fclose(%struct.__sFILE*) #2

declare i32 @pthread_mutex_unlock(%struct._opaque_pthread_mutex_t*) #2

attributes #0 = { ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { noreturn }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!46, !46}
!llvm.module.flags = !{!47, !48}

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
!46 = metadata !{metadata !"clang version 3.6.0 (221053)"}
!47 = metadata !{i32 2, metadata !"Dwarf Version", i32 2}
!48 = metadata !{i32 2, metadata !"Debug Info Version", i32 2}
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
