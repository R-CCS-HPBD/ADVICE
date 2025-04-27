; ModuleID = 'verify.c'
source_filename = "verify.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dcomplex = type { double, double }

@.str = private unnamed_addr constant [42 x i8] c"  Verification test for FT not performed\0A\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"kt == %d \0A \00", align 1
@.str.2 = private unnamed_addr constant [38 x i8] c" Verification test for FT successful\0A\00", align 1
@.str.3 = private unnamed_addr constant [34 x i8] c" Verification test for FT failed\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @verify(i32 %n1, i32 %n2, i32 %n3, i32 %nt, %struct.dcomplex* %cksum, i32* %verified) #0 !dbg !15 {
entry:
  %n1.addr = alloca i32, align 4
  %n2.addr = alloca i32, align 4
  %n3.addr = alloca i32, align 4
  %nt.addr = alloca i32, align 4
  %cksum.addr = alloca %struct.dcomplex*, align 8
  %verified.addr = alloca i32*, align 8
  %kt = alloca i32, align 4
  %cexpd = alloca [26 x %struct.dcomplex], align 16
  %epsilon = alloca double, align 8
  %err = alloca double, align 8
  %.compoundliteral = alloca %struct.dcomplex, align 8
  %.compoundliteral7 = alloca %struct.dcomplex, align 8
  %.compoundliteral11 = alloca %struct.dcomplex, align 8
  %.compoundliteral15 = alloca %struct.dcomplex, align 8
  %.compoundliteral19 = alloca %struct.dcomplex, align 8
  %.compoundliteral23 = alloca %struct.dcomplex, align 8
  %.compoundliteral35 = alloca %struct.dcomplex, align 8
  %.compoundliteral39 = alloca %struct.dcomplex, align 8
  %.compoundliteral43 = alloca %struct.dcomplex, align 8
  %.compoundliteral47 = alloca %struct.dcomplex, align 8
  %.compoundliteral51 = alloca %struct.dcomplex, align 8
  %.compoundliteral55 = alloca %struct.dcomplex, align 8
  %.compoundliteral68 = alloca %struct.dcomplex, align 8
  %.compoundliteral72 = alloca %struct.dcomplex, align 8
  %.compoundliteral76 = alloca %struct.dcomplex, align 8
  %.compoundliteral80 = alloca %struct.dcomplex, align 8
  %.compoundliteral84 = alloca %struct.dcomplex, align 8
  %.compoundliteral88 = alloca %struct.dcomplex, align 8
  %.compoundliteral101 = alloca %struct.dcomplex, align 8
  %.compoundliteral105 = alloca %struct.dcomplex, align 8
  %.compoundliteral109 = alloca %struct.dcomplex, align 8
  %.compoundliteral113 = alloca %struct.dcomplex, align 8
  %.compoundliteral117 = alloca %struct.dcomplex, align 8
  %.compoundliteral121 = alloca %struct.dcomplex, align 8
  %.compoundliteral125 = alloca %struct.dcomplex, align 8
  %.compoundliteral129 = alloca %struct.dcomplex, align 8
  %.compoundliteral133 = alloca %struct.dcomplex, align 8
  %.compoundliteral137 = alloca %struct.dcomplex, align 8
  %.compoundliteral141 = alloca %struct.dcomplex, align 8
  %.compoundliteral145 = alloca %struct.dcomplex, align 8
  %.compoundliteral149 = alloca %struct.dcomplex, align 8
  %.compoundliteral153 = alloca %struct.dcomplex, align 8
  %.compoundliteral157 = alloca %struct.dcomplex, align 8
  %.compoundliteral161 = alloca %struct.dcomplex, align 8
  %.compoundliteral165 = alloca %struct.dcomplex, align 8
  %.compoundliteral169 = alloca %struct.dcomplex, align 8
  %.compoundliteral173 = alloca %struct.dcomplex, align 8
  %.compoundliteral177 = alloca %struct.dcomplex, align 8
  %.compoundliteral190 = alloca %struct.dcomplex, align 8
  %.compoundliteral194 = alloca %struct.dcomplex, align 8
  %.compoundliteral198 = alloca %struct.dcomplex, align 8
  %.compoundliteral202 = alloca %struct.dcomplex, align 8
  %.compoundliteral206 = alloca %struct.dcomplex, align 8
  %.compoundliteral210 = alloca %struct.dcomplex, align 8
  %.compoundliteral214 = alloca %struct.dcomplex, align 8
  %.compoundliteral218 = alloca %struct.dcomplex, align 8
  %.compoundliteral222 = alloca %struct.dcomplex, align 8
  %.compoundliteral226 = alloca %struct.dcomplex, align 8
  %.compoundliteral230 = alloca %struct.dcomplex, align 8
  %.compoundliteral234 = alloca %struct.dcomplex, align 8
  %.compoundliteral238 = alloca %struct.dcomplex, align 8
  %.compoundliteral242 = alloca %struct.dcomplex, align 8
  %.compoundliteral246 = alloca %struct.dcomplex, align 8
  %.compoundliteral250 = alloca %struct.dcomplex, align 8
  %.compoundliteral254 = alloca %struct.dcomplex, align 8
  %.compoundliteral258 = alloca %struct.dcomplex, align 8
  %.compoundliteral262 = alloca %struct.dcomplex, align 8
  %.compoundliteral266 = alloca %struct.dcomplex, align 8
  %.compoundliteral279 = alloca %struct.dcomplex, align 8
  %.compoundliteral283 = alloca %struct.dcomplex, align 8
  %.compoundliteral287 = alloca %struct.dcomplex, align 8
  %.compoundliteral291 = alloca %struct.dcomplex, align 8
  %.compoundliteral295 = alloca %struct.dcomplex, align 8
  %.compoundliteral299 = alloca %struct.dcomplex, align 8
  %.compoundliteral303 = alloca %struct.dcomplex, align 8
  %.compoundliteral307 = alloca %struct.dcomplex, align 8
  %.compoundliteral311 = alloca %struct.dcomplex, align 8
  %.compoundliteral315 = alloca %struct.dcomplex, align 8
  %.compoundliteral319 = alloca %struct.dcomplex, align 8
  %.compoundliteral323 = alloca %struct.dcomplex, align 8
  %.compoundliteral327 = alloca %struct.dcomplex, align 8
  %.compoundliteral331 = alloca %struct.dcomplex, align 8
  %.compoundliteral335 = alloca %struct.dcomplex, align 8
  %.compoundliteral339 = alloca %struct.dcomplex, align 8
  %.compoundliteral343 = alloca %struct.dcomplex, align 8
  %.compoundliteral347 = alloca %struct.dcomplex, align 8
  %.compoundliteral351 = alloca %struct.dcomplex, align 8
  %.compoundliteral355 = alloca %struct.dcomplex, align 8
  %.compoundliteral359 = alloca %struct.dcomplex, align 8
  %.compoundliteral363 = alloca %struct.dcomplex, align 8
  %.compoundliteral367 = alloca %struct.dcomplex, align 8
  %.compoundliteral371 = alloca %struct.dcomplex, align 8
  %.compoundliteral375 = alloca %struct.dcomplex, align 8
  %.compoundliteral388 = alloca %struct.dcomplex, align 8
  %.compoundliteral392 = alloca %struct.dcomplex, align 8
  %.compoundliteral396 = alloca %struct.dcomplex, align 8
  %.compoundliteral400 = alloca %struct.dcomplex, align 8
  %.compoundliteral404 = alloca %struct.dcomplex, align 8
  %.compoundliteral408 = alloca %struct.dcomplex, align 8
  %.compoundliteral412 = alloca %struct.dcomplex, align 8
  %.compoundliteral416 = alloca %struct.dcomplex, align 8
  %.compoundliteral420 = alloca %struct.dcomplex, align 8
  %.compoundliteral424 = alloca %struct.dcomplex, align 8
  %.compoundliteral428 = alloca %struct.dcomplex, align 8
  %.compoundliteral432 = alloca %struct.dcomplex, align 8
  %.compoundliteral436 = alloca %struct.dcomplex, align 8
  %.compoundliteral440 = alloca %struct.dcomplex, align 8
  %.compoundliteral444 = alloca %struct.dcomplex, align 8
  %.compoundliteral448 = alloca %struct.dcomplex, align 8
  %.compoundliteral452 = alloca %struct.dcomplex, align 8
  %.compoundliteral456 = alloca %struct.dcomplex, align 8
  %.compoundliteral460 = alloca %struct.dcomplex, align 8
  %.compoundliteral464 = alloca %struct.dcomplex, align 8
  %.compoundliteral468 = alloca %struct.dcomplex, align 8
  %.compoundliteral472 = alloca %struct.dcomplex, align 8
  %.compoundliteral476 = alloca %struct.dcomplex, align 8
  %.compoundliteral480 = alloca %struct.dcomplex, align 8
  %.compoundliteral484 = alloca %struct.dcomplex, align 8
  %.compoundliteral497 = alloca %struct.dcomplex, align 8
  %coerce = alloca %struct.dcomplex, align 8
  %.compoundliteral516 = alloca %struct.dcomplex, align 8
  %coerce536 = alloca %struct.dcomplex, align 8
  %.compoundliteral538 = alloca %struct.dcomplex, align 8
  %coerce558 = alloca %struct.dcomplex, align 8
  %.compoundliteral560 = alloca %struct.dcomplex, align 8
  %coerce580 = alloca %struct.dcomplex, align 8
  store i32 %n1, i32* %n1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n1.addr, metadata !29, metadata !DIExpression()), !dbg !30
  store i32 %n2, i32* %n2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n2.addr, metadata !31, metadata !DIExpression()), !dbg !32
  store i32 %n3, i32* %n3.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n3.addr, metadata !33, metadata !DIExpression()), !dbg !34
  store i32 %nt, i32* %nt.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %nt.addr, metadata !35, metadata !DIExpression()), !dbg !36
  store %struct.dcomplex* %cksum, %struct.dcomplex** %cksum.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.dcomplex** %cksum.addr, metadata !37, metadata !DIExpression()), !dbg !38
  store i32* %verified, i32** %verified.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %verified.addr, metadata !39, metadata !DIExpression()), !dbg !40
  %0 = load i32, i32* %nt.addr, align 4, !dbg !41
  %add = add nsw i32 %0, 1, !dbg !42
  %1 = zext i32 %add to i64
  call void @llvm.dbg.declare(metadata i32* %kt, metadata !43, metadata !DIExpression()), !dbg !44
  call void @llvm.dbg.declare(metadata [26 x %struct.dcomplex]* %cexpd, metadata !45, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.declare(metadata double* %epsilon, metadata !50, metadata !DIExpression()), !dbg !51
  call void @llvm.dbg.declare(metadata double* %err, metadata !52, metadata !DIExpression()), !dbg !53
  store double 0x3D719799812DEA11, double* %epsilon, align 8, !dbg !54
  %2 = load i32*, i32** %verified.addr, align 8, !dbg !55
  store i32 1, i32* %2, align 4, !dbg !56
  %3 = load i32, i32* %n1.addr, align 4, !dbg !57
  %cmp = icmp eq i32 %3, 64, !dbg !59
  br i1 %cmp, label %land.lhs.true, label %if.else, !dbg !60

land.lhs.true:                                    ; preds = %entry
  %4 = load i32, i32* %n2.addr, align 4, !dbg !61
  %cmp1 = icmp eq i32 %4, 64, !dbg !62
  br i1 %cmp1, label %land.lhs.true2, label %if.else, !dbg !63

land.lhs.true2:                                   ; preds = %land.lhs.true
  %5 = load i32, i32* %n3.addr, align 4, !dbg !64
  %cmp3 = icmp eq i32 %5, 64, !dbg !65
  br i1 %cmp3, label %land.lhs.true4, label %if.else, !dbg !66

land.lhs.true4:                                   ; preds = %land.lhs.true2
  %6 = load i32, i32* %nt.addr, align 4, !dbg !67
  %cmp5 = icmp eq i32 %6, 6, !dbg !68
  br i1 %cmp5, label %if.then, label %if.else, !dbg !69

if.then:                                          ; preds = %land.lhs.true4
  %arrayidx = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 1, !dbg !70
  %real = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral, i32 0, i32 0, !dbg !72
  store double 0x408154DE9E5DA8C7, double* %real, align 8, !dbg !72
  %imag = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral, i32 0, i32 1, !dbg !72
  store double 0x407E4894D21E84F6, double* %imag, align 8, !dbg !72
  %7 = bitcast %struct.dcomplex* %arrayidx to i8*, !dbg !72
  %8 = bitcast %struct.dcomplex* %.compoundliteral to i8*, !dbg !72
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %7, i8* align 8 %8, i64 16, i1 false), !dbg !72
  %arrayidx6 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 2, !dbg !73
  %real8 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral7, i32 0, i32 0, !dbg !74
  store double 0x4081551BBB575EAB, double* %real8, align 8, !dbg !74
  %imag9 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral7, i32 0, i32 1, !dbg !74
  store double 0x407E687CA0F87E44, double* %imag9, align 8, !dbg !74
  %9 = bitcast %struct.dcomplex* %arrayidx6 to i8*, !dbg !74
  %10 = bitcast %struct.dcomplex* %.compoundliteral7 to i8*, !dbg !74
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %9, i8* align 8 %10, i64 16, i1 false), !dbg !74
  %arrayidx10 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 3, !dbg !75
  %real12 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral11, i32 0, i32 0, !dbg !76
  store double 0x408154EB318EB593, double* %real12, align 8, !dbg !76
  %imag13 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral11, i32 0, i32 1, !dbg !76
  store double 0x407E8641D4F55AF9, double* %imag13, align 8, !dbg !76
  %11 = bitcast %struct.dcomplex* %arrayidx10 to i8*, !dbg !76
  %12 = bitcast %struct.dcomplex* %.compoundliteral11 to i8*, !dbg !76
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %11, i8* align 8 %12, i64 16, i1 false), !dbg !76
  %arrayidx14 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 4, !dbg !77
  %real16 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral15, i32 0, i32 0, !dbg !78
  store double 0x40815456C13A7B04, double* %real16, align 8, !dbg !78
  %imag17 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral15, i32 0, i32 1, !dbg !78
  store double 0x407EA2097D7357C2, double* %imag17, align 8, !dbg !78
  %13 = bitcast %struct.dcomplex* %arrayidx14 to i8*, !dbg !78
  %14 = bitcast %struct.dcomplex* %.compoundliteral15 to i8*, !dbg !78
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %13, i8* align 8 %14, i64 16, i1 false), !dbg !78
  %arrayidx18 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 5, !dbg !79
  %real20 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral19, i32 0, i32 0, !dbg !80
  store double 0x408153676E9F169C, double* %real20, align 8, !dbg !80
  %imag21 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral19, i32 0, i32 1, !dbg !80
  store double 0x407EBBF61C86EF29, double* %imag21, align 8, !dbg !80
  %15 = bitcast %struct.dcomplex* %arrayidx18 to i8*, !dbg !80
  %16 = bitcast %struct.dcomplex* %.compoundliteral19 to i8*, !dbg !80
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %15, i8* align 8 %16, i64 16, i1 false), !dbg !80
  %arrayidx22 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 6, !dbg !81
  %real24 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral23, i32 0, i32 0, !dbg !82
  store double 0x408152259010E0A1, double* %real24, align 8, !dbg !82
  %imag25 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral23, i32 0, i32 1, !dbg !82
  store double 0x407ED427D4DF0213, double* %imag25, align 8, !dbg !82
  %17 = bitcast %struct.dcomplex* %arrayidx22 to i8*, !dbg !82
  %18 = bitcast %struct.dcomplex* %.compoundliteral23 to i8*, !dbg !82
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %17, i8* align 8 %18, i64 16, i1 false), !dbg !82
  br label %if.end493, !dbg !83

if.else:                                          ; preds = %land.lhs.true4, %land.lhs.true2, %land.lhs.true, %entry
  %19 = load i32, i32* %n1.addr, align 4, !dbg !84
  %cmp26 = icmp eq i32 %19, 128, !dbg !86
  br i1 %cmp26, label %land.lhs.true27, label %if.else58, !dbg !87

land.lhs.true27:                                  ; preds = %if.else
  %20 = load i32, i32* %n2.addr, align 4, !dbg !88
  %cmp28 = icmp eq i32 %20, 128, !dbg !89
  br i1 %cmp28, label %land.lhs.true29, label %if.else58, !dbg !90

land.lhs.true29:                                  ; preds = %land.lhs.true27
  %21 = load i32, i32* %n3.addr, align 4, !dbg !91
  %cmp30 = icmp eq i32 %21, 32, !dbg !92
  br i1 %cmp30, label %land.lhs.true31, label %if.else58, !dbg !93

land.lhs.true31:                                  ; preds = %land.lhs.true29
  %22 = load i32, i32* %nt.addr, align 4, !dbg !94
  %cmp32 = icmp eq i32 %22, 6, !dbg !95
  br i1 %cmp32, label %if.then33, label %if.else58, !dbg !96

if.then33:                                        ; preds = %land.lhs.true31
  %arrayidx34 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 1, !dbg !97
  %real36 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral35, i32 0, i32 0, !dbg !99
  store double 0x4081BAE3C635196D, double* %real36, align 8, !dbg !99
  %imag37 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral35, i32 0, i32 1, !dbg !99
  store double 0x40808A98F467F156, double* %imag37, align 8, !dbg !99
  %23 = bitcast %struct.dcomplex* %arrayidx34 to i8*, !dbg !99
  %24 = bitcast %struct.dcomplex* %.compoundliteral35 to i8*, !dbg !99
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %23, i8* align 8 %24, i64 16, i1 false), !dbg !99
  %arrayidx38 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 2, !dbg !100
  %real40 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral39, i32 0, i32 0, !dbg !101
  store double 0x40819926462BA5A4, double* %real40, align 8, !dbg !101
  %imag41 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral39, i32 0, i32 1, !dbg !101
  store double 0x408081B851380EB7, double* %imag41, align 8, !dbg !101
  %25 = bitcast %struct.dcomplex* %arrayidx38 to i8*, !dbg !101
  %26 = bitcast %struct.dcomplex* %.compoundliteral39 to i8*, !dbg !101
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %25, i8* align 8 %26, i64 16, i1 false), !dbg !101
  %arrayidx42 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 3, !dbg !102
  %real44 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral43, i32 0, i32 0, !dbg !103
  store double 0x40817B3822354DD9, double* %real44, align 8, !dbg !103
  %imag45 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral43, i32 0, i32 1, !dbg !103
  store double 0x408078CC18578DFC, double* %imag45, align 8, !dbg !103
  %27 = bitcast %struct.dcomplex* %arrayidx42 to i8*, !dbg !103
  %28 = bitcast %struct.dcomplex* %.compoundliteral43 to i8*, !dbg !103
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %27, i8* align 8 %28, i64 16, i1 false), !dbg !103
  %arrayidx46 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 4, !dbg !104
  %real48 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral47, i32 0, i32 0, !dbg !105
  store double 0x4081608EF5C48194, double* %real48, align 8, !dbg !105
  %imag49 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral47, i32 0, i32 1, !dbg !105
  store double 0x40807005B7059038, double* %imag49, align 8, !dbg !105
  %29 = bitcast %struct.dcomplex* %arrayidx46 to i8*, !dbg !105
  %30 = bitcast %struct.dcomplex* %.compoundliteral47 to i8*, !dbg !105
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %29, i8* align 8 %30, i64 16, i1 false), !dbg !105
  %arrayidx50 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 5, !dbg !106
  %real52 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral51, i32 0, i32 0, !dbg !107
  store double 0x408148B81D084E83, double* %real52, align 8, !dbg !107
  %imag53 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral51, i32 0, i32 1, !dbg !107
  store double 0x408067854B0E36C9, double* %imag53, align 8, !dbg !107
  %31 = bitcast %struct.dcomplex* %arrayidx50 to i8*, !dbg !107
  %32 = bitcast %struct.dcomplex* %.compoundliteral51 to i8*, !dbg !107
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %31, i8* align 8 %32, i64 16, i1 false), !dbg !107
  %arrayidx54 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 6, !dbg !108
  %real56 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral55, i32 0, i32 0, !dbg !109
  store double 0x40813353E9E3E09A, double* %real56, align 8, !dbg !109
  %imag57 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral55, i32 0, i32 1, !dbg !109
  store double 0x40805F5EAB0F5DA2, double* %imag57, align 8, !dbg !109
  %33 = bitcast %struct.dcomplex* %arrayidx54 to i8*, !dbg !109
  %34 = bitcast %struct.dcomplex* %.compoundliteral55 to i8*, !dbg !109
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %33, i8* align 8 %34, i64 16, i1 false), !dbg !109
  br label %if.end492, !dbg !110

if.else58:                                        ; preds = %land.lhs.true31, %land.lhs.true29, %land.lhs.true27, %if.else
  %35 = load i32, i32* %n1.addr, align 4, !dbg !111
  %cmp59 = icmp eq i32 %35, 256, !dbg !113
  br i1 %cmp59, label %land.lhs.true60, label %if.else91, !dbg !114

land.lhs.true60:                                  ; preds = %if.else58
  %36 = load i32, i32* %n2.addr, align 4, !dbg !115
  %cmp61 = icmp eq i32 %36, 256, !dbg !116
  br i1 %cmp61, label %land.lhs.true62, label %if.else91, !dbg !117

land.lhs.true62:                                  ; preds = %land.lhs.true60
  %37 = load i32, i32* %n3.addr, align 4, !dbg !118
  %cmp63 = icmp eq i32 %37, 128, !dbg !119
  br i1 %cmp63, label %land.lhs.true64, label %if.else91, !dbg !120

land.lhs.true64:                                  ; preds = %land.lhs.true62
  %38 = load i32, i32* %nt.addr, align 4, !dbg !121
  %cmp65 = icmp eq i32 %38, 6, !dbg !122
  br i1 %cmp65, label %if.then66, label %if.else91, !dbg !123

if.then66:                                        ; preds = %land.lhs.true64
  %arrayidx67 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 1, !dbg !124
  %real69 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral68, i32 0, i32 0, !dbg !126
  store double 0x407F8AC6A8CB8B90, double* %real69, align 8, !dbg !126
  %imag70 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral68, i32 0, i32 1, !dbg !126
  store double 0x407FF67A05A82466, double* %imag70, align 8, !dbg !126
  %39 = bitcast %struct.dcomplex* %arrayidx67 to i8*, !dbg !126
  %40 = bitcast %struct.dcomplex* %.compoundliteral68 to i8*, !dbg !126
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %39, i8* align 8 %40, i64 16, i1 false), !dbg !126
  %arrayidx71 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 2, !dbg !127
  %real73 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral72, i32 0, i32 0, !dbg !128
  store double 0x407F9F0F4941FB3E, double* %real73, align 8, !dbg !128
  %imag74 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral72, i32 0, i32 1, !dbg !128
  store double 0x407FDE18707A9D72, double* %imag74, align 8, !dbg !128
  %41 = bitcast %struct.dcomplex* %arrayidx71 to i8*, !dbg !128
  %42 = bitcast %struct.dcomplex* %.compoundliteral72 to i8*, !dbg !128
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %41, i8* align 8 %42, i64 16, i1 false), !dbg !128
  %arrayidx75 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 3, !dbg !129
  %real77 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral76, i32 0, i32 0, !dbg !130
  store double 0x407FAF00C6D7110A, double* %real77, align 8, !dbg !130
  %imag78 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral76, i32 0, i32 1, !dbg !130
  store double 0x407FDD07CCB88353, double* %imag78, align 8, !dbg !130
  %43 = bitcast %struct.dcomplex* %arrayidx75 to i8*, !dbg !130
  %44 = bitcast %struct.dcomplex* %.compoundliteral76 to i8*, !dbg !130
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %43, i8* align 8 %44, i64 16, i1 false), !dbg !130
  %arrayidx79 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 4, !dbg !131
  %real81 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral80, i32 0, i32 0, !dbg !132
  store double 0x407FBCA0EB3ECBEF, double* %real81, align 8, !dbg !132
  %imag82 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral80, i32 0, i32 1, !dbg !132
  store double 0x407FE2234776F4EF, double* %imag82, align 8, !dbg !132
  %45 = bitcast %struct.dcomplex* %arrayidx79 to i8*, !dbg !132
  %46 = bitcast %struct.dcomplex* %.compoundliteral80 to i8*, !dbg !132
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %45, i8* align 8 %46, i64 16, i1 false), !dbg !132
  %arrayidx83 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 5, !dbg !133
  %real85 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral84, i32 0, i32 0, !dbg !134
  store double 0x407FC85F79D2C1E9, double* %real85, align 8, !dbg !134
  %imag86 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral84, i32 0, i32 1, !dbg !134
  store double 0x407FE7DD0AF2CEF4, double* %imag86, align 8, !dbg !134
  %47 = bitcast %struct.dcomplex* %arrayidx83 to i8*, !dbg !134
  %48 = bitcast %struct.dcomplex* %.compoundliteral84 to i8*, !dbg !134
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %47, i8* align 8 %48, i64 16, i1 false), !dbg !134
  %arrayidx87 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 6, !dbg !135
  %real89 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral88, i32 0, i32 0, !dbg !136
  store double 0x407FD2611DBB8FA9, double* %real89, align 8, !dbg !136
  %imag90 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral88, i32 0, i32 1, !dbg !136
  store double 0x407FECAB25FE5602, double* %imag90, align 8, !dbg !136
  %49 = bitcast %struct.dcomplex* %arrayidx87 to i8*, !dbg !136
  %50 = bitcast %struct.dcomplex* %.compoundliteral88 to i8*, !dbg !136
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %49, i8* align 8 %50, i64 16, i1 false), !dbg !136
  br label %if.end491, !dbg !137

if.else91:                                        ; preds = %land.lhs.true64, %land.lhs.true62, %land.lhs.true60, %if.else58
  %51 = load i32, i32* %n1.addr, align 4, !dbg !138
  %cmp92 = icmp eq i32 %51, 512, !dbg !140
  br i1 %cmp92, label %land.lhs.true93, label %if.else180, !dbg !141

land.lhs.true93:                                  ; preds = %if.else91
  %52 = load i32, i32* %n2.addr, align 4, !dbg !142
  %cmp94 = icmp eq i32 %52, 256, !dbg !143
  br i1 %cmp94, label %land.lhs.true95, label %if.else180, !dbg !144

land.lhs.true95:                                  ; preds = %land.lhs.true93
  %53 = load i32, i32* %n3.addr, align 4, !dbg !145
  %cmp96 = icmp eq i32 %53, 256, !dbg !146
  br i1 %cmp96, label %land.lhs.true97, label %if.else180, !dbg !147

land.lhs.true97:                                  ; preds = %land.lhs.true95
  %54 = load i32, i32* %nt.addr, align 4, !dbg !148
  %cmp98 = icmp eq i32 %54, 20, !dbg !149
  br i1 %cmp98, label %if.then99, label %if.else180, !dbg !150

if.then99:                                        ; preds = %land.lhs.true97
  %arrayidx100 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 1, !dbg !151
  %real102 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral101, i32 0, i32 0, !dbg !153
  store double 0x40802E1D67491D27, double* %real102, align 8, !dbg !153
  %imag103 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral101, i32 0, i32 1, !dbg !153
  store double 0x407FBC7C4BF0AFB0, double* %imag103, align 8, !dbg !153
  %55 = bitcast %struct.dcomplex* %arrayidx100 to i8*, !dbg !153
  %56 = bitcast %struct.dcomplex* %.compoundliteral101 to i8*, !dbg !153
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %55, i8* align 8 %56, i64 16, i1 false), !dbg !153
  %arrayidx104 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 2, !dbg !154
  %real106 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral105, i32 0, i32 0, !dbg !155
  store double 0x40801B9DF5E01838, double* %real106, align 8, !dbg !155
  %imag107 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral105, i32 0, i32 1, !dbg !155
  store double 0x407FCD32F7994D45, double* %imag107, align 8, !dbg !155
  %57 = bitcast %struct.dcomplex* %arrayidx104 to i8*, !dbg !155
  %58 = bitcast %struct.dcomplex* %.compoundliteral105 to i8*, !dbg !155
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %57, i8* align 8 %58, i64 16, i1 false), !dbg !155
  %arrayidx108 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 3, !dbg !156
  %real110 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral109, i32 0, i32 0, !dbg !157
  store double 0x408015209C2AC008, double* %real110, align 8, !dbg !157
  %imag111 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral109, i32 0, i32 1, !dbg !157
  store double 0x407FD9EF2BAE169A, double* %imag111, align 8, !dbg !157
  %59 = bitcast %struct.dcomplex* %arrayidx108 to i8*, !dbg !157
  %60 = bitcast %struct.dcomplex* %.compoundliteral109 to i8*, !dbg !157
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %59, i8* align 8 %60, i64 16, i1 false), !dbg !157
  %arrayidx112 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 4, !dbg !158
  %real114 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral113, i32 0, i32 0, !dbg !159
  store double 0x408011E72B556FFE, double* %real114, align 8, !dbg !159
  %imag115 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral113, i32 0, i32 1, !dbg !159
  store double 0x407FE1A32DF83794, double* %imag115, align 8, !dbg !159
  %61 = bitcast %struct.dcomplex* %arrayidx112 to i8*, !dbg !159
  %62 = bitcast %struct.dcomplex* %.compoundliteral113 to i8*, !dbg !159
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %61, i8* align 8 %62, i64 16, i1 false), !dbg !159
  %arrayidx116 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 5, !dbg !160
  %real118 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral117, i32 0, i32 0, !dbg !161
  store double 0x40800FB38AA32FE6, double* %real118, align 8, !dbg !161
  %imag119 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral117, i32 0, i32 1, !dbg !161
  store double 0x407FE65CD1D86E4E, double* %imag119, align 8, !dbg !161
  %63 = bitcast %struct.dcomplex* %arrayidx116 to i8*, !dbg !161
  %64 = bitcast %struct.dcomplex* %.compoundliteral117 to i8*, !dbg !161
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %63, i8* align 8 %64, i64 16, i1 false), !dbg !161
  %arrayidx120 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 6, !dbg !162
  %real122 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral121, i32 0, i32 0, !dbg !163
  store double 0x40800DF0531A9C48, double* %real122, align 8, !dbg !163
  %imag123 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral121, i32 0, i32 1, !dbg !163
  store double 0x407FE9844F14C8E1, double* %imag123, align 8, !dbg !163
  %65 = bitcast %struct.dcomplex* %arrayidx120 to i8*, !dbg !163
  %66 = bitcast %struct.dcomplex* %.compoundliteral121 to i8*, !dbg !163
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %65, i8* align 8 %66, i64 16, i1 false), !dbg !163
  %arrayidx124 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 7, !dbg !164
  %real126 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral125, i32 0, i32 0, !dbg !165
  store double 0x40800C700989200D, double* %real126, align 8, !dbg !165
  %imag127 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral125, i32 0, i32 1, !dbg !165
  store double 0x407FEBD8BF0DD370, double* %imag127, align 8, !dbg !165
  %67 = bitcast %struct.dcomplex* %arrayidx124 to i8*, !dbg !165
  %68 = bitcast %struct.dcomplex* %.compoundliteral125 to i8*, !dbg !165
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %67, i8* align 8 %68, i64 16, i1 false), !dbg !165
  %arrayidx128 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 8, !dbg !166
  %real130 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral129, i32 0, i32 0, !dbg !167
  store double 0x40800B20F5210ADA, double* %real130, align 8, !dbg !167
  %imag131 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral129, i32 0, i32 1, !dbg !167
  store double 0x407FEDB8F6EE292B, double* %imag131, align 8, !dbg !167
  %69 = bitcast %struct.dcomplex* %arrayidx128 to i8*, !dbg !167
  %70 = bitcast %struct.dcomplex* %.compoundliteral129 to i8*, !dbg !167
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %69, i8* align 8 %70, i64 16, i1 false), !dbg !167
  %arrayidx132 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 9, !dbg !168
  %real134 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral133, i32 0, i32 0, !dbg !169
  store double 0x408009FA001E667B, double* %real134, align 8, !dbg !169
  %imag135 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral133, i32 0, i32 1, !dbg !169
  store double 0x407FEF52DA70C18D, double* %imag135, align 8, !dbg !169
  %71 = bitcast %struct.dcomplex* %arrayidx132 to i8*, !dbg !169
  %72 = bitcast %struct.dcomplex* %.compoundliteral133 to i8*, !dbg !169
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %71, i8* align 8 %72, i64 16, i1 false), !dbg !169
  %arrayidx136 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 10, !dbg !170
  %real138 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral137, i32 0, i32 0, !dbg !171
  store double 0x408008F54B8BB893, double* %real138, align 8, !dbg !171
  %imag139 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral137, i32 0, i32 1, !dbg !171
  store double 0x407FF0BC8A6C6119, double* %imag139, align 8, !dbg !171
  %73 = bitcast %struct.dcomplex* %arrayidx136 to i8*, !dbg !171
  %74 = bitcast %struct.dcomplex* %.compoundliteral137 to i8*, !dbg !171
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %73, i8* align 8 %74, i64 16, i1 false), !dbg !171
  %arrayidx140 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 11, !dbg !172
  %real142 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral141, i32 0, i32 0, !dbg !173
  store double 0x4080080E66C1709C, double* %real142, align 8, !dbg !173
  %imag143 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral141, i32 0, i32 1, !dbg !173
  store double 0x407FF200FF33D23F, double* %imag143, align 8, !dbg !173
  %75 = bitcast %struct.dcomplex* %arrayidx140 to i8*, !dbg !173
  %76 = bitcast %struct.dcomplex* %.compoundliteral141 to i8*, !dbg !173
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %75, i8* align 8 %76, i64 16, i1 false), !dbg !173
  %arrayidx144 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 12, !dbg !174
  %real146 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral145, i32 0, i32 0, !dbg !175
  store double 0x40800741A55F37AD, double* %real146, align 8, !dbg !175
  %imag147 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral145, i32 0, i32 1, !dbg !175
  store double 0x407FF3261FE7F7AD, double* %imag147, align 8, !dbg !175
  %77 = bitcast %struct.dcomplex* %arrayidx144 to i8*, !dbg !175
  %78 = bitcast %struct.dcomplex* %.compoundliteral145 to i8*, !dbg !175
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %77, i8* align 8 %78, i64 16, i1 false), !dbg !175
  %arrayidx148 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 13, !dbg !176
  %real150 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral149, i32 0, i32 0, !dbg !177
  store double 0x4080068BDAC33674, double* %real150, align 8, !dbg !177
  %imag151 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral149, i32 0, i32 1, !dbg !177
  store double 0x407FF42F9BEB8DC0, double* %imag151, align 8, !dbg !177
  %79 = bitcast %struct.dcomplex* %arrayidx148 to i8*, !dbg !177
  %80 = bitcast %struct.dcomplex* %.compoundliteral149 to i8*, !dbg !177
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %79, i8* align 8 %80, i64 16, i1 false), !dbg !177
  %arrayidx152 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 14, !dbg !178
  %real154 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral153, i32 0, i32 0, !dbg !179
  store double 0x408005EA3C919C43, double* %real154, align 8, !dbg !179
  %imag155 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral153, i32 0, i32 1, !dbg !179
  store double 0x407FF5203263B154, double* %imag155, align 8, !dbg !179
  %81 = bitcast %struct.dcomplex* %arrayidx152 to i8*, !dbg !179
  %82 = bitcast %struct.dcomplex* %.compoundliteral153 to i8*, !dbg !179
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %81, i8* align 8 %82, i64 16, i1 false), !dbg !179
  %arrayidx156 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 15, !dbg !180
  %real158 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral157, i32 0, i32 0, !dbg !181
  store double 0x4080055A545A3920, double* %real158, align 8, !dbg !181
  %imag159 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral157, i32 0, i32 1, !dbg !181
  store double 0x407FF5FA3C741F6E, double* %imag159, align 8, !dbg !181
  %83 = bitcast %struct.dcomplex* %arrayidx156 to i8*, !dbg !181
  %84 = bitcast %struct.dcomplex* %.compoundliteral157 to i8*, !dbg !181
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %83, i8* align 8 %84, i64 16, i1 false), !dbg !181
  %arrayidx160 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 16, !dbg !182
  %real162 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral161, i32 0, i32 0, !dbg !183
  store double 0x408004D9F6B6B8E1, double* %real162, align 8, !dbg !183
  %imag163 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral161, i32 0, i32 1, !dbg !183
  store double 0x407FF6BFE1A61501, double* %imag163, align 8, !dbg !183
  %85 = bitcast %struct.dcomplex* %arrayidx160 to i8*, !dbg !183
  %86 = bitcast %struct.dcomplex* %.compoundliteral161 to i8*, !dbg !183
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %85, i8* align 8 %86, i64 16, i1 false), !dbg !183
  %arrayidx164 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 17, !dbg !184
  %real166 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral165, i32 0, i32 0, !dbg !185
  store double 0x408004673C213244, double* %real166, align 8, !dbg !185
  %imag167 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral165, i32 0, i32 1, !dbg !185
  store double 0x407FF77327A3F7B0, double* %imag167, align 8, !dbg !185
  %87 = bitcast %struct.dcomplex* %arrayidx164 to i8*, !dbg !185
  %88 = bitcast %struct.dcomplex* %.compoundliteral165 to i8*, !dbg !185
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %87, i8* align 8 %88, i64 16, i1 false), !dbg !185
  %arrayidx168 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 18, !dbg !186
  %real170 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral169, i32 0, i32 0, !dbg !187
  store double 0x408004007A3FD0EA, double* %real170, align 8, !dbg !187
  %imag171 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral169, i32 0, i32 1, !dbg !187
  store double 0x407FF815F3F1C1DE, double* %imag171, align 8, !dbg !187
  %89 = bitcast %struct.dcomplex* %arrayidx168 to i8*, !dbg !187
  %90 = bitcast %struct.dcomplex* %.compoundliteral169 to i8*, !dbg !187
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %89, i8* align 8 %90, i64 16, i1 false), !dbg !187
  %arrayidx172 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 19, !dbg !188
  %real174 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral173, i32 0, i32 0, !dbg !189
  store double 0x408003A43D5F793B, double* %real174, align 8, !dbg !189
  %imag175 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral173, i32 0, i32 1, !dbg !189
  store double 0x407FF8AA099402A0, double* %imag175, align 8, !dbg !189
  %91 = bitcast %struct.dcomplex* %arrayidx172 to i8*, !dbg !189
  %92 = bitcast %struct.dcomplex* %.compoundliteral173 to i8*, !dbg !189
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %91, i8* align 8 %92, i64 16, i1 false), !dbg !189
  %arrayidx176 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 20, !dbg !190
  %real178 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral177, i32 0, i32 0, !dbg !191
  store double 0x40800351422D2EDF, double* %real178, align 8, !dbg !191
  %imag179 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral177, i32 0, i32 1, !dbg !191
  store double 0x407FF93106A352EE, double* %imag179, align 8, !dbg !191
  %93 = bitcast %struct.dcomplex* %arrayidx176 to i8*, !dbg !191
  %94 = bitcast %struct.dcomplex* %.compoundliteral177 to i8*, !dbg !191
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %93, i8* align 8 %94, i64 16, i1 false), !dbg !191
  br label %if.end490, !dbg !192

if.else180:                                       ; preds = %land.lhs.true97, %land.lhs.true95, %land.lhs.true93, %if.else91
  %95 = load i32, i32* %n1.addr, align 4, !dbg !193
  %cmp181 = icmp eq i32 %95, 512, !dbg !195
  br i1 %cmp181, label %land.lhs.true182, label %if.else269, !dbg !196

land.lhs.true182:                                 ; preds = %if.else180
  %96 = load i32, i32* %n2.addr, align 4, !dbg !197
  %cmp183 = icmp eq i32 %96, 512, !dbg !198
  br i1 %cmp183, label %land.lhs.true184, label %if.else269, !dbg !199

land.lhs.true184:                                 ; preds = %land.lhs.true182
  %97 = load i32, i32* %n3.addr, align 4, !dbg !200
  %cmp185 = icmp eq i32 %97, 512, !dbg !201
  br i1 %cmp185, label %land.lhs.true186, label %if.else269, !dbg !202

land.lhs.true186:                                 ; preds = %land.lhs.true184
  %98 = load i32, i32* %nt.addr, align 4, !dbg !203
  %cmp187 = icmp eq i32 %98, 20, !dbg !204
  br i1 %cmp187, label %if.then188, label %if.else269, !dbg !205

if.then188:                                       ; preds = %land.lhs.true186
  %arrayidx189 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 1, !dbg !206
  %real191 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral190, i32 0, i32 0, !dbg !208
  store double 0x40803C101E899B03, double* %real191, align 8, !dbg !208
  %imag192 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral190, i32 0, i32 1, !dbg !208
  store double 0x408017373C01E593, double* %imag192, align 8, !dbg !208
  %99 = bitcast %struct.dcomplex* %arrayidx189 to i8*, !dbg !208
  %100 = bitcast %struct.dcomplex* %.compoundliteral190 to i8*, !dbg !208
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %99, i8* align 8 %100, i64 16, i1 false), !dbg !208
  %arrayidx193 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 2, !dbg !209
  %real195 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral194, i32 0, i32 0, !dbg !210
  store double 0x40801C5675ED0B14, double* %real195, align 8, !dbg !210
  %imag196 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral194, i32 0, i32 1, !dbg !210
  store double 0x4080061004096FAD, double* %imag196, align 8, !dbg !210
  %101 = bitcast %struct.dcomplex* %arrayidx193 to i8*, !dbg !210
  %102 = bitcast %struct.dcomplex* %.compoundliteral194 to i8*, !dbg !210
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %101, i8* align 8 %102, i64 16, i1 false), !dbg !210
  %arrayidx197 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 3, !dbg !211
  %real199 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral198, i32 0, i32 0, !dbg !212
  store double 0x408013BE0F176AC3, double* %real199, align 8, !dbg !212
  %imag200 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral198, i32 0, i32 1, !dbg !212
  store double 0x408001CD2DA9B691, double* %imag200, align 8, !dbg !212
  %103 = bitcast %struct.dcomplex* %arrayidx197 to i8*, !dbg !212
  %104 = bitcast %struct.dcomplex* %.compoundliteral198 to i8*, !dbg !212
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %103, i8* align 8 %104, i64 16, i1 false), !dbg !212
  %arrayidx201 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 4, !dbg !213
  %real203 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral202, i32 0, i32 0, !dbg !214
  store double 0x4080101ED77ADAFA, double* %real203, align 8, !dbg !214
  %imag204 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral202, i32 0, i32 1, !dbg !214
  store double 0x408000DF4A8B7C66, double* %imag204, align 8, !dbg !214
  %105 = bitcast %struct.dcomplex* %arrayidx201 to i8*, !dbg !214
  %106 = bitcast %struct.dcomplex* %.compoundliteral202 to i8*, !dbg !214
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %105, i8* align 8 %106, i64 16, i1 false), !dbg !214
  %arrayidx205 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 5, !dbg !215
  %real207 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral206, i32 0, i32 0, !dbg !216
  store double 0x40800E0A53D12FD5, double* %real207, align 8, !dbg !216
  %imag208 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral206, i32 0, i32 1, !dbg !216
  store double 0x408000EA3A1348C8, double* %imag208, align 8, !dbg !216
  %107 = bitcast %struct.dcomplex* %arrayidx205 to i8*, !dbg !216
  %108 = bitcast %struct.dcomplex* %.compoundliteral206 to i8*, !dbg !216
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %107, i8* align 8 %108, i64 16, i1 false), !dbg !216
  %arrayidx209 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 6, !dbg !217
  %real211 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral210, i32 0, i32 0, !dbg !218
  store double 0x40800CA61ABB2192, double* %real211, align 8, !dbg !218
  %imag212 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral210, i32 0, i32 1, !dbg !218
  store double 0x408001328991F77F, double* %imag212, align 8, !dbg !218
  %109 = bitcast %struct.dcomplex* %arrayidx209 to i8*, !dbg !218
  %110 = bitcast %struct.dcomplex* %.compoundliteral210 to i8*, !dbg !218
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %109, i8* align 8 %110, i64 16, i1 false), !dbg !218
  %arrayidx213 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 7, !dbg !219
  %real215 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral214, i32 0, i32 0, !dbg !220
  store double 0x40800BA7CD2DCE4D, double* %real215, align 8, !dbg !220
  %imag216 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral214, i32 0, i32 1, !dbg !220
  store double 0x4080017F2A30930B, double* %imag216, align 8, !dbg !220
  %111 = bitcast %struct.dcomplex* %arrayidx213 to i8*, !dbg !220
  %112 = bitcast %struct.dcomplex* %.compoundliteral214 to i8*, !dbg !220
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %111, i8* align 8 %112, i64 16, i1 false), !dbg !220
  %arrayidx217 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 8, !dbg !221
  %real219 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral218, i32 0, i32 0, !dbg !222
  store double 0x40800AEBECB397D4, double* %real219, align 8, !dbg !222
  %imag220 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral218, i32 0, i32 1, !dbg !222
  store double 0x408001C12D7B83F2, double* %imag220, align 8, !dbg !222
  %113 = bitcast %struct.dcomplex* %arrayidx217 to i8*, !dbg !222
  %114 = bitcast %struct.dcomplex* %.compoundliteral218 to i8*, !dbg !222
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %113, i8* align 8 %114, i64 16, i1 false), !dbg !222
  %arrayidx221 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 9, !dbg !223
  %real223 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral222, i32 0, i32 0, !dbg !224
  store double 0x40800A5D393668AE, double* %real223, align 8, !dbg !224
  %imag224 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral222, i32 0, i32 1, !dbg !224
  store double 0x408001F6BADA1C71, double* %imag224, align 8, !dbg !224
  %115 = bitcast %struct.dcomplex* %arrayidx221 to i8*, !dbg !224
  %116 = bitcast %struct.dcomplex* %.compoundliteral222 to i8*, !dbg !224
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %115, i8* align 8 %116, i64 16, i1 false), !dbg !224
  %arrayidx225 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 10, !dbg !225
  %real227 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral226, i32 0, i32 0, !dbg !226
  store double 0x408009EDAA24021D, double* %real227, align 8, !dbg !226
  %imag228 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral226, i32 0, i32 1, !dbg !226
  store double 0x4080022183F3CA50, double* %imag228, align 8, !dbg !226
  %117 = bitcast %struct.dcomplex* %arrayidx225 to i8*, !dbg !226
  %118 = bitcast %struct.dcomplex* %.compoundliteral226 to i8*, !dbg !226
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %117, i8* align 8 %118, i64 16, i1 false), !dbg !226
  %arrayidx229 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 11, !dbg !227
  %real231 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral230, i32 0, i32 0, !dbg !228
  store double 0x40800993B097C5AC, double* %real231, align 8, !dbg !228
  %imag232 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral230, i32 0, i32 1, !dbg !228
  store double 0x40800243C3A1DCB2, double* %imag232, align 8, !dbg !228
  %119 = bitcast %struct.dcomplex* %arrayidx229 to i8*, !dbg !228
  %120 = bitcast %struct.dcomplex* %.compoundliteral230 to i8*, !dbg !228
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %119, i8* align 8 %120, i64 16, i1 false), !dbg !228
  %arrayidx233 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 12, !dbg !229
  %real235 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral234, i32 0, i32 0, !dbg !230
  store double 0x40800948BF026ADC, double* %real235, align 8, !dbg !230
  %imag236 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral234, i32 0, i32 1, !dbg !230
  store double 0x4080025F68FD8268, double* %imag236, align 8, !dbg !230
  %121 = bitcast %struct.dcomplex* %arrayidx233 to i8*, !dbg !230
  %122 = bitcast %struct.dcomplex* %.compoundliteral234 to i8*, !dbg !230
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %121, i8* align 8 %122, i64 16, i1 false), !dbg !230
  %arrayidx237 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 13, !dbg !231
  %real239 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral238, i32 0, i32 0, !dbg !232
  store double 0x4080090857A518D9, double* %real239, align 8, !dbg !232
  %imag240 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral238, i32 0, i32 1, !dbg !232
  store double 0x40800275F32F50EA, double* %imag240, align 8, !dbg !232
  %123 = bitcast %struct.dcomplex* %arrayidx237 to i8*, !dbg !232
  %124 = bitcast %struct.dcomplex* %.compoundliteral238 to i8*, !dbg !232
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %123, i8* align 8 %124, i64 16, i1 false), !dbg !232
  %arrayidx241 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 14, !dbg !233
  %real243 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral242, i32 0, i32 0, !dbg !234
  store double 0x408008CF67B5F6E6, double* %real243, align 8, !dbg !234
  %imag244 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral242, i32 0, i32 1, !dbg !234
  store double 0x408002887F1716B0, double* %imag244, align 8, !dbg !234
  %125 = bitcast %struct.dcomplex* %arrayidx241 to i8*, !dbg !234
  %126 = bitcast %struct.dcomplex* %.compoundliteral242 to i8*, !dbg !234
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %125, i8* align 8 %126, i64 16, i1 false), !dbg !234
  %arrayidx245 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 15, !dbg !235
  %real247 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral246, i32 0, i32 0, !dbg !236
  store double 0x4080089BD580EA3A, double* %real247, align 8, !dbg !236
  %imag248 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral246, i32 0, i32 1, !dbg !236
  store double 0x40800297DE24048E, double* %imag248, align 8, !dbg !236
  %127 = bitcast %struct.dcomplex* %arrayidx245 to i8*, !dbg !236
  %128 = bitcast %struct.dcomplex* %.compoundliteral246 to i8*, !dbg !236
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %127, i8* align 8 %128, i64 16, i1 false), !dbg !236
  %arrayidx249 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 16, !dbg !237
  %real251 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral250, i32 0, i32 0, !dbg !238
  store double 0x4080086C31EBD984, double* %real251, align 8, !dbg !238
  %imag252 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral250, i32 0, i32 1, !dbg !238
  store double 0x408002A4AAB9F9F8, double* %imag252, align 8, !dbg !238
  %129 = bitcast %struct.dcomplex* %arrayidx249 to i8*, !dbg !238
  %130 = bitcast %struct.dcomplex* %.compoundliteral250 to i8*, !dbg !238
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %129, i8* align 8 %130, i64 16, i1 false), !dbg !238
  %arrayidx253 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 17, !dbg !239
  %real255 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral254, i32 0, i32 0, !dbg !240
  store double 0x4080083F8294129E, double* %real255, align 8, !dbg !240
  %imag256 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral254, i32 0, i32 1, !dbg !240
  store double 0x408002AF57DC0D71, double* %imag256, align 8, !dbg !240
  %131 = bitcast %struct.dcomplex* %arrayidx253 to i8*, !dbg !240
  %132 = bitcast %struct.dcomplex* %.compoundliteral254 to i8*, !dbg !240
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %131, i8* align 8 %132, i64 16, i1 false), !dbg !240
  %arrayidx257 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 18, !dbg !241
  %real259 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral258, i32 0, i32 0, !dbg !242
  store double 0x408008151CE457D2, double* %real259, align 8, !dbg !242
  %imag260 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral258, i32 0, i32 1, !dbg !242
  store double 0x408002B83C8A44C9, double* %imag260, align 8, !dbg !242
  %133 = bitcast %struct.dcomplex* %arrayidx257 to i8*, !dbg !242
  %134 = bitcast %struct.dcomplex* %.compoundliteral258 to i8*, !dbg !242
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %133, i8* align 8 %134, i64 16, i1 false), !dbg !242
  %arrayidx261 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 19, !dbg !243
  %real263 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral262, i32 0, i32 0, !dbg !244
  store double 0x408007EC8CCD48ED, double* %real263, align 8, !dbg !244
  %imag264 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral262, i32 0, i32 1, !dbg !244
  store double 0x408002BF9BCECA75, double* %imag264, align 8, !dbg !244
  %135 = bitcast %struct.dcomplex* %arrayidx261 to i8*, !dbg !244
  %136 = bitcast %struct.dcomplex* %.compoundliteral262 to i8*, !dbg !244
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %135, i8* align 8 %136, i64 16, i1 false), !dbg !244
  %arrayidx265 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 20, !dbg !245
  %real267 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral266, i32 0, i32 0, !dbg !246
  store double 0x408007C58371022F, double* %real267, align 8, !dbg !246
  %imag268 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral266, i32 0, i32 1, !dbg !246
  store double 0x408002C5AA6407B6, double* %imag268, align 8, !dbg !246
  %137 = bitcast %struct.dcomplex* %arrayidx265 to i8*, !dbg !246
  %138 = bitcast %struct.dcomplex* %.compoundliteral266 to i8*, !dbg !246
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %137, i8* align 8 %138, i64 16, i1 false), !dbg !246
  br label %if.end489, !dbg !247

if.else269:                                       ; preds = %land.lhs.true186, %land.lhs.true184, %land.lhs.true182, %if.else180
  %139 = load i32, i32* %n1.addr, align 4, !dbg !248
  %cmp270 = icmp eq i32 %139, 2048, !dbg !250
  br i1 %cmp270, label %land.lhs.true271, label %if.else378, !dbg !251

land.lhs.true271:                                 ; preds = %if.else269
  %140 = load i32, i32* %n2.addr, align 4, !dbg !252
  %cmp272 = icmp eq i32 %140, 1024, !dbg !253
  br i1 %cmp272, label %land.lhs.true273, label %if.else378, !dbg !254

land.lhs.true273:                                 ; preds = %land.lhs.true271
  %141 = load i32, i32* %n3.addr, align 4, !dbg !255
  %cmp274 = icmp eq i32 %141, 1024, !dbg !256
  br i1 %cmp274, label %land.lhs.true275, label %if.else378, !dbg !257

land.lhs.true275:                                 ; preds = %land.lhs.true273
  %142 = load i32, i32* %nt.addr, align 4, !dbg !258
  %cmp276 = icmp eq i32 %142, 25, !dbg !259
  br i1 %cmp276, label %if.then277, label %if.else378, !dbg !260

if.then277:                                       ; preds = %land.lhs.true275
  %arrayidx278 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 1, !dbg !261
  %real280 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral279, i32 0, i32 0, !dbg !263
  store double 0x408001C8B7A5243B, double* %real280, align 8, !dbg !263
  %imag281 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral279, i32 0, i32 1, !dbg !263
  store double 0x407FFDA78AA6499C, double* %imag281, align 8, !dbg !263
  %143 = bitcast %struct.dcomplex* %arrayidx278 to i8*, !dbg !263
  %144 = bitcast %struct.dcomplex* %.compoundliteral279 to i8*, !dbg !263
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %143, i8* align 8 %144, i64 16, i1 false), !dbg !263
  %arrayidx282 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 2, !dbg !264
  %real284 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral283, i32 0, i32 0, !dbg !265
  store double 0x4080005F05B14D73, double* %real284, align 8, !dbg !265
  %imag285 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral283, i32 0, i32 1, !dbg !265
  store double 0x407FFB4C42805D51, double* %imag285, align 8, !dbg !265
  %145 = bitcast %struct.dcomplex* %arrayidx282 to i8*, !dbg !265
  %146 = bitcast %struct.dcomplex* %.compoundliteral283 to i8*, !dbg !265
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %145, i8* align 8 %146, i64 16, i1 false), !dbg !265
  %arrayidx286 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 3, !dbg !266
  %real288 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral287, i32 0, i32 0, !dbg !267
  store double 0x407FFFC9049FE6AA, double* %real288, align 8, !dbg !267
  %imag289 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral287, i32 0, i32 1, !dbg !267
  store double 0x407FFB5AABC2C2DC, double* %imag289, align 8, !dbg !267
  %147 = bitcast %struct.dcomplex* %arrayidx286 to i8*, !dbg !267
  %148 = bitcast %struct.dcomplex* %.compoundliteral287 to i8*, !dbg !267
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %147, i8* align 8 %148, i64 16, i1 false), !dbg !267
  %arrayidx290 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 4, !dbg !268
  %real292 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral291, i32 0, i32 0, !dbg !269
  store double 0x407FFF3AE6781D07, double* %real292, align 8, !dbg !269
  %imag293 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral291, i32 0, i32 1, !dbg !269
  store double 0x407FFBCC55AD30A5, double* %imag293, align 8, !dbg !269
  %149 = bitcast %struct.dcomplex* %arrayidx290 to i8*, !dbg !269
  %150 = bitcast %struct.dcomplex* %.compoundliteral291 to i8*, !dbg !269
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %149, i8* align 8 %150, i64 16, i1 false), !dbg !269
  %arrayidx294 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 5, !dbg !270
  %real296 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral295, i32 0, i32 0, !dbg !271
  store double 0x407FFED49E586270, double* %real296, align 8, !dbg !271
  %imag297 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral295, i32 0, i32 1, !dbg !271
  store double 0x407FFC49DED1E229, double* %imag297, align 8, !dbg !271
  %151 = bitcast %struct.dcomplex* %arrayidx294 to i8*, !dbg !271
  %152 = bitcast %struct.dcomplex* %.compoundliteral295 to i8*, !dbg !271
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %151, i8* align 8 %152, i64 16, i1 false), !dbg !271
  %arrayidx298 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 6, !dbg !272
  %real300 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral299, i32 0, i32 0, !dbg !273
  store double 0x407FFE88286F1600, double* %real300, align 8, !dbg !273
  %imag301 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral299, i32 0, i32 1, !dbg !273
  store double 0x407FFCBFA44E2DA9, double* %imag301, align 8, !dbg !273
  %153 = bitcast %struct.dcomplex* %arrayidx298 to i8*, !dbg !273
  %154 = bitcast %struct.dcomplex* %.compoundliteral299 to i8*, !dbg !273
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %153, i8* align 8 %154, i64 16, i1 false), !dbg !273
  %arrayidx302 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 7, !dbg !274
  %real304 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral303, i32 0, i32 0, !dbg !275
  store double 0x407FFE4F62F012B7, double* %real304, align 8, !dbg !275
  %imag305 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral303, i32 0, i32 1, !dbg !275
  store double 0x407FFD2913502BF7, double* %imag305, align 8, !dbg !275
  %155 = bitcast %struct.dcomplex* %arrayidx302 to i8*, !dbg !275
  %156 = bitcast %struct.dcomplex* %.compoundliteral303 to i8*, !dbg !275
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %155, i8* align 8 %156, i64 16, i1 false), !dbg !275
  %arrayidx306 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 8, !dbg !276
  %real308 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral307, i32 0, i32 0, !dbg !277
  store double 0x407FFE25D7467D87, double* %real308, align 8, !dbg !277
  %imag309 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral307, i32 0, i32 1, !dbg !277
  store double 0x407FFD85C991CC1E, double* %imag309, align 8, !dbg !277
  %157 = bitcast %struct.dcomplex* %arrayidx306 to i8*, !dbg !277
  %158 = bitcast %struct.dcomplex* %.compoundliteral307 to i8*, !dbg !277
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %157, i8* align 8 %158, i64 16, i1 false), !dbg !277
  %arrayidx310 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 9, !dbg !278
  %real312 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral311, i32 0, i32 0, !dbg !279
  store double 0x407FFE07F5F9461B, double* %real312, align 8, !dbg !279
  %imag313 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral311, i32 0, i32 1, !dbg !279
  store double 0x407FFDD6ADE6AA2F, double* %imag313, align 8, !dbg !279
  %159 = bitcast %struct.dcomplex* %arrayidx310 to i8*, !dbg !279
  %160 = bitcast %struct.dcomplex* %.compoundliteral311 to i8*, !dbg !279
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %159, i8* align 8 %160, i64 16, i1 false), !dbg !279
  %arrayidx314 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 10, !dbg !280
  %real316 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral315, i32 0, i32 0, !dbg !281
  store double 0x407FFDF2F9E3CE75, double* %real316, align 8, !dbg !281
  %imag317 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral315, i32 0, i32 1, !dbg !281
  store double 0x407FFE1D0052370F, double* %imag317, align 8, !dbg !281
  %161 = bitcast %struct.dcomplex* %arrayidx314 to i8*, !dbg !281
  %162 = bitcast %struct.dcomplex* %.compoundliteral315 to i8*, !dbg !281
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %161, i8* align 8 %162, i64 16, i1 false), !dbg !281
  %arrayidx318 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 11, !dbg !282
  %real320 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral319, i32 0, i32 0, !dbg !283
  store double 0x407FFDE4CA360F49, double* %real320, align 8, !dbg !283
  %imag321 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral319, i32 0, i32 1, !dbg !283
  store double 0x407FFE5A05B5973E, double* %imag321, align 8, !dbg !283
  %163 = bitcast %struct.dcomplex* %arrayidx318 to i8*, !dbg !283
  %164 = bitcast %struct.dcomplex* %.compoundliteral319 to i8*, !dbg !283
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %163, i8* align 8 %164, i64 16, i1 false), !dbg !283
  %arrayidx322 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 12, !dbg !284
  %real324 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral323, i32 0, i32 0, !dbg !285
  store double 0x407FFDDBD5F99711, double* %real324, align 8, !dbg !285
  %imag325 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral323, i32 0, i32 1, !dbg !285
  store double 0x407FFE8EEACAA874, double* %imag325, align 8, !dbg !285
  %165 = bitcast %struct.dcomplex* %arrayidx322 to i8*, !dbg !285
  %166 = bitcast %struct.dcomplex* %.compoundliteral323 to i8*, !dbg !285
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %165, i8* align 8 %166, i64 16, i1 false), !dbg !285
  %arrayidx326 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 13, !dbg !286
  %real328 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral327, i32 0, i32 0, !dbg !287
  store double 0x407FFDD6F2033D21, double* %real328, align 8, !dbg !287
  %imag329 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral327, i32 0, i32 1, !dbg !287
  store double 0x407FFEBCBBFA2EBF, double* %imag329, align 8, !dbg !287
  %167 = bitcast %struct.dcomplex* %arrayidx326 to i8*, !dbg !287
  %168 = bitcast %struct.dcomplex* %.compoundliteral327 to i8*, !dbg !287
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %167, i8* align 8 %168, i64 16, i1 false), !dbg !287
  %arrayidx330 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 14, !dbg !288
  %real332 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral331, i32 0, i32 0, !dbg !289
  store double 0x407FFDD53D74DC74, double* %real332, align 8, !dbg !289
  %imag333 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral331, i32 0, i32 1, !dbg !289
  store double 0x407FFEE46511649D, double* %imag333, align 8, !dbg !289
  %169 = bitcast %struct.dcomplex* %arrayidx330 to i8*, !dbg !289
  %170 = bitcast %struct.dcomplex* %.compoundliteral331 to i8*, !dbg !289
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %169, i8* align 8 %170, i64 16, i1 false), !dbg !289
  %arrayidx334 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 15, !dbg !290
  %real336 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral335, i32 0, i32 0, !dbg !291
  store double 0x407FFDD60D2DB5D2, double* %real336, align 8, !dbg !291
  %imag337 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral335, i32 0, i32 1, !dbg !291
  store double 0x407FFF06B3C01AEA, double* %imag337, align 8, !dbg !291
  %171 = bitcast %struct.dcomplex* %arrayidx334 to i8*, !dbg !291
  %172 = bitcast %struct.dcomplex* %.compoundliteral335 to i8*, !dbg !291
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %171, i8* align 8 %172, i64 16, i1 false), !dbg !291
  %arrayidx338 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 16, !dbg !292
  %real340 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral339, i32 0, i32 0, !dbg !293
  store double 0x407FFDD8DD056A7D, double* %real340, align 8, !dbg !293
  %imag341 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral339, i32 0, i32 1, !dbg !293
  store double 0x407FFF245ADF0BCE, double* %imag341, align 8, !dbg !293
  %173 = bitcast %struct.dcomplex* %arrayidx338 to i8*, !dbg !293
  %174 = bitcast %struct.dcomplex* %.compoundliteral339 to i8*, !dbg !293
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %173, i8* align 8 %174, i64 16, i1 false), !dbg !293
  %arrayidx342 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 17, !dbg !294
  %real344 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral343, i32 0, i32 0, !dbg !295
  store double 0x407FFDDD45618FE6, double* %real344, align 8, !dbg !295
  %imag345 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral343, i32 0, i32 1, !dbg !295
  store double 0x407FFF3DF5BAB029, double* %imag345, align 8, !dbg !295
  %175 = bitcast %struct.dcomplex* %arrayidx342 to i8*, !dbg !295
  %176 = bitcast %struct.dcomplex* %.compoundliteral343 to i8*, !dbg !295
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %175, i8* align 8 %176, i64 16, i1 false), !dbg !295
  %arrayidx346 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 18, !dbg !296
  %real348 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral347, i32 0, i32 0, !dbg !297
  store double 0x407FFDE2F3E650B3, double* %real348, align 8, !dbg !297
  %imag349 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral347, i32 0, i32 1, !dbg !297
  store double 0x407FFF540B1CF5A1, double* %imag349, align 8, !dbg !297
  %177 = bitcast %struct.dcomplex* %arrayidx346 to i8*, !dbg !297
  %178 = bitcast %struct.dcomplex* %.compoundliteral347 to i8*, !dbg !297
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %177, i8* align 8 %178, i64 16, i1 false), !dbg !297
  %arrayidx350 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 19, !dbg !298
  %real352 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral351, i32 0, i32 0, !dbg !299
  store double 0x407FFDE9A64E1245, double* %real352, align 8, !dbg !299
  %imag353 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral351, i32 0, i32 1, !dbg !299
  store double 0x407FFF671002DAE5, double* %imag353, align 8, !dbg !299
  %179 = bitcast %struct.dcomplex* %arrayidx350 to i8*, !dbg !299
  %180 = bitcast %struct.dcomplex* %.compoundliteral351 to i8*, !dbg !299
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %179, i8* align 8 %180, i64 16, i1 false), !dbg !299
  %arrayidx354 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 20, !dbg !300
  %real356 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral355, i32 0, i32 0, !dbg !301
  store double 0x407FFDF126BADF21, double* %real356, align 8, !dbg !301
  %imag357 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral355, i32 0, i32 1, !dbg !301
  store double 0x407FFF7769FD4D32, double* %imag357, align 8, !dbg !301
  %181 = bitcast %struct.dcomplex* %arrayidx354 to i8*, !dbg !301
  %182 = bitcast %struct.dcomplex* %.compoundliteral355 to i8*, !dbg !301
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %181, i8* align 8 %182, i64 16, i1 false), !dbg !301
  %arrayidx358 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 21, !dbg !302
  %real360 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral359, i32 0, i32 0, !dbg !303
  store double 0x407FFDF94909BB13, double* %real360, align 8, !dbg !303
  %imag361 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral359, i32 0, i32 1, !dbg !303
  store double 0x407FFF85714411B2, double* %imag361, align 8, !dbg !303
  %183 = bitcast %struct.dcomplex* %arrayidx358 to i8*, !dbg !303
  %184 = bitcast %struct.dcomplex* %.compoundliteral359 to i8*, !dbg !303
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %183, i8* align 8 %184, i64 16, i1 false), !dbg !303
  %arrayidx362 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 22, !dbg !304
  %real364 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral363, i32 0, i32 0, !dbg !305
  store double 0x407FFE01E8D7E962, double* %real364, align 8, !dbg !305
  %imag365 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral363, i32 0, i32 1, !dbg !305
  store double 0x407FFF9172826820, double* %imag365, align 8, !dbg !305
  %185 = bitcast %struct.dcomplex* %arrayidx362 to i8*, !dbg !305
  %186 = bitcast %struct.dcomplex* %.compoundliteral363 to i8*, !dbg !305
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %185, i8* align 8 %186, i64 16, i1 false), !dbg !305
  %arrayidx366 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 23, !dbg !306
  %real368 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral367, i32 0, i32 0, !dbg !307
  store double 0x407FFE0AE8040E41, double* %real368, align 8, !dbg !307
  %imag369 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral367, i32 0, i32 1, !dbg !307
  store double 0x407FFF9BB06626E0, double* %imag369, align 8, !dbg !307
  %187 = bitcast %struct.dcomplex* %arrayidx366 to i8*, !dbg !307
  %188 = bitcast %struct.dcomplex* %.compoundliteral367 to i8*, !dbg !307
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %187, i8* align 8 %188, i64 16, i1 false), !dbg !307
  %arrayidx370 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 24, !dbg !308
  %real372 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral371, i32 0, i32 0, !dbg !309
  store double 0x407FFE142D872C17, double* %real372, align 8, !dbg !309
  %imag373 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral371, i32 0, i32 1, !dbg !309
  store double 0x407FFFA464F89DCE, double* %imag373, align 8, !dbg !309
  %189 = bitcast %struct.dcomplex* %arrayidx370 to i8*, !dbg !309
  %190 = bitcast %struct.dcomplex* %.compoundliteral371 to i8*, !dbg !309
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %189, i8* align 8 %190, i64 16, i1 false), !dbg !309
  %arrayidx374 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 25, !dbg !310
  %real376 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral375, i32 0, i32 0, !dbg !311
  store double 0x407FFE1DA48D386E, double* %real376, align 8, !dbg !311
  %imag377 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral375, i32 0, i32 1, !dbg !311
  store double 0x407FFFABC2C855DE, double* %imag377, align 8, !dbg !311
  %191 = bitcast %struct.dcomplex* %arrayidx374 to i8*, !dbg !311
  %192 = bitcast %struct.dcomplex* %.compoundliteral375 to i8*, !dbg !311
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %191, i8* align 8 %192, i64 16, i1 false), !dbg !311
  br label %if.end488, !dbg !312

if.else378:                                       ; preds = %land.lhs.true275, %land.lhs.true273, %land.lhs.true271, %if.else269
  %193 = load i32, i32* %n1.addr, align 4, !dbg !313
  %cmp379 = icmp eq i32 %193, 4096, !dbg !315
  br i1 %cmp379, label %land.lhs.true380, label %if.else487, !dbg !316

land.lhs.true380:                                 ; preds = %if.else378
  %194 = load i32, i32* %n2.addr, align 4, !dbg !317
  %cmp381 = icmp eq i32 %194, 2048, !dbg !318
  br i1 %cmp381, label %land.lhs.true382, label %if.else487, !dbg !319

land.lhs.true382:                                 ; preds = %land.lhs.true380
  %195 = load i32, i32* %n3.addr, align 4, !dbg !320
  %cmp383 = icmp eq i32 %195, 2048, !dbg !321
  br i1 %cmp383, label %land.lhs.true384, label %if.else487, !dbg !322

land.lhs.true384:                                 ; preds = %land.lhs.true382
  %196 = load i32, i32* %nt.addr, align 4, !dbg !323
  %cmp385 = icmp eq i32 %196, 25, !dbg !324
  br i1 %cmp385, label %if.then386, label %if.else487, !dbg !325

if.then386:                                       ; preds = %land.lhs.true384
  %arrayidx387 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 1, !dbg !326
  %real389 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral388, i32 0, i32 0, !dbg !328
  store double 0x40800147E4E2E063, double* %real389, align 8, !dbg !328
  %imag390 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral388, i32 0, i32 1, !dbg !328
  store double 0x407FFBD566A0B5FD, double* %imag390, align 8, !dbg !328
  %197 = bitcast %struct.dcomplex* %arrayidx387 to i8*, !dbg !328
  %198 = bitcast %struct.dcomplex* %.compoundliteral388 to i8*, !dbg !328
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %197, i8* align 8 %198, i64 16, i1 false), !dbg !328
  %arrayidx391 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 2, !dbg !329
  %real393 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral392, i32 0, i32 0, !dbg !330
  store double 0x408000B96D3A755A, double* %real393, align 8, !dbg !330
  %imag394 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral392, i32 0, i32 1, !dbg !330
  store double 0x407FFDC89676A99F, double* %imag394, align 8, !dbg !330
  %199 = bitcast %struct.dcomplex* %arrayidx391 to i8*, !dbg !330
  %200 = bitcast %struct.dcomplex* %.compoundliteral392 to i8*, !dbg !330
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %199, i8* align 8 %200, i64 16, i1 false), !dbg !330
  %arrayidx395 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 3, !dbg !331
  %real397 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral396, i32 0, i32 0, !dbg !332
  store double 0x4080007FA32A25BE, double* %real397, align 8, !dbg !332
  %imag398 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral396, i32 0, i32 1, !dbg !332
  store double 0x407FFE84CB3A10F8, double* %imag398, align 8, !dbg !332
  %201 = bitcast %struct.dcomplex* %arrayidx395 to i8*, !dbg !332
  %202 = bitcast %struct.dcomplex* %.compoundliteral396 to i8*, !dbg !332
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %201, i8* align 8 %202, i64 16, i1 false), !dbg !332
  %arrayidx399 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 4, !dbg !333
  %real401 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral400, i32 0, i32 0, !dbg !334
  store double 0x40800059C9C82B40, double* %real401, align 8, !dbg !334
  %imag402 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral400, i32 0, i32 1, !dbg !334
  store double 0x407FFEF414B87FD6, double* %imag402, align 8, !dbg !334
  %203 = bitcast %struct.dcomplex* %arrayidx399 to i8*, !dbg !334
  %204 = bitcast %struct.dcomplex* %.compoundliteral400 to i8*, !dbg !334
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %203, i8* align 8 %204, i64 16, i1 false), !dbg !334
  %arrayidx403 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 5, !dbg !335
  %real405 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral404, i32 0, i32 0, !dbg !336
  store double 0x4080003FCCB7C9C8, double* %real405, align 8, !dbg !336
  %imag406 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral404, i32 0, i32 1, !dbg !336
  store double 0x407FFF483912F11E, double* %imag406, align 8, !dbg !336
  %205 = bitcast %struct.dcomplex* %arrayidx403 to i8*, !dbg !336
  %206 = bitcast %struct.dcomplex* %.compoundliteral404 to i8*, !dbg !336
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %205, i8* align 8 %206, i64 16, i1 false), !dbg !336
  %arrayidx407 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 6, !dbg !337
  %real409 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral408, i32 0, i32 0, !dbg !338
  store double 0x4080002E4D90A084, double* %real409, align 8, !dbg !338
  %imag410 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral408, i32 0, i32 1, !dbg !338
  store double 0x407FFF8D62BCE558, double* %imag410, align 8, !dbg !338
  %207 = bitcast %struct.dcomplex* %arrayidx407 to i8*, !dbg !338
  %208 = bitcast %struct.dcomplex* %.compoundliteral408 to i8*, !dbg !338
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %207, i8* align 8 %208, i64 16, i1 false), !dbg !338
  %arrayidx411 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 7, !dbg !339
  %real413 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral412, i32 0, i32 0, !dbg !340
  store double 0x40800022AC039D7C, double* %real413, align 8, !dbg !340
  %imag414 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral412, i32 0, i32 1, !dbg !340
  store double 0x407FFFC737C3F7CD, double* %imag414, align 8, !dbg !340
  %209 = bitcast %struct.dcomplex* %arrayidx411 to i8*, !dbg !340
  %210 = bitcast %struct.dcomplex* %.compoundliteral412 to i8*, !dbg !340
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %209, i8* align 8 %210, i64 16, i1 false), !dbg !340
  %arrayidx415 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 8, !dbg !341
  %real417 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral416, i32 0, i32 0, !dbg !342
  store double 0x4080001ADFFA71B9, double* %real417, align 8, !dbg !342
  %imag418 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral416, i32 0, i32 1, !dbg !342
  store double 0x407FFFF78C336255, double* %imag418, align 8, !dbg !342
  %211 = bitcast %struct.dcomplex* %arrayidx415 to i8*, !dbg !342
  %212 = bitcast %struct.dcomplex* %.compoundliteral416 to i8*, !dbg !342
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %211, i8* align 8 %212, i64 16, i1 false), !dbg !342
  %arrayidx419 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 9, !dbg !343
  %real421 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral420, i32 0, i32 0, !dbg !344
  store double 0x4080001574D0520C, double* %real421, align 8, !dbg !344
  %imag422 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral420, i32 0, i32 1, !dbg !344
  store double 0x4080000FE85C03E9, double* %imag422, align 8, !dbg !344
  %213 = bitcast %struct.dcomplex* %arrayidx419 to i8*, !dbg !344
  %214 = bitcast %struct.dcomplex* %.compoundliteral420 to i8*, !dbg !344
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %213, i8* align 8 %214, i64 16, i1 false), !dbg !344
  %arrayidx423 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 10, !dbg !345
  %real425 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral424, i32 0, i32 0, !dbg !346
  store double 0x408000116F284244, double* %real425, align 8, !dbg !346
  %imag426 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral424, i32 0, i32 1, !dbg !346
  store double 0x40800020A7695837, double* %imag426, align 8, !dbg !346
  %215 = bitcast %struct.dcomplex* %arrayidx423 to i8*, !dbg !346
  %216 = bitcast %struct.dcomplex* %.compoundliteral424 to i8*, !dbg !346
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %215, i8* align 8 %216, i64 16, i1 false), !dbg !346
  %arrayidx427 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 11, !dbg !347
  %real429 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral428, i32 0, i32 0, !dbg !348
  store double 0x4080000E2D56813F, double* %real429, align 8, !dbg !348
  %imag430 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral428, i32 0, i32 1, !dbg !348
  store double 0x4080002E951F7B34, double* %imag430, align 8, !dbg !348
  %217 = bitcast %struct.dcomplex* %arrayidx427 to i8*, !dbg !348
  %218 = bitcast %struct.dcomplex* %.compoundliteral428 to i8*, !dbg !348
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %217, i8* align 8 %218, i64 16, i1 false), !dbg !348
  %arrayidx431 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 12, !dbg !349
  %real433 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral432, i32 0, i32 0, !dbg !350
  store double 0x4080000B4BE05864, double* %real433, align 8, !dbg !350
  %imag434 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral432, i32 0, i32 1, !dbg !350
  store double 0x4080003A2ED08404, double* %imag434, align 8, !dbg !350
  %219 = bitcast %struct.dcomplex* %arrayidx431 to i8*, !dbg !350
  %220 = bitcast %struct.dcomplex* %.compoundliteral432 to i8*, !dbg !350
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %219, i8* align 8 %220, i64 16, i1 false), !dbg !350
  %arrayidx435 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 13, !dbg !351
  %real437 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral436, i32 0, i32 0, !dbg !352
  store double 0x408000089094AC2D, double* %real437, align 8, !dbg !352
  %imag438 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral436, i32 0, i32 1, !dbg !352
  store double 0x40800043DD87C2F3, double* %imag438, align 8, !dbg !352
  %221 = bitcast %struct.dcomplex* %arrayidx435 to i8*, !dbg !352
  %222 = bitcast %struct.dcomplex* %.compoundliteral436 to i8*, !dbg !352
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %221, i8* align 8 %222, i64 16, i1 false), !dbg !352
  %arrayidx439 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 14, !dbg !353
  %real441 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral440, i32 0, i32 0, !dbg !354
  store double 0x40800005DBBF34DD, double* %real441, align 8, !dbg !354
  %imag442 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral440, i32 0, i32 1, !dbg !354
  store double 0x4080004BF7DEAC1A, double* %imag442, align 8, !dbg !354
  %223 = bitcast %struct.dcomplex* %arrayidx439 to i8*, !dbg !354
  %224 = bitcast %struct.dcomplex* %.compoundliteral440 to i8*, !dbg !354
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %223, i8* align 8 %224, i64 16, i1 false), !dbg !354
  %arrayidx443 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 15, !dbg !355
  %real445 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral444, i32 0, i32 0, !dbg !356
  store double 0x408000031E1FCB83, double* %real445, align 8, !dbg !356
  %imag446 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral444, i32 0, i32 1, !dbg !356
  store double 0x40800052C48391C0, double* %imag446, align 8, !dbg !356
  %225 = bitcast %struct.dcomplex* %arrayidx443 to i8*, !dbg !356
  %226 = bitcast %struct.dcomplex* %.compoundliteral444 to i8*, !dbg !356
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %225, i8* align 8 %226, i64 16, i1 false), !dbg !356
  %arrayidx447 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 16, !dbg !357
  %real449 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral448, i32 0, i32 0, !dbg !358
  store double 0x4080000052507A84, double* %real449, align 8, !dbg !358
  %imag450 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral448, i32 0, i32 1, !dbg !358
  store double 0x408000587CD9C3A1, double* %imag450, align 8, !dbg !358
  %227 = bitcast %struct.dcomplex* %arrayidx447 to i8*, !dbg !358
  %228 = bitcast %struct.dcomplex* %.compoundliteral448 to i8*, !dbg !358
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %227, i8* align 8 %228, i64 16, i1 false), !dbg !358
  %arrayidx451 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 17, !dbg !359
  %real453 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral452, i32 0, i32 0, !dbg !360
  store double 0x407FFFFAF1111C29, double* %real453, align 8, !dbg !360
  %imag454 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral452, i32 0, i32 1, !dbg !360
  store double 0x4080005D4F648E97, double* %imag454, align 8, !dbg !360
  %229 = bitcast %struct.dcomplex* %arrayidx451 to i8*, !dbg !360
  %230 = bitcast %struct.dcomplex* %.compoundliteral452 to i8*, !dbg !360
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %229, i8* align 8 %230, i64 16, i1 false), !dbg !360
  %arrayidx455 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 18, !dbg !361
  %real457 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral456, i32 0, i32 0, !dbg !362
  store double 0x407FFFF527E792B0, double* %real457, align 8, !dbg !362
  %imag458 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral456, i32 0, i32 1, !dbg !362
  store double 0x4080006161DD7A20, double* %imag458, align 8, !dbg !362
  %231 = bitcast %struct.dcomplex* %arrayidx455 to i8*, !dbg !362
  %232 = bitcast %struct.dcomplex* %.compoundliteral456 to i8*, !dbg !362
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %231, i8* align 8 %232, i64 16, i1 false), !dbg !362
  %arrayidx459 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 19, !dbg !363
  %real461 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral460, i32 0, i32 0, !dbg !364
  store double 0x407FFFEF5224A658, double* %real461, align 8, !dbg !364
  %imag462 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral460, i32 0, i32 1, !dbg !364
  store double 0x40800064D2F0E0FB, double* %imag462, align 8, !dbg !364
  %233 = bitcast %struct.dcomplex* %arrayidx459 to i8*, !dbg !364
  %234 = bitcast %struct.dcomplex* %.compoundliteral460 to i8*, !dbg !364
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %233, i8* align 8 %234, i64 16, i1 false), !dbg !364
  %arrayidx463 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 20, !dbg !365
  %real465 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral464, i32 0, i32 0, !dbg !366
  store double 0x407FFFE97985082F, double* %real465, align 8, !dbg !366
  %imag466 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral464, i32 0, i32 1, !dbg !366
  store double 0x40800067BBA76761, double* %imag466, align 8, !dbg !366
  %235 = bitcast %struct.dcomplex* %arrayidx463 to i8*, !dbg !366
  %236 = bitcast %struct.dcomplex* %.compoundliteral464 to i8*, !dbg !366
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %235, i8* align 8 %236, i64 16, i1 false), !dbg !366
  %arrayidx467 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 21, !dbg !367
  %real469 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral468, i32 0, i32 0, !dbg !368
  store double 0x407FFFE3A76CE198, double* %real469, align 8, !dbg !368
  %imag470 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral468, i32 0, i32 1, !dbg !368
  store double 0x4080006A3087F53C, double* %imag470, align 8, !dbg !368
  %237 = bitcast %struct.dcomplex* %arrayidx467 to i8*, !dbg !368
  %238 = bitcast %struct.dcomplex* %.compoundliteral468 to i8*, !dbg !368
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %237, i8* align 8 %238, i64 16, i1 false), !dbg !368
  %arrayidx471 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 22, !dbg !369
  %real473 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral472, i32 0, i32 0, !dbg !370
  store double 0x407FFFDDE458AC2A, double* %real473, align 8, !dbg !370
  %imag474 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral472, i32 0, i32 1, !dbg !370
  store double 0x4080006C427E60CB, double* %imag474, align 8, !dbg !370
  %239 = bitcast %struct.dcomplex* %arrayidx471 to i8*, !dbg !370
  %240 = bitcast %struct.dcomplex* %.compoundliteral472 to i8*, !dbg !370
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %239, i8* align 8 %240, i64 16, i1 false), !dbg !370
  %arrayidx475 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 23, !dbg !371
  %real477 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral476, i32 0, i32 0, !dbg !372
  store double 0x407FFFD8379EC190, double* %real477, align 8, !dbg !372
  %imag478 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral476, i32 0, i32 1, !dbg !372
  store double 0x4080006DFF9235BC, double* %imag478, align 8, !dbg !372
  %241 = bitcast %struct.dcomplex* %arrayidx475 to i8*, !dbg !372
  %242 = bitcast %struct.dcomplex* %.compoundliteral476 to i8*, !dbg !372
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %241, i8* align 8 %242, i64 16, i1 false), !dbg !372
  %arrayidx479 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 24, !dbg !373
  %real481 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral480, i32 0, i32 0, !dbg !374
  store double 0x407FFFD2A76113A7, double* %real481, align 8, !dbg !374
  %imag482 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral480, i32 0, i32 1, !dbg !374
  store double 0x4080006F7377203C, double* %imag482, align 8, !dbg !374
  %243 = bitcast %struct.dcomplex* %arrayidx479 to i8*, !dbg !374
  %244 = bitcast %struct.dcomplex* %.compoundliteral480 to i8*, !dbg !374
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %243, i8* align 8 %244, i64 16, i1 false), !dbg !374
  %arrayidx483 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 25, !dbg !375
  %real485 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral484, i32 0, i32 0, !dbg !376
  store double 0x407FFFCD389947BC, double* %real485, align 8, !dbg !376
  %imag486 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral484, i32 0, i32 1, !dbg !376
  store double 0x40800070A7FF2BFD, double* %imag486, align 8, !dbg !376
  %245 = bitcast %struct.dcomplex* %arrayidx483 to i8*, !dbg !376
  %246 = bitcast %struct.dcomplex* %.compoundliteral484 to i8*, !dbg !376
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %245, i8* align 8 %246, i64 16, i1 false), !dbg !376
  br label %if.end, !dbg !377

if.else487:                                       ; preds = %land.lhs.true384, %land.lhs.true382, %land.lhs.true380, %if.else378
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str, i64 0, i64 0)), !dbg !378
  %247 = load i32*, i32** %verified.addr, align 8, !dbg !380
  store i32 0, i32* %247, align 4, !dbg !381
  br label %if.end

if.end:                                           ; preds = %if.else487, %if.then386
  br label %if.end488

if.end488:                                        ; preds = %if.end, %if.then277
  br label %if.end489

if.end489:                                        ; preds = %if.end488, %if.then188
  br label %if.end490

if.end490:                                        ; preds = %if.end489, %if.then99
  br label %if.end491

if.end491:                                        ; preds = %if.end490, %if.then66
  br label %if.end492

if.end492:                                        ; preds = %if.end491, %if.then33
  br label %if.end493

if.end493:                                        ; preds = %if.end492, %if.then
  %248 = load i32*, i32** %verified.addr, align 8, !dbg !382
  %249 = load i32, i32* %248, align 4, !dbg !384
  %tobool = icmp ne i32 %249, 0, !dbg !384
  br i1 %tobool, label %if.then494, label %if.end594, !dbg !385

if.then494:                                       ; preds = %if.end493
  store i32 1, i32* %kt, align 4, !dbg !386
  br label %for.cond, !dbg !389

for.cond:                                         ; preds = %for.inc, %if.then494
  %250 = load i32, i32* %kt, align 4, !dbg !390
  %251 = load i32, i32* %nt.addr, align 4, !dbg !392
  %cmp495 = icmp sle i32 %250, %251, !dbg !393
  br i1 %cmp495, label %for.body, label %for.end, !dbg !394

for.body:                                         ; preds = %for.cond
  %252 = load i32, i32* %kt, align 4, !dbg !395
  %call496 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i64 0, i64 0), i32 %252), !dbg !397
  %real498 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral497, i32 0, i32 0, !dbg !398
  %253 = load %struct.dcomplex*, %struct.dcomplex** %cksum.addr, align 8, !dbg !398
  %254 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom = sext i32 %254 to i64, !dbg !398
  %arrayidx499 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %253, i64 %idxprom, !dbg !398
  %real500 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx499, i32 0, i32 0, !dbg !398
  %255 = load double, double* %real500, align 8, !dbg !398
  %256 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom501 = sext i32 %256 to i64, !dbg !398
  %arrayidx502 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 %idxprom501, !dbg !398
  %real503 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx502, i32 0, i32 0, !dbg !398
  %257 = load double, double* %real503, align 16, !dbg !398
  %sub = fsub double %255, %257, !dbg !398
  store double %sub, double* %real498, align 8, !dbg !398
  %imag504 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral497, i32 0, i32 1, !dbg !398
  %258 = load %struct.dcomplex*, %struct.dcomplex** %cksum.addr, align 8, !dbg !398
  %259 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom505 = sext i32 %259 to i64, !dbg !398
  %arrayidx506 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %258, i64 %idxprom505, !dbg !398
  %imag507 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx506, i32 0, i32 1, !dbg !398
  %260 = load double, double* %imag507, align 8, !dbg !398
  %261 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom508 = sext i32 %261 to i64, !dbg !398
  %arrayidx509 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 %idxprom508, !dbg !398
  %imag510 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx509, i32 0, i32 1, !dbg !398
  %262 = load double, double* %imag510, align 8, !dbg !398
  %sub511 = fsub double %260, %262, !dbg !398
  store double %sub511, double* %imag504, align 8, !dbg !398
  %263 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom512 = sext i32 %263 to i64, !dbg !398
  %arrayidx513 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 %idxprom512, !dbg !398
  %264 = bitcast %struct.dcomplex* %.compoundliteral497 to { double, double }*, !dbg !398
  %265 = getelementptr inbounds { double, double }, { double, double }* %264, i32 0, i32 0, !dbg !398
  %266 = load double, double* %265, align 8, !dbg !398
  %267 = getelementptr inbounds { double, double }, { double, double }* %264, i32 0, i32 1, !dbg !398
  %268 = load double, double* %267, align 8, !dbg !398
  %269 = bitcast %struct.dcomplex* %arrayidx513 to { double, double }*, !dbg !398
  %270 = getelementptr inbounds { double, double }, { double, double }* %269, i32 0, i32 0, !dbg !398
  %271 = load double, double* %270, align 16, !dbg !398
  %272 = getelementptr inbounds { double, double }, { double, double }* %269, i32 0, i32 1, !dbg !398
  %273 = load double, double* %272, align 8, !dbg !398
  %call514 = call { double, double } @dcmplx_div(double %266, double %268, double %271, double %273), !dbg !398
  %274 = bitcast %struct.dcomplex* %coerce to { double, double }*, !dbg !398
  %275 = getelementptr inbounds { double, double }, { double, double }* %274, i32 0, i32 0, !dbg !398
  %276 = extractvalue { double, double } %call514, 0, !dbg !398
  store double %276, double* %275, align 8, !dbg !398
  %277 = getelementptr inbounds { double, double }, { double, double }* %274, i32 0, i32 1, !dbg !398
  %278 = extractvalue { double, double } %call514, 1, !dbg !398
  store double %278, double* %277, align 8, !dbg !398
  %real515 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %coerce, i32 0, i32 0, !dbg !398
  %279 = load double, double* %real515, align 8, !dbg !398
  %real517 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral516, i32 0, i32 0, !dbg !398
  %280 = load %struct.dcomplex*, %struct.dcomplex** %cksum.addr, align 8, !dbg !398
  %281 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom518 = sext i32 %281 to i64, !dbg !398
  %arrayidx519 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %280, i64 %idxprom518, !dbg !398
  %real520 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx519, i32 0, i32 0, !dbg !398
  %282 = load double, double* %real520, align 8, !dbg !398
  %283 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom521 = sext i32 %283 to i64, !dbg !398
  %arrayidx522 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 %idxprom521, !dbg !398
  %real523 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx522, i32 0, i32 0, !dbg !398
  %284 = load double, double* %real523, align 16, !dbg !398
  %sub524 = fsub double %282, %284, !dbg !398
  store double %sub524, double* %real517, align 8, !dbg !398
  %imag525 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral516, i32 0, i32 1, !dbg !398
  %285 = load %struct.dcomplex*, %struct.dcomplex** %cksum.addr, align 8, !dbg !398
  %286 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom526 = sext i32 %286 to i64, !dbg !398
  %arrayidx527 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %285, i64 %idxprom526, !dbg !398
  %imag528 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx527, i32 0, i32 1, !dbg !398
  %287 = load double, double* %imag528, align 8, !dbg !398
  %288 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom529 = sext i32 %288 to i64, !dbg !398
  %arrayidx530 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 %idxprom529, !dbg !398
  %imag531 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx530, i32 0, i32 1, !dbg !398
  %289 = load double, double* %imag531, align 8, !dbg !398
  %sub532 = fsub double %287, %289, !dbg !398
  store double %sub532, double* %imag525, align 8, !dbg !398
  %290 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom533 = sext i32 %290 to i64, !dbg !398
  %arrayidx534 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 %idxprom533, !dbg !398
  %291 = bitcast %struct.dcomplex* %.compoundliteral516 to { double, double }*, !dbg !398
  %292 = getelementptr inbounds { double, double }, { double, double }* %291, i32 0, i32 0, !dbg !398
  %293 = load double, double* %292, align 8, !dbg !398
  %294 = getelementptr inbounds { double, double }, { double, double }* %291, i32 0, i32 1, !dbg !398
  %295 = load double, double* %294, align 8, !dbg !398
  %296 = bitcast %struct.dcomplex* %arrayidx534 to { double, double }*, !dbg !398
  %297 = getelementptr inbounds { double, double }, { double, double }* %296, i32 0, i32 0, !dbg !398
  %298 = load double, double* %297, align 16, !dbg !398
  %299 = getelementptr inbounds { double, double }, { double, double }* %296, i32 0, i32 1, !dbg !398
  %300 = load double, double* %299, align 8, !dbg !398
  %call535 = call { double, double } @dcmplx_div(double %293, double %295, double %298, double %300), !dbg !398
  %301 = bitcast %struct.dcomplex* %coerce536 to { double, double }*, !dbg !398
  %302 = getelementptr inbounds { double, double }, { double, double }* %301, i32 0, i32 0, !dbg !398
  %303 = extractvalue { double, double } %call535, 0, !dbg !398
  store double %303, double* %302, align 8, !dbg !398
  %304 = getelementptr inbounds { double, double }, { double, double }* %301, i32 0, i32 1, !dbg !398
  %305 = extractvalue { double, double } %call535, 1, !dbg !398
  store double %305, double* %304, align 8, !dbg !398
  %real537 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %coerce536, i32 0, i32 0, !dbg !398
  %306 = load double, double* %real537, align 8, !dbg !398
  %mul = fmul double %279, %306, !dbg !398
  %real539 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral538, i32 0, i32 0, !dbg !398
  %307 = load %struct.dcomplex*, %struct.dcomplex** %cksum.addr, align 8, !dbg !398
  %308 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom540 = sext i32 %308 to i64, !dbg !398
  %arrayidx541 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %307, i64 %idxprom540, !dbg !398
  %real542 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx541, i32 0, i32 0, !dbg !398
  %309 = load double, double* %real542, align 8, !dbg !398
  %310 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom543 = sext i32 %310 to i64, !dbg !398
  %arrayidx544 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 %idxprom543, !dbg !398
  %real545 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx544, i32 0, i32 0, !dbg !398
  %311 = load double, double* %real545, align 16, !dbg !398
  %sub546 = fsub double %309, %311, !dbg !398
  store double %sub546, double* %real539, align 8, !dbg !398
  %imag547 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral538, i32 0, i32 1, !dbg !398
  %312 = load %struct.dcomplex*, %struct.dcomplex** %cksum.addr, align 8, !dbg !398
  %313 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom548 = sext i32 %313 to i64, !dbg !398
  %arrayidx549 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %312, i64 %idxprom548, !dbg !398
  %imag550 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx549, i32 0, i32 1, !dbg !398
  %314 = load double, double* %imag550, align 8, !dbg !398
  %315 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom551 = sext i32 %315 to i64, !dbg !398
  %arrayidx552 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 %idxprom551, !dbg !398
  %imag553 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx552, i32 0, i32 1, !dbg !398
  %316 = load double, double* %imag553, align 8, !dbg !398
  %sub554 = fsub double %314, %316, !dbg !398
  store double %sub554, double* %imag547, align 8, !dbg !398
  %317 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom555 = sext i32 %317 to i64, !dbg !398
  %arrayidx556 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 %idxprom555, !dbg !398
  %318 = bitcast %struct.dcomplex* %.compoundliteral538 to { double, double }*, !dbg !398
  %319 = getelementptr inbounds { double, double }, { double, double }* %318, i32 0, i32 0, !dbg !398
  %320 = load double, double* %319, align 8, !dbg !398
  %321 = getelementptr inbounds { double, double }, { double, double }* %318, i32 0, i32 1, !dbg !398
  %322 = load double, double* %321, align 8, !dbg !398
  %323 = bitcast %struct.dcomplex* %arrayidx556 to { double, double }*, !dbg !398
  %324 = getelementptr inbounds { double, double }, { double, double }* %323, i32 0, i32 0, !dbg !398
  %325 = load double, double* %324, align 16, !dbg !398
  %326 = getelementptr inbounds { double, double }, { double, double }* %323, i32 0, i32 1, !dbg !398
  %327 = load double, double* %326, align 8, !dbg !398
  %call557 = call { double, double } @dcmplx_div(double %320, double %322, double %325, double %327), !dbg !398
  %328 = bitcast %struct.dcomplex* %coerce558 to { double, double }*, !dbg !398
  %329 = getelementptr inbounds { double, double }, { double, double }* %328, i32 0, i32 0, !dbg !398
  %330 = extractvalue { double, double } %call557, 0, !dbg !398
  store double %330, double* %329, align 8, !dbg !398
  %331 = getelementptr inbounds { double, double }, { double, double }* %328, i32 0, i32 1, !dbg !398
  %332 = extractvalue { double, double } %call557, 1, !dbg !398
  store double %332, double* %331, align 8, !dbg !398
  %imag559 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %coerce558, i32 0, i32 1, !dbg !398
  %333 = load double, double* %imag559, align 8, !dbg !398
  %real561 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral560, i32 0, i32 0, !dbg !398
  %334 = load %struct.dcomplex*, %struct.dcomplex** %cksum.addr, align 8, !dbg !398
  %335 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom562 = sext i32 %335 to i64, !dbg !398
  %arrayidx563 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %334, i64 %idxprom562, !dbg !398
  %real564 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx563, i32 0, i32 0, !dbg !398
  %336 = load double, double* %real564, align 8, !dbg !398
  %337 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom565 = sext i32 %337 to i64, !dbg !398
  %arrayidx566 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 %idxprom565, !dbg !398
  %real567 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx566, i32 0, i32 0, !dbg !398
  %338 = load double, double* %real567, align 16, !dbg !398
  %sub568 = fsub double %336, %338, !dbg !398
  store double %sub568, double* %real561, align 8, !dbg !398
  %imag569 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral560, i32 0, i32 1, !dbg !398
  %339 = load %struct.dcomplex*, %struct.dcomplex** %cksum.addr, align 8, !dbg !398
  %340 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom570 = sext i32 %340 to i64, !dbg !398
  %arrayidx571 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %339, i64 %idxprom570, !dbg !398
  %imag572 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx571, i32 0, i32 1, !dbg !398
  %341 = load double, double* %imag572, align 8, !dbg !398
  %342 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom573 = sext i32 %342 to i64, !dbg !398
  %arrayidx574 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 %idxprom573, !dbg !398
  %imag575 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx574, i32 0, i32 1, !dbg !398
  %343 = load double, double* %imag575, align 8, !dbg !398
  %sub576 = fsub double %341, %343, !dbg !398
  store double %sub576, double* %imag569, align 8, !dbg !398
  %344 = load i32, i32* %kt, align 4, !dbg !398
  %idxprom577 = sext i32 %344 to i64, !dbg !398
  %arrayidx578 = getelementptr inbounds [26 x %struct.dcomplex], [26 x %struct.dcomplex]* %cexpd, i64 0, i64 %idxprom577, !dbg !398
  %345 = bitcast %struct.dcomplex* %.compoundliteral560 to { double, double }*, !dbg !398
  %346 = getelementptr inbounds { double, double }, { double, double }* %345, i32 0, i32 0, !dbg !398
  %347 = load double, double* %346, align 8, !dbg !398
  %348 = getelementptr inbounds { double, double }, { double, double }* %345, i32 0, i32 1, !dbg !398
  %349 = load double, double* %348, align 8, !dbg !398
  %350 = bitcast %struct.dcomplex* %arrayidx578 to { double, double }*, !dbg !398
  %351 = getelementptr inbounds { double, double }, { double, double }* %350, i32 0, i32 0, !dbg !398
  %352 = load double, double* %351, align 16, !dbg !398
  %353 = getelementptr inbounds { double, double }, { double, double }* %350, i32 0, i32 1, !dbg !398
  %354 = load double, double* %353, align 8, !dbg !398
  %call579 = call { double, double } @dcmplx_div(double %347, double %349, double %352, double %354), !dbg !398
  %355 = bitcast %struct.dcomplex* %coerce580 to { double, double }*, !dbg !398
  %356 = getelementptr inbounds { double, double }, { double, double }* %355, i32 0, i32 0, !dbg !398
  %357 = extractvalue { double, double } %call579, 0, !dbg !398
  store double %357, double* %356, align 8, !dbg !398
  %358 = getelementptr inbounds { double, double }, { double, double }* %355, i32 0, i32 1, !dbg !398
  %359 = extractvalue { double, double } %call579, 1, !dbg !398
  store double %359, double* %358, align 8, !dbg !398
  %imag581 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %coerce580, i32 0, i32 1, !dbg !398
  %360 = load double, double* %imag581, align 8, !dbg !398
  %mul582 = fmul double %333, %360, !dbg !398
  %add583 = fadd double %mul, %mul582, !dbg !398
  %call584 = call double @sqrt(double %add583) #5, !dbg !398
  store double %call584, double* %err, align 8, !dbg !399
  %361 = load double, double* %err, align 8, !dbg !400
  %362 = load double, double* %epsilon, align 8, !dbg !402
  %cmp585 = fcmp ole double %361, %362, !dbg !403
  br i1 %cmp585, label %if.end587, label %if.then586, !dbg !404

if.then586:                                       ; preds = %for.body
  %363 = load i32*, i32** %verified.addr, align 8, !dbg !405
  store i32 0, i32* %363, align 4, !dbg !407
  br label %for.end, !dbg !408

if.end587:                                        ; preds = %for.body
  br label %for.inc, !dbg !409

for.inc:                                          ; preds = %if.end587
  %364 = load i32, i32* %kt, align 4, !dbg !410
  %inc = add nsw i32 %364, 1, !dbg !410
  store i32 %inc, i32* %kt, align 4, !dbg !410
  br label %for.cond, !dbg !411, !llvm.loop !412

for.end:                                          ; preds = %if.then586, %for.cond
  %365 = load i32*, i32** %verified.addr, align 8, !dbg !415
  %366 = load i32, i32* %365, align 4, !dbg !417
  %tobool588 = icmp ne i32 %366, 0, !dbg !417
  br i1 %tobool588, label %if.then589, label %if.else591, !dbg !418

if.then589:                                       ; preds = %for.end
  %call590 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.2, i64 0, i64 0)), !dbg !419
  br label %if.end593, !dbg !421

if.else591:                                       ; preds = %for.end
  %call592 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.3, i64 0, i64 0)), !dbg !422
  br label %if.end593

if.end593:                                        ; preds = %if.else591, %if.then589
  br label %if.end594, !dbg !424

if.end594:                                        ; preds = %if.end593, %if.end493
  ret void, !dbg !425
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

declare dso_local i32 @printf(i8*, ...) #3

; Function Attrs: nounwind
declare dso_local double @sqrt(double) #4

; Function Attrs: noinline nounwind optnone uwtable
define internal { double, double } @dcmplx_div(double %z1.coerce0, double %z1.coerce1, double %z2.coerce0, double %z2.coerce1) #0 !dbg !426 {
entry:
  %retval = alloca %struct.dcomplex, align 8
  %z1 = alloca %struct.dcomplex, align 8
  %z2 = alloca %struct.dcomplex, align 8
  %a = alloca double, align 8
  %b = alloca double, align 8
  %c = alloca double, align 8
  %d = alloca double, align 8
  %divisor = alloca double, align 8
  %real4 = alloca double, align 8
  %imag8 = alloca double, align 8
  %0 = bitcast %struct.dcomplex* %z1 to { double, double }*
  %1 = getelementptr inbounds { double, double }, { double, double }* %0, i32 0, i32 0
  store double %z1.coerce0, double* %1, align 8
  %2 = getelementptr inbounds { double, double }, { double, double }* %0, i32 0, i32 1
  store double %z1.coerce1, double* %2, align 8
  %3 = bitcast %struct.dcomplex* %z2 to { double, double }*
  %4 = getelementptr inbounds { double, double }, { double, double }* %3, i32 0, i32 0
  store double %z2.coerce0, double* %4, align 8
  %5 = getelementptr inbounds { double, double }, { double, double }* %3, i32 0, i32 1
  store double %z2.coerce1, double* %5, align 8
  call void @llvm.dbg.declare(metadata %struct.dcomplex* %z1, metadata !430, metadata !DIExpression()), !dbg !431
  call void @llvm.dbg.declare(metadata %struct.dcomplex* %z2, metadata !432, metadata !DIExpression()), !dbg !433
  call void @llvm.dbg.declare(metadata double* %a, metadata !434, metadata !DIExpression()), !dbg !435
  %real = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %z1, i32 0, i32 0, !dbg !436
  %6 = load double, double* %real, align 8, !dbg !436
  store double %6, double* %a, align 8, !dbg !435
  call void @llvm.dbg.declare(metadata double* %b, metadata !437, metadata !DIExpression()), !dbg !438
  %imag = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %z1, i32 0, i32 1, !dbg !439
  %7 = load double, double* %imag, align 8, !dbg !439
  store double %7, double* %b, align 8, !dbg !438
  call void @llvm.dbg.declare(metadata double* %c, metadata !440, metadata !DIExpression()), !dbg !441
  %real1 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %z2, i32 0, i32 0, !dbg !442
  %8 = load double, double* %real1, align 8, !dbg !442
  store double %8, double* %c, align 8, !dbg !441
  call void @llvm.dbg.declare(metadata double* %d, metadata !443, metadata !DIExpression()), !dbg !444
  %imag2 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %z2, i32 0, i32 1, !dbg !445
  %9 = load double, double* %imag2, align 8, !dbg !445
  store double %9, double* %d, align 8, !dbg !444
  call void @llvm.dbg.declare(metadata double* %divisor, metadata !446, metadata !DIExpression()), !dbg !447
  %10 = load double, double* %c, align 8, !dbg !448
  %11 = load double, double* %c, align 8, !dbg !449
  %mul = fmul double %10, %11, !dbg !450
  %12 = load double, double* %d, align 8, !dbg !451
  %13 = load double, double* %d, align 8, !dbg !452
  %mul3 = fmul double %12, %13, !dbg !453
  %add = fadd double %mul, %mul3, !dbg !454
  store double %add, double* %divisor, align 8, !dbg !447
  call void @llvm.dbg.declare(metadata double* %real4, metadata !455, metadata !DIExpression()), !dbg !456
  %14 = load double, double* %a, align 8, !dbg !457
  %15 = load double, double* %c, align 8, !dbg !458
  %mul5 = fmul double %14, %15, !dbg !459
  %16 = load double, double* %b, align 8, !dbg !460
  %17 = load double, double* %d, align 8, !dbg !461
  %mul6 = fmul double %16, %17, !dbg !462
  %add7 = fadd double %mul5, %mul6, !dbg !463
  %18 = load double, double* %divisor, align 8, !dbg !464
  %div = fdiv double %add7, %18, !dbg !465
  store double %div, double* %real4, align 8, !dbg !456
  call void @llvm.dbg.declare(metadata double* %imag8, metadata !466, metadata !DIExpression()), !dbg !467
  %19 = load double, double* %b, align 8, !dbg !468
  %20 = load double, double* %c, align 8, !dbg !469
  %mul9 = fmul double %19, %20, !dbg !470
  %21 = load double, double* %a, align 8, !dbg !471
  %22 = load double, double* %d, align 8, !dbg !472
  %mul10 = fmul double %21, %22, !dbg !473
  %sub = fsub double %mul9, %mul10, !dbg !474
  %23 = load double, double* %divisor, align 8, !dbg !475
  %div11 = fdiv double %sub, %23, !dbg !476
  store double %div11, double* %imag8, align 8, !dbg !467
  call void @llvm.dbg.declare(metadata %struct.dcomplex* %retval, metadata !477, metadata !DIExpression()), !dbg !478
  %real12 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %retval, i32 0, i32 0, !dbg !479
  %24 = load double, double* %real4, align 8, !dbg !480
  store double %24, double* %real12, align 8, !dbg !479
  %imag13 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %retval, i32 0, i32 1, !dbg !479
  %25 = load double, double* %imag8, align 8, !dbg !481
  store double %25, double* %imag13, align 8, !dbg !479
  %26 = bitcast %struct.dcomplex* %retval to { double, double }*, !dbg !482
  %27 = load { double, double }, { double, double }* %26, align 8, !dbg !482
  ret { double, double } %27, !dbg !482
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nofree nounwind willreturn }
attributes #3 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10, !11, !12, !13}
!llvm.ident = !{!14}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, debugInfoForProfiling: true, nameTableKind: None)
!1 = !DIFile(filename: "verify.c", directory: "/workspace/LLVM-Checker/test/benchmarks/NPB/FT")
!2 = !{!3}
!3 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !4, line: 4, baseType: !5, size: 32, elements: !6)
!4 = !DIFile(filename: "../common/type.h", directory: "/workspace/LLVM-Checker/test/benchmarks/NPB/FT")
!5 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!6 = !{!7, !8}
!7 = !DIEnumerator(name: "false", value: 0)
!8 = !DIEnumerator(name: "true", value: 1)
!9 = !{i32 7, !"Dwarf Version", i32 4}
!10 = !{i32 2, !"Debug Info Version", i32 3}
!11 = !{i32 1, !"wchar_size", i32 4}
!12 = !{i32 7, !"uwtable", i32 1}
!13 = !{i32 7, !"frame-pointer", i32 2}
!14 = !{!"clang version 13.0.1"}
!15 = distinct !DISubprogram(name: "verify", scope: !1, file: !1, line: 41, type: !16, scopeLine: 43, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !28)
!16 = !DISubroutineType(types: !17)
!17 = !{null, !18, !18, !18, !18, !19, !26}
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = !DIDerivedType(tag: DW_TAG_typedef, name: "dcomplex", file: !4, line: 8, baseType: !21)
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !4, line: 5, size: 128, elements: !22)
!22 = !{!23, !25}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "real", scope: !21, file: !4, line: 6, baseType: !24, size: 64)
!24 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "imag", scope: !21, file: !4, line: 7, baseType: !24, size: 64, offset: 64)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !27, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_typedef, name: "logical", file: !4, line: 4, baseType: !3)
!28 = !{}
!29 = !DILocalVariable(name: "n1", arg: 1, scope: !15, file: !1, line: 41, type: !18)
!30 = !DILocation(line: 41, column: 17, scope: !15)
!31 = !DILocalVariable(name: "n2", arg: 2, scope: !15, file: !1, line: 41, type: !18)
!32 = !DILocation(line: 41, column: 25, scope: !15)
!33 = !DILocalVariable(name: "n3", arg: 3, scope: !15, file: !1, line: 41, type: !18)
!34 = !DILocation(line: 41, column: 33, scope: !15)
!35 = !DILocalVariable(name: "nt", arg: 4, scope: !15, file: !1, line: 41, type: !18)
!36 = !DILocation(line: 41, column: 41, scope: !15)
!37 = !DILocalVariable(name: "cksum", arg: 5, scope: !15, file: !1, line: 41, type: !19)
!38 = !DILocation(line: 41, column: 54, scope: !15)
!39 = !DILocalVariable(name: "verified", arg: 6, scope: !15, file: !1, line: 42, type: !26)
!40 = !DILocation(line: 42, column: 22, scope: !15)
!41 = !DILocation(line: 41, column: 60, scope: !15)
!42 = !DILocation(line: 41, column: 62, scope: !15)
!43 = !DILocalVariable(name: "kt", scope: !15, file: !1, line: 45, type: !18)
!44 = !DILocation(line: 45, column: 7, scope: !15)
!45 = !DILocalVariable(name: "cexpd", scope: !15, file: !1, line: 46, type: !46)
!46 = !DICompositeType(tag: DW_TAG_array_type, baseType: !20, size: 3328, elements: !47)
!47 = !{!48}
!48 = !DISubrange(count: 26)
!49 = !DILocation(line: 46, column: 12, scope: !15)
!50 = !DILocalVariable(name: "epsilon", scope: !15, file: !1, line: 47, type: !24)
!51 = !DILocation(line: 47, column: 10, scope: !15)
!52 = !DILocalVariable(name: "err", scope: !15, file: !1, line: 47, type: !24)
!53 = !DILocation(line: 47, column: 19, scope: !15)
!54 = !DILocation(line: 52, column: 11, scope: !15)
!55 = !DILocation(line: 53, column: 4, scope: !15)
!56 = !DILocation(line: 53, column: 13, scope: !15)
!57 = !DILocation(line: 55, column: 8, scope: !58)
!58 = distinct !DILexicalBlock(scope: !15, file: !1, line: 55, column: 7)
!59 = !DILocation(line: 55, column: 11, scope: !58)
!60 = !DILocation(line: 55, column: 18, scope: !58)
!61 = !DILocation(line: 55, column: 22, scope: !58)
!62 = !DILocation(line: 55, column: 25, scope: !58)
!63 = !DILocation(line: 55, column: 32, scope: !58)
!64 = !DILocation(line: 55, column: 36, scope: !58)
!65 = !DILocation(line: 55, column: 39, scope: !58)
!66 = !DILocation(line: 55, column: 46, scope: !58)
!67 = !DILocation(line: 55, column: 50, scope: !58)
!68 = !DILocation(line: 55, column: 53, scope: !58)
!69 = !DILocation(line: 55, column: 7, scope: !15)
!70 = !DILocation(line: 57, column: 5, scope: !71)
!71 = distinct !DILexicalBlock(scope: !58, file: !1, line: 55, column: 60)
!72 = !DILocation(line: 57, column: 16, scope: !71)
!73 = !DILocation(line: 58, column: 5, scope: !71)
!74 = !DILocation(line: 58, column: 16, scope: !71)
!75 = !DILocation(line: 59, column: 5, scope: !71)
!76 = !DILocation(line: 59, column: 16, scope: !71)
!77 = !DILocation(line: 60, column: 5, scope: !71)
!78 = !DILocation(line: 60, column: 16, scope: !71)
!79 = !DILocation(line: 61, column: 5, scope: !71)
!80 = !DILocation(line: 61, column: 16, scope: !71)
!81 = !DILocation(line: 62, column: 5, scope: !71)
!82 = !DILocation(line: 62, column: 16, scope: !71)
!83 = !DILocation(line: 63, column: 3, scope: !71)
!84 = !DILocation(line: 63, column: 15, scope: !85)
!85 = distinct !DILexicalBlock(scope: !58, file: !1, line: 63, column: 14)
!86 = !DILocation(line: 63, column: 18, scope: !85)
!87 = !DILocation(line: 63, column: 26, scope: !85)
!88 = !DILocation(line: 63, column: 30, scope: !85)
!89 = !DILocation(line: 63, column: 33, scope: !85)
!90 = !DILocation(line: 63, column: 41, scope: !85)
!91 = !DILocation(line: 63, column: 45, scope: !85)
!92 = !DILocation(line: 63, column: 48, scope: !85)
!93 = !DILocation(line: 63, column: 55, scope: !85)
!94 = !DILocation(line: 63, column: 59, scope: !85)
!95 = !DILocation(line: 63, column: 62, scope: !85)
!96 = !DILocation(line: 63, column: 14, scope: !58)
!97 = !DILocation(line: 65, column: 5, scope: !98)
!98 = distinct !DILexicalBlock(scope: !85, file: !1, line: 63, column: 69)
!99 = !DILocation(line: 65, column: 16, scope: !98)
!100 = !DILocation(line: 66, column: 5, scope: !98)
!101 = !DILocation(line: 66, column: 16, scope: !98)
!102 = !DILocation(line: 67, column: 5, scope: !98)
!103 = !DILocation(line: 67, column: 16, scope: !98)
!104 = !DILocation(line: 68, column: 5, scope: !98)
!105 = !DILocation(line: 68, column: 16, scope: !98)
!106 = !DILocation(line: 69, column: 5, scope: !98)
!107 = !DILocation(line: 69, column: 16, scope: !98)
!108 = !DILocation(line: 70, column: 5, scope: !98)
!109 = !DILocation(line: 70, column: 16, scope: !98)
!110 = !DILocation(line: 71, column: 3, scope: !98)
!111 = !DILocation(line: 71, column: 15, scope: !112)
!112 = distinct !DILexicalBlock(scope: !85, file: !1, line: 71, column: 14)
!113 = !DILocation(line: 71, column: 18, scope: !112)
!114 = !DILocation(line: 71, column: 26, scope: !112)
!115 = !DILocation(line: 71, column: 30, scope: !112)
!116 = !DILocation(line: 71, column: 33, scope: !112)
!117 = !DILocation(line: 71, column: 41, scope: !112)
!118 = !DILocation(line: 71, column: 45, scope: !112)
!119 = !DILocation(line: 71, column: 48, scope: !112)
!120 = !DILocation(line: 71, column: 56, scope: !112)
!121 = !DILocation(line: 71, column: 60, scope: !112)
!122 = !DILocation(line: 71, column: 63, scope: !112)
!123 = !DILocation(line: 71, column: 14, scope: !85)
!124 = !DILocation(line: 73, column: 5, scope: !125)
!125 = distinct !DILexicalBlock(scope: !112, file: !1, line: 71, column: 70)
!126 = !DILocation(line: 73, column: 16, scope: !125)
!127 = !DILocation(line: 74, column: 5, scope: !125)
!128 = !DILocation(line: 74, column: 16, scope: !125)
!129 = !DILocation(line: 75, column: 5, scope: !125)
!130 = !DILocation(line: 75, column: 16, scope: !125)
!131 = !DILocation(line: 76, column: 5, scope: !125)
!132 = !DILocation(line: 76, column: 16, scope: !125)
!133 = !DILocation(line: 77, column: 5, scope: !125)
!134 = !DILocation(line: 77, column: 16, scope: !125)
!135 = !DILocation(line: 78, column: 5, scope: !125)
!136 = !DILocation(line: 78, column: 16, scope: !125)
!137 = !DILocation(line: 79, column: 3, scope: !125)
!138 = !DILocation(line: 79, column: 15, scope: !139)
!139 = distinct !DILexicalBlock(scope: !112, file: !1, line: 79, column: 14)
!140 = !DILocation(line: 79, column: 18, scope: !139)
!141 = !DILocation(line: 79, column: 26, scope: !139)
!142 = !DILocation(line: 79, column: 30, scope: !139)
!143 = !DILocation(line: 79, column: 33, scope: !139)
!144 = !DILocation(line: 79, column: 41, scope: !139)
!145 = !DILocation(line: 79, column: 45, scope: !139)
!146 = !DILocation(line: 79, column: 48, scope: !139)
!147 = !DILocation(line: 79, column: 56, scope: !139)
!148 = !DILocation(line: 79, column: 60, scope: !139)
!149 = !DILocation(line: 79, column: 63, scope: !139)
!150 = !DILocation(line: 79, column: 14, scope: !112)
!151 = !DILocation(line: 81, column: 5, scope: !152)
!152 = distinct !DILexicalBlock(scope: !139, file: !1, line: 79, column: 71)
!153 = !DILocation(line: 81, column: 17, scope: !152)
!154 = !DILocation(line: 82, column: 5, scope: !152)
!155 = !DILocation(line: 82, column: 17, scope: !152)
!156 = !DILocation(line: 83, column: 5, scope: !152)
!157 = !DILocation(line: 83, column: 17, scope: !152)
!158 = !DILocation(line: 84, column: 5, scope: !152)
!159 = !DILocation(line: 84, column: 17, scope: !152)
!160 = !DILocation(line: 85, column: 5, scope: !152)
!161 = !DILocation(line: 85, column: 17, scope: !152)
!162 = !DILocation(line: 86, column: 5, scope: !152)
!163 = !DILocation(line: 86, column: 17, scope: !152)
!164 = !DILocation(line: 87, column: 5, scope: !152)
!165 = !DILocation(line: 87, column: 17, scope: !152)
!166 = !DILocation(line: 88, column: 5, scope: !152)
!167 = !DILocation(line: 88, column: 17, scope: !152)
!168 = !DILocation(line: 89, column: 5, scope: !152)
!169 = !DILocation(line: 89, column: 17, scope: !152)
!170 = !DILocation(line: 90, column: 5, scope: !152)
!171 = !DILocation(line: 90, column: 17, scope: !152)
!172 = !DILocation(line: 91, column: 5, scope: !152)
!173 = !DILocation(line: 91, column: 17, scope: !152)
!174 = !DILocation(line: 92, column: 5, scope: !152)
!175 = !DILocation(line: 92, column: 17, scope: !152)
!176 = !DILocation(line: 93, column: 5, scope: !152)
!177 = !DILocation(line: 93, column: 17, scope: !152)
!178 = !DILocation(line: 94, column: 5, scope: !152)
!179 = !DILocation(line: 94, column: 17, scope: !152)
!180 = !DILocation(line: 95, column: 5, scope: !152)
!181 = !DILocation(line: 95, column: 17, scope: !152)
!182 = !DILocation(line: 96, column: 5, scope: !152)
!183 = !DILocation(line: 96, column: 17, scope: !152)
!184 = !DILocation(line: 97, column: 5, scope: !152)
!185 = !DILocation(line: 97, column: 17, scope: !152)
!186 = !DILocation(line: 98, column: 5, scope: !152)
!187 = !DILocation(line: 98, column: 17, scope: !152)
!188 = !DILocation(line: 99, column: 5, scope: !152)
!189 = !DILocation(line: 99, column: 17, scope: !152)
!190 = !DILocation(line: 100, column: 5, scope: !152)
!191 = !DILocation(line: 100, column: 17, scope: !152)
!192 = !DILocation(line: 102, column: 3, scope: !152)
!193 = !DILocation(line: 102, column: 15, scope: !194)
!194 = distinct !DILexicalBlock(scope: !139, file: !1, line: 102, column: 14)
!195 = !DILocation(line: 102, column: 18, scope: !194)
!196 = !DILocation(line: 102, column: 26, scope: !194)
!197 = !DILocation(line: 102, column: 30, scope: !194)
!198 = !DILocation(line: 102, column: 33, scope: !194)
!199 = !DILocation(line: 102, column: 41, scope: !194)
!200 = !DILocation(line: 102, column: 45, scope: !194)
!201 = !DILocation(line: 102, column: 48, scope: !194)
!202 = !DILocation(line: 102, column: 56, scope: !194)
!203 = !DILocation(line: 102, column: 60, scope: !194)
!204 = !DILocation(line: 102, column: 63, scope: !194)
!205 = !DILocation(line: 102, column: 14, scope: !139)
!206 = !DILocation(line: 104, column: 5, scope: !207)
!207 = distinct !DILexicalBlock(scope: !194, file: !1, line: 102, column: 71)
!208 = !DILocation(line: 104, column: 17, scope: !207)
!209 = !DILocation(line: 105, column: 5, scope: !207)
!210 = !DILocation(line: 105, column: 17, scope: !207)
!211 = !DILocation(line: 106, column: 5, scope: !207)
!212 = !DILocation(line: 106, column: 17, scope: !207)
!213 = !DILocation(line: 107, column: 5, scope: !207)
!214 = !DILocation(line: 107, column: 17, scope: !207)
!215 = !DILocation(line: 108, column: 5, scope: !207)
!216 = !DILocation(line: 108, column: 17, scope: !207)
!217 = !DILocation(line: 109, column: 5, scope: !207)
!218 = !DILocation(line: 109, column: 17, scope: !207)
!219 = !DILocation(line: 110, column: 5, scope: !207)
!220 = !DILocation(line: 110, column: 17, scope: !207)
!221 = !DILocation(line: 111, column: 5, scope: !207)
!222 = !DILocation(line: 111, column: 17, scope: !207)
!223 = !DILocation(line: 112, column: 5, scope: !207)
!224 = !DILocation(line: 112, column: 17, scope: !207)
!225 = !DILocation(line: 113, column: 5, scope: !207)
!226 = !DILocation(line: 113, column: 17, scope: !207)
!227 = !DILocation(line: 114, column: 5, scope: !207)
!228 = !DILocation(line: 114, column: 17, scope: !207)
!229 = !DILocation(line: 115, column: 5, scope: !207)
!230 = !DILocation(line: 115, column: 17, scope: !207)
!231 = !DILocation(line: 116, column: 5, scope: !207)
!232 = !DILocation(line: 116, column: 17, scope: !207)
!233 = !DILocation(line: 117, column: 5, scope: !207)
!234 = !DILocation(line: 117, column: 17, scope: !207)
!235 = !DILocation(line: 118, column: 5, scope: !207)
!236 = !DILocation(line: 118, column: 17, scope: !207)
!237 = !DILocation(line: 119, column: 5, scope: !207)
!238 = !DILocation(line: 119, column: 17, scope: !207)
!239 = !DILocation(line: 120, column: 5, scope: !207)
!240 = !DILocation(line: 120, column: 17, scope: !207)
!241 = !DILocation(line: 121, column: 5, scope: !207)
!242 = !DILocation(line: 121, column: 17, scope: !207)
!243 = !DILocation(line: 122, column: 5, scope: !207)
!244 = !DILocation(line: 122, column: 17, scope: !207)
!245 = !DILocation(line: 123, column: 5, scope: !207)
!246 = !DILocation(line: 123, column: 17, scope: !207)
!247 = !DILocation(line: 124, column: 3, scope: !207)
!248 = !DILocation(line: 124, column: 15, scope: !249)
!249 = distinct !DILexicalBlock(scope: !194, file: !1, line: 124, column: 14)
!250 = !DILocation(line: 124, column: 18, scope: !249)
!251 = !DILocation(line: 124, column: 27, scope: !249)
!252 = !DILocation(line: 124, column: 31, scope: !249)
!253 = !DILocation(line: 124, column: 34, scope: !249)
!254 = !DILocation(line: 124, column: 43, scope: !249)
!255 = !DILocation(line: 124, column: 47, scope: !249)
!256 = !DILocation(line: 124, column: 50, scope: !249)
!257 = !DILocation(line: 124, column: 59, scope: !249)
!258 = !DILocation(line: 124, column: 63, scope: !249)
!259 = !DILocation(line: 124, column: 66, scope: !249)
!260 = !DILocation(line: 124, column: 14, scope: !194)
!261 = !DILocation(line: 126, column: 5, scope: !262)
!262 = distinct !DILexicalBlock(scope: !249, file: !1, line: 124, column: 74)
!263 = !DILocation(line: 126, column: 17, scope: !262)
!264 = !DILocation(line: 127, column: 5, scope: !262)
!265 = !DILocation(line: 127, column: 17, scope: !262)
!266 = !DILocation(line: 128, column: 5, scope: !262)
!267 = !DILocation(line: 128, column: 17, scope: !262)
!268 = !DILocation(line: 129, column: 5, scope: !262)
!269 = !DILocation(line: 129, column: 17, scope: !262)
!270 = !DILocation(line: 130, column: 5, scope: !262)
!271 = !DILocation(line: 130, column: 17, scope: !262)
!272 = !DILocation(line: 131, column: 5, scope: !262)
!273 = !DILocation(line: 131, column: 17, scope: !262)
!274 = !DILocation(line: 132, column: 5, scope: !262)
!275 = !DILocation(line: 132, column: 17, scope: !262)
!276 = !DILocation(line: 133, column: 5, scope: !262)
!277 = !DILocation(line: 133, column: 17, scope: !262)
!278 = !DILocation(line: 134, column: 5, scope: !262)
!279 = !DILocation(line: 134, column: 17, scope: !262)
!280 = !DILocation(line: 135, column: 5, scope: !262)
!281 = !DILocation(line: 135, column: 17, scope: !262)
!282 = !DILocation(line: 136, column: 5, scope: !262)
!283 = !DILocation(line: 136, column: 17, scope: !262)
!284 = !DILocation(line: 137, column: 5, scope: !262)
!285 = !DILocation(line: 137, column: 17, scope: !262)
!286 = !DILocation(line: 138, column: 5, scope: !262)
!287 = !DILocation(line: 138, column: 17, scope: !262)
!288 = !DILocation(line: 139, column: 5, scope: !262)
!289 = !DILocation(line: 139, column: 17, scope: !262)
!290 = !DILocation(line: 140, column: 5, scope: !262)
!291 = !DILocation(line: 140, column: 17, scope: !262)
!292 = !DILocation(line: 141, column: 5, scope: !262)
!293 = !DILocation(line: 141, column: 17, scope: !262)
!294 = !DILocation(line: 142, column: 5, scope: !262)
!295 = !DILocation(line: 142, column: 17, scope: !262)
!296 = !DILocation(line: 143, column: 5, scope: !262)
!297 = !DILocation(line: 143, column: 17, scope: !262)
!298 = !DILocation(line: 144, column: 5, scope: !262)
!299 = !DILocation(line: 144, column: 17, scope: !262)
!300 = !DILocation(line: 145, column: 5, scope: !262)
!301 = !DILocation(line: 145, column: 17, scope: !262)
!302 = !DILocation(line: 146, column: 5, scope: !262)
!303 = !DILocation(line: 146, column: 17, scope: !262)
!304 = !DILocation(line: 147, column: 5, scope: !262)
!305 = !DILocation(line: 147, column: 17, scope: !262)
!306 = !DILocation(line: 148, column: 5, scope: !262)
!307 = !DILocation(line: 148, column: 17, scope: !262)
!308 = !DILocation(line: 149, column: 5, scope: !262)
!309 = !DILocation(line: 149, column: 17, scope: !262)
!310 = !DILocation(line: 150, column: 5, scope: !262)
!311 = !DILocation(line: 150, column: 17, scope: !262)
!312 = !DILocation(line: 151, column: 3, scope: !262)
!313 = !DILocation(line: 151, column: 15, scope: !314)
!314 = distinct !DILexicalBlock(scope: !249, file: !1, line: 151, column: 14)
!315 = !DILocation(line: 151, column: 18, scope: !314)
!316 = !DILocation(line: 151, column: 27, scope: !314)
!317 = !DILocation(line: 151, column: 31, scope: !314)
!318 = !DILocation(line: 151, column: 34, scope: !314)
!319 = !DILocation(line: 151, column: 43, scope: !314)
!320 = !DILocation(line: 151, column: 47, scope: !314)
!321 = !DILocation(line: 151, column: 50, scope: !314)
!322 = !DILocation(line: 151, column: 59, scope: !314)
!323 = !DILocation(line: 151, column: 63, scope: !314)
!324 = !DILocation(line: 151, column: 66, scope: !314)
!325 = !DILocation(line: 151, column: 14, scope: !249)
!326 = !DILocation(line: 153, column: 5, scope: !327)
!327 = distinct !DILexicalBlock(scope: !314, file: !1, line: 151, column: 74)
!328 = !DILocation(line: 153, column: 17, scope: !327)
!329 = !DILocation(line: 154, column: 5, scope: !327)
!330 = !DILocation(line: 154, column: 17, scope: !327)
!331 = !DILocation(line: 155, column: 5, scope: !327)
!332 = !DILocation(line: 155, column: 17, scope: !327)
!333 = !DILocation(line: 156, column: 5, scope: !327)
!334 = !DILocation(line: 156, column: 17, scope: !327)
!335 = !DILocation(line: 157, column: 5, scope: !327)
!336 = !DILocation(line: 157, column: 17, scope: !327)
!337 = !DILocation(line: 158, column: 5, scope: !327)
!338 = !DILocation(line: 158, column: 17, scope: !327)
!339 = !DILocation(line: 159, column: 5, scope: !327)
!340 = !DILocation(line: 159, column: 17, scope: !327)
!341 = !DILocation(line: 160, column: 5, scope: !327)
!342 = !DILocation(line: 160, column: 17, scope: !327)
!343 = !DILocation(line: 161, column: 5, scope: !327)
!344 = !DILocation(line: 161, column: 17, scope: !327)
!345 = !DILocation(line: 162, column: 5, scope: !327)
!346 = !DILocation(line: 162, column: 17, scope: !327)
!347 = !DILocation(line: 163, column: 5, scope: !327)
!348 = !DILocation(line: 163, column: 17, scope: !327)
!349 = !DILocation(line: 164, column: 5, scope: !327)
!350 = !DILocation(line: 164, column: 17, scope: !327)
!351 = !DILocation(line: 165, column: 5, scope: !327)
!352 = !DILocation(line: 165, column: 17, scope: !327)
!353 = !DILocation(line: 166, column: 5, scope: !327)
!354 = !DILocation(line: 166, column: 17, scope: !327)
!355 = !DILocation(line: 167, column: 5, scope: !327)
!356 = !DILocation(line: 167, column: 17, scope: !327)
!357 = !DILocation(line: 168, column: 5, scope: !327)
!358 = !DILocation(line: 168, column: 17, scope: !327)
!359 = !DILocation(line: 169, column: 5, scope: !327)
!360 = !DILocation(line: 169, column: 17, scope: !327)
!361 = !DILocation(line: 170, column: 5, scope: !327)
!362 = !DILocation(line: 170, column: 17, scope: !327)
!363 = !DILocation(line: 171, column: 5, scope: !327)
!364 = !DILocation(line: 171, column: 17, scope: !327)
!365 = !DILocation(line: 172, column: 5, scope: !327)
!366 = !DILocation(line: 172, column: 17, scope: !327)
!367 = !DILocation(line: 173, column: 5, scope: !327)
!368 = !DILocation(line: 173, column: 17, scope: !327)
!369 = !DILocation(line: 174, column: 5, scope: !327)
!370 = !DILocation(line: 174, column: 17, scope: !327)
!371 = !DILocation(line: 175, column: 5, scope: !327)
!372 = !DILocation(line: 175, column: 17, scope: !327)
!373 = !DILocation(line: 176, column: 5, scope: !327)
!374 = !DILocation(line: 176, column: 17, scope: !327)
!375 = !DILocation(line: 177, column: 5, scope: !327)
!376 = !DILocation(line: 177, column: 17, scope: !327)
!377 = !DILocation(line: 178, column: 3, scope: !327)
!378 = !DILocation(line: 179, column: 5, scope: !379)
!379 = distinct !DILexicalBlock(scope: !314, file: !1, line: 178, column: 10)
!380 = !DILocation(line: 180, column: 6, scope: !379)
!381 = !DILocation(line: 180, column: 15, scope: !379)
!382 = !DILocation(line: 185, column: 8, scope: !383)
!383 = distinct !DILexicalBlock(scope: !15, file: !1, line: 185, column: 7)
!384 = !DILocation(line: 185, column: 7, scope: !383)
!385 = !DILocation(line: 185, column: 7, scope: !15)
!386 = !DILocation(line: 186, column: 13, scope: !387)
!387 = distinct !DILexicalBlock(scope: !388, file: !1, line: 186, column: 5)
!388 = distinct !DILexicalBlock(scope: !383, file: !1, line: 185, column: 18)
!389 = !DILocation(line: 186, column: 10, scope: !387)
!390 = !DILocation(line: 186, column: 18, scope: !391)
!391 = distinct !DILexicalBlock(scope: !387, file: !1, line: 186, column: 5)
!392 = !DILocation(line: 186, column: 24, scope: !391)
!393 = !DILocation(line: 186, column: 21, scope: !391)
!394 = !DILocation(line: 186, column: 5, scope: !387)
!395 = !DILocation(line: 187, column: 31, scope: !396)
!396 = distinct !DILexicalBlock(scope: !391, file: !1, line: 186, column: 34)
!397 = !DILocation(line: 187, column: 9, scope: !396)
!398 = !DILocation(line: 188, column: 13, scope: !396)
!399 = !DILocation(line: 188, column: 11, scope: !396)
!400 = !DILocation(line: 190, column: 13, scope: !401)
!401 = distinct !DILexicalBlock(scope: !396, file: !1, line: 190, column: 11)
!402 = !DILocation(line: 190, column: 20, scope: !401)
!403 = !DILocation(line: 190, column: 17, scope: !401)
!404 = !DILocation(line: 190, column: 11, scope: !396)
!405 = !DILocation(line: 191, column: 10, scope: !406)
!406 = distinct !DILexicalBlock(scope: !401, file: !1, line: 190, column: 30)
!407 = !DILocation(line: 191, column: 19, scope: !406)
!408 = !DILocation(line: 192, column: 9, scope: !406)
!409 = !DILocation(line: 194, column: 5, scope: !396)
!410 = !DILocation(line: 186, column: 30, scope: !391)
!411 = !DILocation(line: 186, column: 5, scope: !391)
!412 = distinct !{!412, !394, !413, !414}
!413 = !DILocation(line: 194, column: 5, scope: !387)
!414 = !{!"llvm.loop.mustprogress"}
!415 = !DILocation(line: 196, column: 10, scope: !416)
!416 = distinct !DILexicalBlock(scope: !388, file: !1, line: 196, column: 9)
!417 = !DILocation(line: 196, column: 9, scope: !416)
!418 = !DILocation(line: 196, column: 9, scope: !388)
!419 = !DILocation(line: 197, column: 7, scope: !420)
!420 = distinct !DILexicalBlock(scope: !416, file: !1, line: 196, column: 20)
!421 = !DILocation(line: 198, column: 5, scope: !420)
!422 = !DILocation(line: 199, column: 7, scope: !423)
!423 = distinct !DILexicalBlock(scope: !416, file: !1, line: 198, column: 12)
!424 = !DILocation(line: 201, column: 3, scope: !388)
!425 = !DILocation(line: 202, column: 1, scope: !15)
!426 = distinct !DISubprogram(name: "dcmplx_div", scope: !427, file: !427, line: 68, type: !428, scopeLine: 68, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !28)
!427 = !DIFile(filename: "./global.h", directory: "/workspace/LLVM-Checker/test/benchmarks/NPB/FT")
!428 = !DISubroutineType(types: !429)
!429 = !{!20, !20, !20}
!430 = !DILocalVariable(name: "z1", arg: 1, scope: !426, file: !427, line: 68, type: !20)
!431 = !DILocation(line: 68, column: 44, scope: !426)
!432 = !DILocalVariable(name: "z2", arg: 2, scope: !426, file: !427, line: 68, type: !20)
!433 = !DILocation(line: 68, column: 57, scope: !426)
!434 = !DILocalVariable(name: "a", scope: !426, file: !427, line: 69, type: !24)
!435 = !DILocation(line: 69, column: 10, scope: !426)
!436 = !DILocation(line: 69, column: 17, scope: !426)
!437 = !DILocalVariable(name: "b", scope: !426, file: !427, line: 70, type: !24)
!438 = !DILocation(line: 70, column: 10, scope: !426)
!439 = !DILocation(line: 70, column: 17, scope: !426)
!440 = !DILocalVariable(name: "c", scope: !426, file: !427, line: 71, type: !24)
!441 = !DILocation(line: 71, column: 10, scope: !426)
!442 = !DILocation(line: 71, column: 17, scope: !426)
!443 = !DILocalVariable(name: "d", scope: !426, file: !427, line: 72, type: !24)
!444 = !DILocation(line: 72, column: 10, scope: !426)
!445 = !DILocation(line: 72, column: 17, scope: !426)
!446 = !DILocalVariable(name: "divisor", scope: !426, file: !427, line: 74, type: !24)
!447 = !DILocation(line: 74, column: 10, scope: !426)
!448 = !DILocation(line: 74, column: 20, scope: !426)
!449 = !DILocation(line: 74, column: 22, scope: !426)
!450 = !DILocation(line: 74, column: 21, scope: !426)
!451 = !DILocation(line: 74, column: 26, scope: !426)
!452 = !DILocation(line: 74, column: 28, scope: !426)
!453 = !DILocation(line: 74, column: 27, scope: !426)
!454 = !DILocation(line: 74, column: 24, scope: !426)
!455 = !DILocalVariable(name: "real", scope: !426, file: !427, line: 75, type: !24)
!456 = !DILocation(line: 75, column: 10, scope: !426)
!457 = !DILocation(line: 75, column: 18, scope: !426)
!458 = !DILocation(line: 75, column: 20, scope: !426)
!459 = !DILocation(line: 75, column: 19, scope: !426)
!460 = !DILocation(line: 75, column: 24, scope: !426)
!461 = !DILocation(line: 75, column: 26, scope: !426)
!462 = !DILocation(line: 75, column: 25, scope: !426)
!463 = !DILocation(line: 75, column: 22, scope: !426)
!464 = !DILocation(line: 75, column: 31, scope: !426)
!465 = !DILocation(line: 75, column: 29, scope: !426)
!466 = !DILocalVariable(name: "imag", scope: !426, file: !427, line: 76, type: !24)
!467 = !DILocation(line: 76, column: 10, scope: !426)
!468 = !DILocation(line: 76, column: 18, scope: !426)
!469 = !DILocation(line: 76, column: 20, scope: !426)
!470 = !DILocation(line: 76, column: 19, scope: !426)
!471 = !DILocation(line: 76, column: 24, scope: !426)
!472 = !DILocation(line: 76, column: 26, scope: !426)
!473 = !DILocation(line: 76, column: 25, scope: !426)
!474 = !DILocation(line: 76, column: 22, scope: !426)
!475 = !DILocation(line: 76, column: 31, scope: !426)
!476 = !DILocation(line: 76, column: 29, scope: !426)
!477 = !DILocalVariable(name: "result", scope: !426, file: !427, line: 77, type: !20)
!478 = !DILocation(line: 77, column: 12, scope: !426)
!479 = !DILocation(line: 77, column: 31, scope: !426)
!480 = !DILocation(line: 77, column: 32, scope: !426)
!481 = !DILocation(line: 77, column: 38, scope: !426)
!482 = !DILocation(line: 78, column: 3, scope: !426)
