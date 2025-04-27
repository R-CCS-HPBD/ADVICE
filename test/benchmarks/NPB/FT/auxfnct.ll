; ModuleID = 'auxfnct.c'
source_filename = "auxfnct.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dcomplex = type { double, double }

@.str = private unnamed_addr constant [38 x i8] c" T =%5d     Checksum =%22.12E%22.12E\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @CompExp(i32 %n, %struct.dcomplex* %exponent) #0 !dbg !12 {
entry:
  %n.addr = alloca i32, align 4
  %exponent.addr = alloca %struct.dcomplex*, align 8
  %m = alloca i32, align 4
  %nu = alloca i32, align 4
  %ku = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %ln = alloca i32, align 4
  %t = alloca double, align 8
  %ti = alloca double, align 8
  %pi = alloca double, align 8
  %.compoundliteral = alloca %struct.dcomplex, align 8
  %.compoundliteral10 = alloca %struct.dcomplex, align 8
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !23, metadata !DIExpression()), !dbg !24
  store %struct.dcomplex* %exponent, %struct.dcomplex** %exponent.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.dcomplex** %exponent.addr, metadata !25, metadata !DIExpression()), !dbg !26
  %0 = load i32, i32* %n.addr, align 4, !dbg !27
  %1 = zext i32 %0 to i64
  call void @llvm.dbg.declare(metadata i32* %m, metadata !28, metadata !DIExpression()), !dbg !29
  call void @llvm.dbg.declare(metadata i32* %nu, metadata !30, metadata !DIExpression()), !dbg !31
  call void @llvm.dbg.declare(metadata i32* %ku, metadata !32, metadata !DIExpression()), !dbg !33
  call void @llvm.dbg.declare(metadata i32* %i, metadata !34, metadata !DIExpression()), !dbg !35
  call void @llvm.dbg.declare(metadata i32* %j, metadata !36, metadata !DIExpression()), !dbg !37
  call void @llvm.dbg.declare(metadata i32* %ln, metadata !38, metadata !DIExpression()), !dbg !39
  call void @llvm.dbg.declare(metadata double* %t, metadata !40, metadata !DIExpression()), !dbg !41
  call void @llvm.dbg.declare(metadata double* %ti, metadata !42, metadata !DIExpression()), !dbg !43
  call void @llvm.dbg.declare(metadata double* %pi, metadata !44, metadata !DIExpression()), !dbg !46
  store double 0x400921FB54442D18, double* %pi, align 8, !dbg !46
  %2 = load i32, i32* %n.addr, align 4, !dbg !47
  store i32 %2, i32* %nu, align 4, !dbg !48
  %3 = load i32, i32* %n.addr, align 4, !dbg !49
  %call = call i32 @ilog2(i32 %3), !dbg !50
  store i32 %call, i32* %m, align 4, !dbg !51
  %4 = load %struct.dcomplex*, %struct.dcomplex** %exponent.addr, align 8, !dbg !52
  %arrayidx = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %4, i64 0, !dbg !52
  %real = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral, i32 0, i32 0, !dbg !53
  %5 = load i32, i32* %m, align 4, !dbg !53
  %conv = sitofp i32 %5 to double, !dbg !53
  store double %conv, double* %real, align 8, !dbg !53
  %imag = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral, i32 0, i32 1, !dbg !53
  store double 0.000000e+00, double* %imag, align 8, !dbg !53
  %6 = bitcast %struct.dcomplex* %arrayidx to i8*, !dbg !53
  %7 = bitcast %struct.dcomplex* %.compoundliteral to i8*, !dbg !53
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %6, i8* align 8 %7, i64 16, i1 false), !dbg !53
  store i32 2, i32* %ku, align 4, !dbg !54
  store i32 1, i32* %ln, align 4, !dbg !55
  store i32 1, i32* %j, align 4, !dbg !56
  br label %for.cond, !dbg !58

for.cond:                                         ; preds = %for.inc17, %entry
  %8 = load i32, i32* %j, align 4, !dbg !59
  %9 = load i32, i32* %m, align 4, !dbg !61
  %cmp = icmp sle i32 %8, %9, !dbg !62
  br i1 %cmp, label %for.body, label %for.end19, !dbg !63

for.body:                                         ; preds = %for.cond
  %10 = load i32, i32* %ln, align 4, !dbg !64
  %conv2 = sitofp i32 %10 to double, !dbg !64
  %div = fdiv double 0x400921FB54442D18, %conv2, !dbg !66
  store double %div, double* %t, align 8, !dbg !67
  store i32 0, i32* %i, align 4, !dbg !68
  br label %for.cond3, !dbg !70

for.cond3:                                        ; preds = %for.inc, %for.body
  %11 = load i32, i32* %i, align 4, !dbg !71
  %12 = load i32, i32* %ln, align 4, !dbg !73
  %sub = sub nsw i32 %12, 1, !dbg !74
  %cmp4 = icmp sle i32 %11, %sub, !dbg !75
  br i1 %cmp4, label %for.body6, label %for.end, !dbg !76

for.body6:                                        ; preds = %for.cond3
  %13 = load i32, i32* %i, align 4, !dbg !77
  %conv7 = sitofp i32 %13 to double, !dbg !77
  %14 = load double, double* %t, align 8, !dbg !79
  %mul = fmul double %conv7, %14, !dbg !80
  store double %mul, double* %ti, align 8, !dbg !81
  %15 = load %struct.dcomplex*, %struct.dcomplex** %exponent.addr, align 8, !dbg !82
  %16 = load i32, i32* %i, align 4, !dbg !83
  %17 = load i32, i32* %ku, align 4, !dbg !84
  %add = add nsw i32 %16, %17, !dbg !85
  %sub8 = sub nsw i32 %add, 1, !dbg !86
  %idxprom = sext i32 %sub8 to i64, !dbg !82
  %arrayidx9 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %15, i64 %idxprom, !dbg !82
  %real11 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral10, i32 0, i32 0, !dbg !87
  %18 = load double, double* %ti, align 8, !dbg !87
  %call12 = call double @cos(double %18) #6, !dbg !87
  store double %call12, double* %real11, align 8, !dbg !87
  %imag13 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral10, i32 0, i32 1, !dbg !87
  %19 = load double, double* %ti, align 8, !dbg !87
  %call14 = call double @sin(double %19) #6, !dbg !87
  store double %call14, double* %imag13, align 8, !dbg !87
  %20 = bitcast %struct.dcomplex* %arrayidx9 to i8*, !dbg !87
  %21 = bitcast %struct.dcomplex* %.compoundliteral10 to i8*, !dbg !87
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %20, i8* align 8 %21, i64 16, i1 false), !dbg !87
  br label %for.inc, !dbg !88

for.inc:                                          ; preds = %for.body6
  %22 = load i32, i32* %i, align 4, !dbg !89
  %inc = add nsw i32 %22, 1, !dbg !89
  store i32 %inc, i32* %i, align 4, !dbg !89
  br label %for.cond3, !dbg !90, !llvm.loop !91

for.end:                                          ; preds = %for.cond3
  %23 = load i32, i32* %ku, align 4, !dbg !94
  %24 = load i32, i32* %ln, align 4, !dbg !95
  %add15 = add nsw i32 %23, %24, !dbg !96
  store i32 %add15, i32* %ku, align 4, !dbg !97
  %25 = load i32, i32* %ln, align 4, !dbg !98
  %mul16 = mul nsw i32 2, %25, !dbg !99
  store i32 %mul16, i32* %ln, align 4, !dbg !100
  br label %for.inc17, !dbg !101

for.inc17:                                        ; preds = %for.end
  %26 = load i32, i32* %j, align 4, !dbg !102
  %inc18 = add nsw i32 %26, 1, !dbg !102
  store i32 %inc18, i32* %j, align 4, !dbg !102
  br label %for.cond, !dbg !103, !llvm.loop !104

for.end19:                                        ; preds = %for.cond
  ret void, !dbg !106
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @ilog2(i32 %n) #0 !dbg !107 {
entry:
  %retval = alloca i32, align 4
  %n.addr = alloca i32, align 4
  %nn = alloca i32, align 4
  %lg = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !110, metadata !DIExpression()), !dbg !111
  call void @llvm.dbg.declare(metadata i32* %nn, metadata !112, metadata !DIExpression()), !dbg !113
  call void @llvm.dbg.declare(metadata i32* %lg, metadata !114, metadata !DIExpression()), !dbg !115
  %0 = load i32, i32* %n.addr, align 4, !dbg !116
  %cmp = icmp eq i32 %0, 1, !dbg !118
  br i1 %cmp, label %if.then, label %if.end, !dbg !119

if.then:                                          ; preds = %entry
  store i32 0, i32* %retval, align 4, !dbg !120
  br label %return, !dbg !120

if.end:                                           ; preds = %entry
  store i32 1, i32* %lg, align 4, !dbg !121
  store i32 2, i32* %nn, align 4, !dbg !122
  br label %while.cond, !dbg !123

while.cond:                                       ; preds = %while.body, %if.end
  %1 = load i32, i32* %nn, align 4, !dbg !124
  %2 = load i32, i32* %n.addr, align 4, !dbg !125
  %cmp1 = icmp slt i32 %1, %2, !dbg !126
  br i1 %cmp1, label %while.body, label %while.end, !dbg !123

while.body:                                       ; preds = %while.cond
  %3 = load i32, i32* %nn, align 4, !dbg !127
  %mul = mul nsw i32 %3, 2, !dbg !129
  store i32 %mul, i32* %nn, align 4, !dbg !130
  %4 = load i32, i32* %lg, align 4, !dbg !131
  %add = add nsw i32 %4, 1, !dbg !132
  store i32 %add, i32* %lg, align 4, !dbg !133
  br label %while.cond, !dbg !123, !llvm.loop !134

while.end:                                        ; preds = %while.cond
  %5 = load i32, i32* %lg, align 4, !dbg !136
  store i32 %5, i32* %retval, align 4, !dbg !137
  br label %return, !dbg !137

return:                                           ; preds = %while.end, %if.then
  %6 = load i32, i32* %retval, align 4, !dbg !138
  ret i32 %6, !dbg !138
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: nounwind
declare dso_local double @cos(double) #3

; Function Attrs: nounwind
declare dso_local double @sin(double) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @CalculateChecksum(%struct.dcomplex* %csum, i32 %iterN, i32 %d1, i32 %d2, i32 %d3, %struct.dcomplex* %u) #0 !dbg !139 {
entry:
  %csum.addr = alloca %struct.dcomplex*, align 8
  %iterN.addr = alloca i32, align 4
  %d1.addr = alloca i32, align 4
  %d2.addr = alloca i32, align 4
  %d3.addr = alloca i32, align 4
  %u.addr = alloca %struct.dcomplex*, align 8
  %i = alloca i32, align 4
  %i1 = alloca i32, align 4
  %ii = alloca i32, align 4
  %ji = alloca i32, align 4
  %ki = alloca i32, align 4
  %csum_temp = alloca %struct.dcomplex, align 8
  %.compoundliteral = alloca %struct.dcomplex, align 8
  %.compoundliteral20 = alloca %struct.dcomplex, align 8
  store %struct.dcomplex* %csum, %struct.dcomplex** %csum.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.dcomplex** %csum.addr, metadata !146, metadata !DIExpression()), !dbg !147
  store i32 %iterN, i32* %iterN.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %iterN.addr, metadata !148, metadata !DIExpression()), !dbg !149
  store i32 %d1, i32* %d1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %d1.addr, metadata !150, metadata !DIExpression()), !dbg !151
  store i32 %d2, i32* %d2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %d2.addr, metadata !152, metadata !DIExpression()), !dbg !153
  store i32 %d3, i32* %d3.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %d3.addr, metadata !154, metadata !DIExpression()), !dbg !155
  store %struct.dcomplex* %u, %struct.dcomplex** %u.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.dcomplex** %u.addr, metadata !156, metadata !DIExpression()), !dbg !157
  %0 = load i32, i32* %d3.addr, align 4, !dbg !158
  %1 = zext i32 %0 to i64
  %2 = load i32, i32* %d2.addr, align 4, !dbg !159
  %3 = zext i32 %2 to i64
  %4 = load i32, i32* %d1.addr, align 4, !dbg !160
  %add = add nsw i32 %4, 1, !dbg !161
  %5 = zext i32 %add to i64
  call void @llvm.dbg.declare(metadata i32* %i, metadata !162, metadata !DIExpression()), !dbg !163
  call void @llvm.dbg.declare(metadata i32* %i1, metadata !164, metadata !DIExpression()), !dbg !165
  call void @llvm.dbg.declare(metadata i32* %ii, metadata !166, metadata !DIExpression()), !dbg !167
  call void @llvm.dbg.declare(metadata i32* %ji, metadata !168, metadata !DIExpression()), !dbg !169
  call void @llvm.dbg.declare(metadata i32* %ki, metadata !170, metadata !DIExpression()), !dbg !171
  call void @llvm.dbg.declare(metadata %struct.dcomplex* %csum_temp, metadata !172, metadata !DIExpression()), !dbg !173
  %6 = bitcast %struct.dcomplex* %csum_temp to i8*, !dbg !173
  call void @llvm.memset.p0i8.i64(i8* align 8 %6, i8 0, i64 16, i1 false), !dbg !173
  store i32 1, i32* %i, align 4, !dbg !174
  br label %for.cond, !dbg !176

for.cond:                                         ; preds = %for.inc, %entry
  %7 = load i32, i32* %i, align 4, !dbg !177
  %cmp = icmp sle i32 %7, 1024, !dbg !179
  br i1 %cmp, label %for.body, label %for.end, !dbg !180

for.body:                                         ; preds = %for.cond
  %8 = load i32, i32* %i, align 4, !dbg !181
  store i32 %8, i32* %i1, align 4, !dbg !183
  %9 = load i32, i32* %i1, align 4, !dbg !184
  %10 = load i32, i32* %d1.addr, align 4, !dbg !185
  %rem = srem i32 %9, %10, !dbg !186
  store i32 %rem, i32* %ii, align 4, !dbg !187
  %11 = load i32, i32* %i1, align 4, !dbg !188
  %mul = mul nsw i32 3, %11, !dbg !189
  %12 = load i32, i32* %d2.addr, align 4, !dbg !190
  %rem1 = srem i32 %mul, %12, !dbg !191
  store i32 %rem1, i32* %ji, align 4, !dbg !192
  %13 = load i32, i32* %i1, align 4, !dbg !193
  %mul2 = mul nsw i32 5, %13, !dbg !194
  %14 = load i32, i32* %d3.addr, align 4, !dbg !195
  %rem3 = srem i32 %mul2, %14, !dbg !196
  store i32 %rem3, i32* %ki, align 4, !dbg !197
  %real = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral, i32 0, i32 0, !dbg !198
  %real4 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %csum_temp, i32 0, i32 0, !dbg !198
  %15 = load double, double* %real4, align 8, !dbg !198
  %16 = load %struct.dcomplex*, %struct.dcomplex** %u.addr, align 8, !dbg !198
  %17 = load i32, i32* %ki, align 4, !dbg !198
  %idxprom = sext i32 %17 to i64, !dbg !198
  %18 = mul nuw i64 %3, %5, !dbg !198
  %19 = mul nsw i64 %idxprom, %18, !dbg !198
  %arrayidx = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %16, i64 %19, !dbg !198
  %20 = load i32, i32* %ji, align 4, !dbg !198
  %idxprom5 = sext i32 %20 to i64, !dbg !198
  %21 = mul nsw i64 %idxprom5, %5, !dbg !198
  %arrayidx6 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx, i64 %21, !dbg !198
  %22 = load i32, i32* %ii, align 4, !dbg !198
  %idxprom7 = sext i32 %22 to i64, !dbg !198
  %arrayidx8 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx6, i64 %idxprom7, !dbg !198
  %real9 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx8, i32 0, i32 0, !dbg !198
  %23 = load double, double* %real9, align 8, !dbg !198
  %add10 = fadd double %15, %23, !dbg !198
  store double %add10, double* %real, align 8, !dbg !198
  %imag = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral, i32 0, i32 1, !dbg !198
  %imag11 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %csum_temp, i32 0, i32 1, !dbg !198
  %24 = load double, double* %imag11, align 8, !dbg !198
  %25 = load %struct.dcomplex*, %struct.dcomplex** %u.addr, align 8, !dbg !198
  %26 = load i32, i32* %ki, align 4, !dbg !198
  %idxprom12 = sext i32 %26 to i64, !dbg !198
  %27 = mul nuw i64 %3, %5, !dbg !198
  %28 = mul nsw i64 %idxprom12, %27, !dbg !198
  %arrayidx13 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %25, i64 %28, !dbg !198
  %29 = load i32, i32* %ji, align 4, !dbg !198
  %idxprom14 = sext i32 %29 to i64, !dbg !198
  %30 = mul nsw i64 %idxprom14, %5, !dbg !198
  %arrayidx15 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx13, i64 %30, !dbg !198
  %31 = load i32, i32* %ii, align 4, !dbg !198
  %idxprom16 = sext i32 %31 to i64, !dbg !198
  %arrayidx17 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx15, i64 %idxprom16, !dbg !198
  %imag18 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx17, i32 0, i32 1, !dbg !198
  %32 = load double, double* %imag18, align 8, !dbg !198
  %add19 = fadd double %24, %32, !dbg !198
  store double %add19, double* %imag, align 8, !dbg !198
  %33 = bitcast %struct.dcomplex* %csum_temp to i8*, !dbg !198
  %34 = bitcast %struct.dcomplex* %.compoundliteral to i8*, !dbg !198
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %33, i8* align 8 %34, i64 16, i1 false), !dbg !198
  br label %for.inc, !dbg !199

for.inc:                                          ; preds = %for.body
  %35 = load i32, i32* %i, align 4, !dbg !200
  %inc = add nsw i32 %35, 1, !dbg !200
  store i32 %inc, i32* %i, align 4, !dbg !200
  br label %for.cond, !dbg !201, !llvm.loop !202

for.end:                                          ; preds = %for.cond
  %real21 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral20, i32 0, i32 0, !dbg !204
  %real22 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %csum_temp, i32 0, i32 0, !dbg !204
  %36 = load double, double* %real22, align 8, !dbg !204
  %37 = load i32, i32* %d1.addr, align 4, !dbg !204
  %38 = load i32, i32* %d2.addr, align 4, !dbg !204
  %mul23 = mul nsw i32 %37, %38, !dbg !204
  %39 = load i32, i32* %d3.addr, align 4, !dbg !204
  %mul24 = mul nsw i32 %mul23, %39, !dbg !204
  %conv = sitofp i32 %mul24 to double, !dbg !204
  %div = fdiv double %36, %conv, !dbg !204
  store double %div, double* %real21, align 8, !dbg !204
  %imag25 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral20, i32 0, i32 1, !dbg !204
  %imag26 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %csum_temp, i32 0, i32 1, !dbg !204
  %40 = load double, double* %imag26, align 8, !dbg !204
  %41 = load i32, i32* %d1.addr, align 4, !dbg !204
  %42 = load i32, i32* %d2.addr, align 4, !dbg !204
  %mul27 = mul nsw i32 %41, %42, !dbg !204
  %43 = load i32, i32* %d3.addr, align 4, !dbg !204
  %mul28 = mul nsw i32 %mul27, %43, !dbg !204
  %conv29 = sitofp i32 %mul28 to double, !dbg !204
  %div30 = fdiv double %40, %conv29, !dbg !204
  store double %div30, double* %imag25, align 8, !dbg !204
  %44 = bitcast %struct.dcomplex* %csum_temp to i8*, !dbg !204
  %45 = bitcast %struct.dcomplex* %.compoundliteral20 to i8*, !dbg !204
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %44, i8* align 8 %45, i64 16, i1 false), !dbg !204
  %46 = load i32, i32* %iterN.addr, align 4, !dbg !205
  %real31 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %csum_temp, i32 0, i32 0, !dbg !206
  %47 = load double, double* %real31, align 8, !dbg !206
  %imag32 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %csum_temp, i32 0, i32 1, !dbg !207
  %48 = load double, double* %imag32, align 8, !dbg !207
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str, i64 0, i64 0), i32 %46, double %47, double %48), !dbg !208
  %49 = load %struct.dcomplex*, %struct.dcomplex** %csum.addr, align 8, !dbg !209
  %50 = bitcast %struct.dcomplex* %49 to i8*, !dbg !210
  %51 = bitcast %struct.dcomplex* %csum_temp to i8*, !dbg !210
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %50, i8* align 8 %51, i64 16, i1 false), !dbg !210
  ret void, !dbg !211
}

; Function Attrs: argmemonly nofree nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #4

declare dso_local i32 @printf(i8*, ...) #5

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @compute_initial_conditions(i32 %d1, i32 %d2, i32 %d3, %struct.dcomplex* %u0) #0 !dbg !212 {
entry:
  %d1.addr = alloca i32, align 4
  %d2.addr = alloca i32, align 4
  %d3.addr = alloca i32, align 4
  %u0.addr = alloca %struct.dcomplex*, align 8
  %tmp = alloca [64 x %struct.dcomplex], align 16
  %x0 = alloca double, align 8
  %start = alloca double, align 8
  %an = alloca double, align 8
  %dummy = alloca double, align 8
  %RanStarts = alloca [64 x double], align 16
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %seed = alloca double, align 8
  %a = alloca double, align 8
  store i32 %d1, i32* %d1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %d1.addr, metadata !215, metadata !DIExpression()), !dbg !216
  store i32 %d2, i32* %d2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %d2.addr, metadata !217, metadata !DIExpression()), !dbg !218
  store i32 %d3, i32* %d3.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %d3.addr, metadata !219, metadata !DIExpression()), !dbg !220
  store %struct.dcomplex* %u0, %struct.dcomplex** %u0.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.dcomplex** %u0.addr, metadata !221, metadata !DIExpression()), !dbg !222
  %0 = load i32, i32* %d3.addr, align 4, !dbg !223
  %1 = zext i32 %0 to i64
  %2 = load i32, i32* %d2.addr, align 4, !dbg !224
  %3 = zext i32 %2 to i64
  %4 = load i32, i32* %d1.addr, align 4, !dbg !225
  %add = add nsw i32 %4, 1, !dbg !226
  %5 = zext i32 %add to i64
  call void @llvm.dbg.declare(metadata [64 x %struct.dcomplex]* %tmp, metadata !227, metadata !DIExpression()), !dbg !231
  call void @llvm.dbg.declare(metadata double* %x0, metadata !232, metadata !DIExpression()), !dbg !233
  call void @llvm.dbg.declare(metadata double* %start, metadata !234, metadata !DIExpression()), !dbg !235
  call void @llvm.dbg.declare(metadata double* %an, metadata !236, metadata !DIExpression()), !dbg !237
  call void @llvm.dbg.declare(metadata double* %dummy, metadata !238, metadata !DIExpression()), !dbg !239
  call void @llvm.dbg.declare(metadata [64 x double]* %RanStarts, metadata !240, metadata !DIExpression()), !dbg !242
  call void @llvm.dbg.declare(metadata i32* %i, metadata !243, metadata !DIExpression()), !dbg !244
  call void @llvm.dbg.declare(metadata i32* %j, metadata !245, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.declare(metadata i32* %k, metadata !247, metadata !DIExpression()), !dbg !248
  call void @llvm.dbg.declare(metadata double* %seed, metadata !249, metadata !DIExpression()), !dbg !250
  store double 0x41B2B9B0A1000000, double* %seed, align 8, !dbg !250
  call void @llvm.dbg.declare(metadata double* %a, metadata !251, metadata !DIExpression()), !dbg !252
  store double 0x41D2309CE5400000, double* %a, align 8, !dbg !252
  store double 0x41B2B9B0A1000000, double* %start, align 8, !dbg !253
  %call = call double @ipow46(double 0x41D2309CE5400000, i32 0), !dbg !254
  store double %call, double* %an, align 8, !dbg !255
  %6 = load double, double* %an, align 8, !dbg !256
  %call1 = call double @randlc(double* %start, double %6), !dbg !257
  store double %call1, double* %dummy, align 8, !dbg !258
  %7 = load i32, i32* %d1.addr, align 4, !dbg !259
  %mul = mul nsw i32 2, %7, !dbg !260
  %8 = load i32, i32* %d2.addr, align 4, !dbg !261
  %mul2 = mul nsw i32 %mul, %8, !dbg !262
  %call3 = call double @ipow46(double 0x41D2309CE5400000, i32 %mul2), !dbg !263
  store double %call3, double* %an, align 8, !dbg !264
  %9 = load double, double* %start, align 8, !dbg !265
  %arrayidx = getelementptr inbounds [64 x double], [64 x double]* %RanStarts, i64 0, i64 0, !dbg !266
  store double %9, double* %arrayidx, align 16, !dbg !267
  store i32 1, i32* %k, align 4, !dbg !268
  br label %for.cond, !dbg !270

for.cond:                                         ; preds = %for.inc, %entry
  %10 = load i32, i32* %k, align 4, !dbg !271
  %11 = load i32, i32* %d3.addr, align 4, !dbg !273
  %cmp = icmp slt i32 %10, %11, !dbg !274
  br i1 %cmp, label %for.body, label %for.end, !dbg !275

for.body:                                         ; preds = %for.cond
  %12 = load double, double* %an, align 8, !dbg !276
  %call4 = call double @randlc(double* %start, double %12), !dbg !278
  store double %call4, double* %dummy, align 8, !dbg !279
  %13 = load double, double* %start, align 8, !dbg !280
  %14 = load i32, i32* %k, align 4, !dbg !281
  %idxprom = sext i32 %14 to i64, !dbg !282
  %arrayidx5 = getelementptr inbounds [64 x double], [64 x double]* %RanStarts, i64 0, i64 %idxprom, !dbg !282
  store double %13, double* %arrayidx5, align 8, !dbg !283
  br label %for.inc, !dbg !284

for.inc:                                          ; preds = %for.body
  %15 = load i32, i32* %k, align 4, !dbg !285
  %inc = add nsw i32 %15, 1, !dbg !285
  store i32 %inc, i32* %k, align 4, !dbg !285
  br label %for.cond, !dbg !286, !llvm.loop !287

for.end:                                          ; preds = %for.cond
  store i32 0, i32* %k, align 4, !dbg !289
  br label %for.cond6, !dbg !291

for.cond6:                                        ; preds = %for.inc32, %for.end
  %16 = load i32, i32* %k, align 4, !dbg !292
  %17 = load i32, i32* %d3.addr, align 4, !dbg !294
  %cmp7 = icmp slt i32 %16, %17, !dbg !295
  br i1 %cmp7, label %for.body8, label %for.end34, !dbg !296

for.body8:                                        ; preds = %for.cond6
  %18 = load i32, i32* %k, align 4, !dbg !297
  %idxprom9 = sext i32 %18 to i64, !dbg !299
  %arrayidx10 = getelementptr inbounds [64 x double], [64 x double]* %RanStarts, i64 0, i64 %idxprom9, !dbg !299
  %19 = load double, double* %arrayidx10, align 8, !dbg !299
  store double %19, double* %x0, align 8, !dbg !300
  store i32 0, i32* %j, align 4, !dbg !301
  br label %for.cond11, !dbg !303

for.cond11:                                       ; preds = %for.inc29, %for.body8
  %20 = load i32, i32* %j, align 4, !dbg !304
  %21 = load i32, i32* %d2.addr, align 4, !dbg !306
  %cmp12 = icmp slt i32 %20, %21, !dbg !307
  br i1 %cmp12, label %for.body13, label %for.end31, !dbg !308

for.body13:                                       ; preds = %for.cond11
  %22 = load i32, i32* %d1.addr, align 4, !dbg !309
  %mul14 = mul nsw i32 2, %22, !dbg !311
  %arraydecay = getelementptr inbounds [64 x %struct.dcomplex], [64 x %struct.dcomplex]* %tmp, i64 0, i64 0, !dbg !312
  %23 = bitcast %struct.dcomplex* %arraydecay to double*, !dbg !313
  call void @vranlc(i32 %mul14, double* %x0, double 0x41D2309CE5400000, double* %23), !dbg !314
  store i32 0, i32* %i, align 4, !dbg !315
  br label %for.cond15, !dbg !317

for.cond15:                                       ; preds = %for.inc26, %for.body13
  %24 = load i32, i32* %i, align 4, !dbg !318
  %25 = load i32, i32* %d1.addr, align 4, !dbg !320
  %cmp16 = icmp slt i32 %24, %25, !dbg !321
  br i1 %cmp16, label %for.body17, label %for.end28, !dbg !322

for.body17:                                       ; preds = %for.cond15
  %26 = load %struct.dcomplex*, %struct.dcomplex** %u0.addr, align 8, !dbg !323
  %27 = load i32, i32* %k, align 4, !dbg !325
  %idxprom18 = sext i32 %27 to i64, !dbg !323
  %28 = mul nuw i64 %3, %5, !dbg !323
  %29 = mul nsw i64 %idxprom18, %28, !dbg !323
  %arrayidx19 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %26, i64 %29, !dbg !323
  %30 = load i32, i32* %j, align 4, !dbg !326
  %idxprom20 = sext i32 %30 to i64, !dbg !323
  %31 = mul nsw i64 %idxprom20, %5, !dbg !323
  %arrayidx21 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx19, i64 %31, !dbg !323
  %32 = load i32, i32* %i, align 4, !dbg !327
  %idxprom22 = sext i32 %32 to i64, !dbg !323
  %arrayidx23 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx21, i64 %idxprom22, !dbg !323
  %33 = load i32, i32* %i, align 4, !dbg !328
  %idxprom24 = sext i32 %33 to i64, !dbg !329
  %arrayidx25 = getelementptr inbounds [64 x %struct.dcomplex], [64 x %struct.dcomplex]* %tmp, i64 0, i64 %idxprom24, !dbg !329
  %34 = bitcast %struct.dcomplex* %arrayidx23 to i8*, !dbg !329
  %35 = bitcast %struct.dcomplex* %arrayidx25 to i8*, !dbg !329
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %34, i8* align 16 %35, i64 16, i1 false), !dbg !329
  br label %for.inc26, !dbg !330

for.inc26:                                        ; preds = %for.body17
  %36 = load i32, i32* %i, align 4, !dbg !331
  %inc27 = add nsw i32 %36, 1, !dbg !331
  store i32 %inc27, i32* %i, align 4, !dbg !331
  br label %for.cond15, !dbg !332, !llvm.loop !333

for.end28:                                        ; preds = %for.cond15
  br label %for.inc29, !dbg !335

for.inc29:                                        ; preds = %for.end28
  %37 = load i32, i32* %j, align 4, !dbg !336
  %inc30 = add nsw i32 %37, 1, !dbg !336
  store i32 %inc30, i32* %j, align 4, !dbg !336
  br label %for.cond11, !dbg !337, !llvm.loop !338

for.end31:                                        ; preds = %for.cond11
  br label %for.inc32, !dbg !340

for.inc32:                                        ; preds = %for.end31
  %38 = load i32, i32* %k, align 4, !dbg !341
  %inc33 = add nsw i32 %38, 1, !dbg !341
  store i32 %inc33, i32* %k, align 4, !dbg !341
  br label %for.cond6, !dbg !342, !llvm.loop !343

for.end34:                                        ; preds = %for.cond6
  ret void, !dbg !345
}

; Function Attrs: noinline nounwind optnone uwtable
define internal double @ipow46(double %a, i32 %exponent) #0 !dbg !346 {
entry:
  %retval = alloca double, align 8
  %a.addr = alloca double, align 8
  %exponent.addr = alloca i32, align 4
  %result = alloca double, align 8
  %dummy = alloca double, align 8
  %q = alloca double, align 8
  %r = alloca double, align 8
  %n = alloca i32, align 4
  %n2 = alloca i32, align 4
  store double %a, double* %a.addr, align 8
  call void @llvm.dbg.declare(metadata double* %a.addr, metadata !349, metadata !DIExpression()), !dbg !350
  store i32 %exponent, i32* %exponent.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %exponent.addr, metadata !351, metadata !DIExpression()), !dbg !352
  call void @llvm.dbg.declare(metadata double* %result, metadata !353, metadata !DIExpression()), !dbg !354
  call void @llvm.dbg.declare(metadata double* %dummy, metadata !355, metadata !DIExpression()), !dbg !356
  call void @llvm.dbg.declare(metadata double* %q, metadata !357, metadata !DIExpression()), !dbg !358
  call void @llvm.dbg.declare(metadata double* %r, metadata !359, metadata !DIExpression()), !dbg !360
  call void @llvm.dbg.declare(metadata i32* %n, metadata !361, metadata !DIExpression()), !dbg !362
  call void @llvm.dbg.declare(metadata i32* %n2, metadata !363, metadata !DIExpression()), !dbg !364
  store double 1.000000e+00, double* %result, align 8, !dbg !365
  %0 = load i32, i32* %exponent.addr, align 4, !dbg !366
  %cmp = icmp eq i32 %0, 0, !dbg !368
  br i1 %cmp, label %if.then, label %if.end, !dbg !369

if.then:                                          ; preds = %entry
  %1 = load double, double* %result, align 8, !dbg !370
  store double %1, double* %retval, align 8, !dbg !371
  br label %return, !dbg !371

if.end:                                           ; preds = %entry
  %2 = load double, double* %a.addr, align 8, !dbg !372
  store double %2, double* %q, align 8, !dbg !373
  store double 1.000000e+00, double* %r, align 8, !dbg !374
  %3 = load i32, i32* %exponent.addr, align 4, !dbg !375
  store i32 %3, i32* %n, align 4, !dbg !376
  br label %while.cond, !dbg !377

while.cond:                                       ; preds = %if.end5, %if.end
  %4 = load i32, i32* %n, align 4, !dbg !378
  %cmp1 = icmp sgt i32 %4, 1, !dbg !379
  br i1 %cmp1, label %while.body, label %while.end, !dbg !377

while.body:                                       ; preds = %while.cond
  %5 = load i32, i32* %n, align 4, !dbg !380
  %div = sdiv i32 %5, 2, !dbg !382
  store i32 %div, i32* %n2, align 4, !dbg !383
  %6 = load i32, i32* %n2, align 4, !dbg !384
  %mul = mul nsw i32 %6, 2, !dbg !386
  %7 = load i32, i32* %n, align 4, !dbg !387
  %cmp2 = icmp eq i32 %mul, %7, !dbg !388
  br i1 %cmp2, label %if.then3, label %if.else, !dbg !389

if.then3:                                         ; preds = %while.body
  %8 = load double, double* %q, align 8, !dbg !390
  %call = call double @randlc(double* %q, double %8), !dbg !392
  store double %call, double* %dummy, align 8, !dbg !393
  %9 = load i32, i32* %n2, align 4, !dbg !394
  store i32 %9, i32* %n, align 4, !dbg !395
  br label %if.end5, !dbg !396

if.else:                                          ; preds = %while.body
  %10 = load double, double* %q, align 8, !dbg !397
  %call4 = call double @randlc(double* %r, double %10), !dbg !399
  store double %call4, double* %dummy, align 8, !dbg !400
  %11 = load i32, i32* %n, align 4, !dbg !401
  %sub = sub nsw i32 %11, 1, !dbg !402
  store i32 %sub, i32* %n, align 4, !dbg !403
  br label %if.end5

if.end5:                                          ; preds = %if.else, %if.then3
  br label %while.cond, !dbg !377, !llvm.loop !404

while.end:                                        ; preds = %while.cond
  %12 = load double, double* %q, align 8, !dbg !406
  %call6 = call double @randlc(double* %r, double %12), !dbg !407
  store double %call6, double* %dummy, align 8, !dbg !408
  %13 = load double, double* %r, align 8, !dbg !409
  store double %13, double* %result, align 8, !dbg !410
  %14 = load double, double* %result, align 8, !dbg !411
  store double %14, double* %retval, align 8, !dbg !412
  br label %return, !dbg !412

return:                                           ; preds = %while.end, %if.then
  %15 = load double, double* %retval, align 8, !dbg !413
  ret double %15, !dbg !413
}

declare dso_local double @randlc(double*, double) #5

declare dso_local void @vranlc(i32, double*, double, double*) #5

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @evolve(i32 %nx, i32 %ny, i32 %nz, %struct.dcomplex* %x, %struct.dcomplex* %y, double* %twiddle) #0 !dbg !414 {
entry:
  %nx.addr = alloca i32, align 4
  %ny.addr = alloca i32, align 4
  %nz.addr = alloca i32, align 4
  %x.addr = alloca %struct.dcomplex*, align 8
  %y.addr = alloca %struct.dcomplex*, align 8
  %twiddle.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %.compoundliteral = alloca %struct.dcomplex, align 8
  store i32 %nx, i32* %nx.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %nx.addr, metadata !419, metadata !DIExpression()), !dbg !420
  store i32 %ny, i32* %ny.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ny.addr, metadata !421, metadata !DIExpression()), !dbg !422
  store i32 %nz, i32* %nz.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %nz.addr, metadata !423, metadata !DIExpression()), !dbg !424
  store %struct.dcomplex* %x, %struct.dcomplex** %x.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.dcomplex** %x.addr, metadata !425, metadata !DIExpression()), !dbg !426
  store %struct.dcomplex* %y, %struct.dcomplex** %y.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.dcomplex** %y.addr, metadata !427, metadata !DIExpression()), !dbg !428
  store double* %twiddle, double** %twiddle.addr, align 8
  call void @llvm.dbg.declare(metadata double** %twiddle.addr, metadata !429, metadata !DIExpression()), !dbg !430
  %0 = load i32, i32* %nz.addr, align 4, !dbg !431
  %1 = zext i32 %0 to i64
  %2 = load i32, i32* %ny.addr, align 4, !dbg !432
  %3 = zext i32 %2 to i64
  %4 = load i32, i32* %nx.addr, align 4, !dbg !433
  %add = add nsw i32 %4, 1, !dbg !434
  %5 = zext i32 %add to i64
  %6 = load i32, i32* %nz.addr, align 4, !dbg !435
  %7 = zext i32 %6 to i64
  %8 = load i32, i32* %ny.addr, align 4, !dbg !436
  %9 = zext i32 %8 to i64
  %10 = load i32, i32* %nx.addr, align 4, !dbg !437
  %add1 = add nsw i32 %10, 1, !dbg !438
  %11 = zext i32 %add1 to i64
  %12 = load i32, i32* %nz.addr, align 4, !dbg !439
  %13 = zext i32 %12 to i64
  %14 = load i32, i32* %ny.addr, align 4, !dbg !440
  %15 = zext i32 %14 to i64
  %16 = load i32, i32* %nx.addr, align 4, !dbg !441
  %add2 = add nsw i32 %16, 1, !dbg !442
  %17 = zext i32 %add2 to i64
  call void @llvm.dbg.declare(metadata i32* %i, metadata !443, metadata !DIExpression()), !dbg !444
  call void @llvm.dbg.declare(metadata i32* %j, metadata !445, metadata !DIExpression()), !dbg !446
  call void @llvm.dbg.declare(metadata i32* %k, metadata !447, metadata !DIExpression()), !dbg !448
  store i32 0, i32* %i, align 4, !dbg !449
  br label %for.cond, !dbg !451

for.cond:                                         ; preds = %for.inc55, %entry
  %18 = load i32, i32* %i, align 4, !dbg !452
  %19 = load i32, i32* %nz.addr, align 4, !dbg !454
  %cmp = icmp slt i32 %18, %19, !dbg !455
  br i1 %cmp, label %for.body, label %for.end57, !dbg !456

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %k, align 4, !dbg !457
  br label %for.cond3, !dbg !460

for.cond3:                                        ; preds = %for.inc52, %for.body
  %20 = load i32, i32* %k, align 4, !dbg !461
  %21 = load i32, i32* %ny.addr, align 4, !dbg !463
  %cmp4 = icmp slt i32 %20, %21, !dbg !464
  br i1 %cmp4, label %for.body5, label %for.end54, !dbg !465

for.body5:                                        ; preds = %for.cond3
  store i32 0, i32* %j, align 4, !dbg !466
  br label %for.cond6, !dbg !469

for.cond6:                                        ; preds = %for.inc, %for.body5
  %22 = load i32, i32* %j, align 4, !dbg !470
  %23 = load i32, i32* %nx.addr, align 4, !dbg !472
  %cmp7 = icmp slt i32 %22, %23, !dbg !473
  br i1 %cmp7, label %for.body8, label %for.end, !dbg !474

for.body8:                                        ; preds = %for.cond6
  %24 = load %struct.dcomplex*, %struct.dcomplex** %y.addr, align 8, !dbg !475
  %25 = load i32, i32* %i, align 4, !dbg !477
  %idxprom = sext i32 %25 to i64, !dbg !475
  %26 = mul nuw i64 %9, %11, !dbg !475
  %27 = mul nsw i64 %idxprom, %26, !dbg !475
  %arrayidx = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %24, i64 %27, !dbg !475
  %28 = load i32, i32* %k, align 4, !dbg !478
  %idxprom9 = sext i32 %28 to i64, !dbg !475
  %29 = mul nsw i64 %idxprom9, %11, !dbg !475
  %arrayidx10 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx, i64 %29, !dbg !475
  %30 = load i32, i32* %j, align 4, !dbg !479
  %idxprom11 = sext i32 %30 to i64, !dbg !475
  %arrayidx12 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx10, i64 %idxprom11, !dbg !475
  %real = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral, i32 0, i32 0, !dbg !480
  %31 = load %struct.dcomplex*, %struct.dcomplex** %y.addr, align 8, !dbg !480
  %32 = load i32, i32* %i, align 4, !dbg !480
  %idxprom13 = sext i32 %32 to i64, !dbg !480
  %33 = mul nuw i64 %9, %11, !dbg !480
  %34 = mul nsw i64 %idxprom13, %33, !dbg !480
  %arrayidx14 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %31, i64 %34, !dbg !480
  %35 = load i32, i32* %k, align 4, !dbg !480
  %idxprom15 = sext i32 %35 to i64, !dbg !480
  %36 = mul nsw i64 %idxprom15, %11, !dbg !480
  %arrayidx16 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx14, i64 %36, !dbg !480
  %37 = load i32, i32* %j, align 4, !dbg !480
  %idxprom17 = sext i32 %37 to i64, !dbg !480
  %arrayidx18 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx16, i64 %idxprom17, !dbg !480
  %real19 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx18, i32 0, i32 0, !dbg !480
  %38 = load double, double* %real19, align 8, !dbg !480
  %39 = load double*, double** %twiddle.addr, align 8, !dbg !480
  %40 = load i32, i32* %i, align 4, !dbg !480
  %idxprom20 = sext i32 %40 to i64, !dbg !480
  %41 = mul nuw i64 %15, %17, !dbg !480
  %42 = mul nsw i64 %idxprom20, %41, !dbg !480
  %arrayidx21 = getelementptr inbounds double, double* %39, i64 %42, !dbg !480
  %43 = load i32, i32* %k, align 4, !dbg !480
  %idxprom22 = sext i32 %43 to i64, !dbg !480
  %44 = mul nsw i64 %idxprom22, %17, !dbg !480
  %arrayidx23 = getelementptr inbounds double, double* %arrayidx21, i64 %44, !dbg !480
  %45 = load i32, i32* %j, align 4, !dbg !480
  %idxprom24 = sext i32 %45 to i64, !dbg !480
  %arrayidx25 = getelementptr inbounds double, double* %arrayidx23, i64 %idxprom24, !dbg !480
  %46 = load double, double* %arrayidx25, align 8, !dbg !480
  %mul = fmul double %38, %46, !dbg !480
  store double %mul, double* %real, align 8, !dbg !480
  %imag = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %.compoundliteral, i32 0, i32 1, !dbg !480
  %47 = load %struct.dcomplex*, %struct.dcomplex** %y.addr, align 8, !dbg !480
  %48 = load i32, i32* %i, align 4, !dbg !480
  %idxprom26 = sext i32 %48 to i64, !dbg !480
  %49 = mul nuw i64 %9, %11, !dbg !480
  %50 = mul nsw i64 %idxprom26, %49, !dbg !480
  %arrayidx27 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %47, i64 %50, !dbg !480
  %51 = load i32, i32* %k, align 4, !dbg !480
  %idxprom28 = sext i32 %51 to i64, !dbg !480
  %52 = mul nsw i64 %idxprom28, %11, !dbg !480
  %arrayidx29 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx27, i64 %52, !dbg !480
  %53 = load i32, i32* %j, align 4, !dbg !480
  %idxprom30 = sext i32 %53 to i64, !dbg !480
  %arrayidx31 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx29, i64 %idxprom30, !dbg !480
  %imag32 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx31, i32 0, i32 1, !dbg !480
  %54 = load double, double* %imag32, align 8, !dbg !480
  %55 = load double*, double** %twiddle.addr, align 8, !dbg !480
  %56 = load i32, i32* %i, align 4, !dbg !480
  %idxprom33 = sext i32 %56 to i64, !dbg !480
  %57 = mul nuw i64 %15, %17, !dbg !480
  %58 = mul nsw i64 %idxprom33, %57, !dbg !480
  %arrayidx34 = getelementptr inbounds double, double* %55, i64 %58, !dbg !480
  %59 = load i32, i32* %k, align 4, !dbg !480
  %idxprom35 = sext i32 %59 to i64, !dbg !480
  %60 = mul nsw i64 %idxprom35, %17, !dbg !480
  %arrayidx36 = getelementptr inbounds double, double* %arrayidx34, i64 %60, !dbg !480
  %61 = load i32, i32* %j, align 4, !dbg !480
  %idxprom37 = sext i32 %61 to i64, !dbg !480
  %arrayidx38 = getelementptr inbounds double, double* %arrayidx36, i64 %idxprom37, !dbg !480
  %62 = load double, double* %arrayidx38, align 8, !dbg !480
  %mul39 = fmul double %54, %62, !dbg !480
  store double %mul39, double* %imag, align 8, !dbg !480
  %63 = bitcast %struct.dcomplex* %arrayidx12 to i8*, !dbg !480
  %64 = bitcast %struct.dcomplex* %.compoundliteral to i8*, !dbg !480
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %63, i8* align 8 %64, i64 16, i1 false), !dbg !480
  %65 = load %struct.dcomplex*, %struct.dcomplex** %x.addr, align 8, !dbg !481
  %66 = load i32, i32* %i, align 4, !dbg !482
  %idxprom40 = sext i32 %66 to i64, !dbg !481
  %67 = mul nuw i64 %3, %5, !dbg !481
  %68 = mul nsw i64 %idxprom40, %67, !dbg !481
  %arrayidx41 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %65, i64 %68, !dbg !481
  %69 = load i32, i32* %k, align 4, !dbg !483
  %idxprom42 = sext i32 %69 to i64, !dbg !481
  %70 = mul nsw i64 %idxprom42, %5, !dbg !481
  %arrayidx43 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx41, i64 %70, !dbg !481
  %71 = load i32, i32* %j, align 4, !dbg !484
  %idxprom44 = sext i32 %71 to i64, !dbg !481
  %arrayidx45 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx43, i64 %idxprom44, !dbg !481
  %72 = load %struct.dcomplex*, %struct.dcomplex** %y.addr, align 8, !dbg !485
  %73 = load i32, i32* %i, align 4, !dbg !486
  %idxprom46 = sext i32 %73 to i64, !dbg !485
  %74 = mul nuw i64 %9, %11, !dbg !485
  %75 = mul nsw i64 %idxprom46, %74, !dbg !485
  %arrayidx47 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %72, i64 %75, !dbg !485
  %76 = load i32, i32* %k, align 4, !dbg !487
  %idxprom48 = sext i32 %76 to i64, !dbg !485
  %77 = mul nsw i64 %idxprom48, %11, !dbg !485
  %arrayidx49 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx47, i64 %77, !dbg !485
  %78 = load i32, i32* %j, align 4, !dbg !488
  %idxprom50 = sext i32 %78 to i64, !dbg !485
  %arrayidx51 = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %arrayidx49, i64 %idxprom50, !dbg !485
  %79 = bitcast %struct.dcomplex* %arrayidx45 to i8*, !dbg !485
  %80 = bitcast %struct.dcomplex* %arrayidx51 to i8*, !dbg !485
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %79, i8* align 8 %80, i64 16, i1 false), !dbg !485
  br label %for.inc, !dbg !489

for.inc:                                          ; preds = %for.body8
  %81 = load i32, i32* %j, align 4, !dbg !490
  %inc = add nsw i32 %81, 1, !dbg !490
  store i32 %inc, i32* %j, align 4, !dbg !490
  br label %for.cond6, !dbg !491, !llvm.loop !492

for.end:                                          ; preds = %for.cond6
  br label %for.inc52, !dbg !494

for.inc52:                                        ; preds = %for.end
  %82 = load i32, i32* %k, align 4, !dbg !495
  %inc53 = add nsw i32 %82, 1, !dbg !495
  store i32 %inc53, i32* %k, align 4, !dbg !495
  br label %for.cond3, !dbg !496, !llvm.loop !497

for.end54:                                        ; preds = %for.cond3
  br label %for.inc55, !dbg !499

for.inc55:                                        ; preds = %for.end54
  %83 = load i32, i32* %i, align 4, !dbg !500
  %inc56 = add nsw i32 %83, 1, !dbg !500
  store i32 %inc56, i32* %i, align 4, !dbg !500
  br label %for.cond, !dbg !501, !llvm.loop !502

for.end57:                                        ; preds = %for.cond
  ret void, !dbg !504
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nofree nounwind willreturn }
attributes #3 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { argmemonly nofree nounwind willreturn writeonly }
attributes #5 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!6, !7, !8, !9, !10}
!llvm.ident = !{!11}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, debugInfoForProfiling: true, nameTableKind: None)
!1 = !DIFile(filename: "auxfnct.c", directory: "/workspace/LLVM-Checker/test/benchmarks/NPB/FT")
!2 = !{}
!3 = !{!4, !5}
!4 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!6 = !{i32 7, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = !{i32 7, !"uwtable", i32 1}
!10 = !{i32 7, !"frame-pointer", i32 2}
!11 = !{!"clang version 13.0.1"}
!12 = distinct !DISubprogram(name: "CompExp", scope: !1, file: !1, line: 44, type: !13, scopeLine: 45, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!13 = !DISubroutineType(types: !14)
!14 = !{null, !15, !16}
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "dcomplex", file: !18, line: 8, baseType: !19)
!18 = !DIFile(filename: "../common/type.h", directory: "/workspace/LLVM-Checker/test/benchmarks/NPB/FT")
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !18, line: 5, size: 128, elements: !20)
!20 = !{!21, !22}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "real", scope: !19, file: !18, line: 6, baseType: !4, size: 64)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "imag", scope: !19, file: !18, line: 7, baseType: !4, size: 64, offset: 64)
!23 = !DILocalVariable(name: "n", arg: 1, scope: !12, file: !1, line: 44, type: !15)
!24 = !DILocation(line: 44, column: 18, scope: !12)
!25 = !DILocalVariable(name: "exponent", arg: 2, scope: !12, file: !1, line: 44, type: !16)
!26 = !DILocation(line: 44, column: 30, scope: !12)
!27 = !DILocation(line: 44, column: 39, scope: !12)
!28 = !DILocalVariable(name: "m", scope: !12, file: !1, line: 46, type: !15)
!29 = !DILocation(line: 46, column: 7, scope: !12)
!30 = !DILocalVariable(name: "nu", scope: !12, file: !1, line: 46, type: !15)
!31 = !DILocation(line: 46, column: 10, scope: !12)
!32 = !DILocalVariable(name: "ku", scope: !12, file: !1, line: 46, type: !15)
!33 = !DILocation(line: 46, column: 14, scope: !12)
!34 = !DILocalVariable(name: "i", scope: !12, file: !1, line: 46, type: !15)
!35 = !DILocation(line: 46, column: 18, scope: !12)
!36 = !DILocalVariable(name: "j", scope: !12, file: !1, line: 46, type: !15)
!37 = !DILocation(line: 46, column: 21, scope: !12)
!38 = !DILocalVariable(name: "ln", scope: !12, file: !1, line: 46, type: !15)
!39 = !DILocation(line: 46, column: 24, scope: !12)
!40 = !DILocalVariable(name: "t", scope: !12, file: !1, line: 47, type: !4)
!41 = !DILocation(line: 47, column: 10, scope: !12)
!42 = !DILocalVariable(name: "ti", scope: !12, file: !1, line: 47, type: !4)
!43 = !DILocation(line: 47, column: 13, scope: !12)
!44 = !DILocalVariable(name: "pi", scope: !12, file: !1, line: 48, type: !45)
!45 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4)
!46 = !DILocation(line: 48, column: 16, scope: !12)
!47 = !DILocation(line: 50, column: 8, scope: !12)
!48 = !DILocation(line: 50, column: 6, scope: !12)
!49 = !DILocation(line: 51, column: 13, scope: !12)
!50 = !DILocation(line: 51, column: 7, scope: !12)
!51 = !DILocation(line: 51, column: 5, scope: !12)
!52 = !DILocation(line: 52, column: 3, scope: !12)
!53 = !DILocation(line: 52, column: 17, scope: !12)
!54 = !DILocation(line: 53, column: 6, scope: !12)
!55 = !DILocation(line: 54, column: 6, scope: !12)
!56 = !DILocation(line: 55, column: 10, scope: !57)
!57 = distinct !DILexicalBlock(scope: !12, file: !1, line: 55, column: 3)
!58 = !DILocation(line: 55, column: 8, scope: !57)
!59 = !DILocation(line: 55, column: 15, scope: !60)
!60 = distinct !DILexicalBlock(scope: !57, file: !1, line: 55, column: 3)
!61 = !DILocation(line: 55, column: 20, scope: !60)
!62 = !DILocation(line: 55, column: 17, scope: !60)
!63 = !DILocation(line: 55, column: 3, scope: !57)
!64 = !DILocation(line: 56, column: 14, scope: !65)
!65 = distinct !DILexicalBlock(scope: !60, file: !1, line: 55, column: 28)
!66 = !DILocation(line: 56, column: 12, scope: !65)
!67 = !DILocation(line: 56, column: 7, scope: !65)
!68 = !DILocation(line: 57, column: 12, scope: !69)
!69 = distinct !DILexicalBlock(scope: !65, file: !1, line: 57, column: 5)
!70 = !DILocation(line: 57, column: 10, scope: !69)
!71 = !DILocation(line: 57, column: 17, scope: !72)
!72 = distinct !DILexicalBlock(scope: !69, file: !1, line: 57, column: 5)
!73 = !DILocation(line: 57, column: 22, scope: !72)
!74 = !DILocation(line: 57, column: 25, scope: !72)
!75 = !DILocation(line: 57, column: 19, scope: !72)
!76 = !DILocation(line: 57, column: 5, scope: !69)
!77 = !DILocation(line: 58, column: 12, scope: !78)
!78 = distinct !DILexicalBlock(scope: !72, file: !1, line: 57, column: 35)
!79 = !DILocation(line: 58, column: 16, scope: !78)
!80 = !DILocation(line: 58, column: 14, scope: !78)
!81 = !DILocation(line: 58, column: 10, scope: !78)
!82 = !DILocation(line: 59, column: 7, scope: !78)
!83 = !DILocation(line: 59, column: 16, scope: !78)
!84 = !DILocation(line: 59, column: 18, scope: !78)
!85 = !DILocation(line: 59, column: 17, scope: !78)
!86 = !DILocation(line: 59, column: 20, scope: !78)
!87 = !DILocation(line: 59, column: 26, scope: !78)
!88 = !DILocation(line: 60, column: 5, scope: !78)
!89 = !DILocation(line: 57, column: 31, scope: !72)
!90 = !DILocation(line: 57, column: 5, scope: !72)
!91 = distinct !{!91, !76, !92, !93}
!92 = !DILocation(line: 60, column: 5, scope: !69)
!93 = !{!"llvm.loop.mustprogress"}
!94 = !DILocation(line: 61, column: 10, scope: !65)
!95 = !DILocation(line: 61, column: 15, scope: !65)
!96 = !DILocation(line: 61, column: 13, scope: !65)
!97 = !DILocation(line: 61, column: 8, scope: !65)
!98 = !DILocation(line: 62, column: 14, scope: !65)
!99 = !DILocation(line: 62, column: 12, scope: !65)
!100 = !DILocation(line: 62, column: 8, scope: !65)
!101 = !DILocation(line: 63, column: 3, scope: !65)
!102 = !DILocation(line: 55, column: 24, scope: !60)
!103 = !DILocation(line: 55, column: 3, scope: !60)
!104 = distinct !{!104, !63, !105, !93}
!105 = !DILocation(line: 63, column: 3, scope: !57)
!106 = !DILocation(line: 64, column: 1, scope: !12)
!107 = distinct !DISubprogram(name: "ilog2", scope: !1, file: !1, line: 67, type: !108, scopeLine: 68, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!108 = !DISubroutineType(types: !109)
!109 = !{!15, !15}
!110 = !DILocalVariable(name: "n", arg: 1, scope: !107, file: !1, line: 67, type: !15)
!111 = !DILocation(line: 67, column: 15, scope: !107)
!112 = !DILocalVariable(name: "nn", scope: !107, file: !1, line: 69, type: !15)
!113 = !DILocation(line: 69, column: 7, scope: !107)
!114 = !DILocalVariable(name: "lg", scope: !107, file: !1, line: 69, type: !15)
!115 = !DILocation(line: 69, column: 11, scope: !107)
!116 = !DILocation(line: 70, column: 7, scope: !117)
!117 = distinct !DILexicalBlock(scope: !107, file: !1, line: 70, column: 7)
!118 = !DILocation(line: 70, column: 9, scope: !117)
!119 = !DILocation(line: 70, column: 7, scope: !107)
!120 = !DILocation(line: 70, column: 15, scope: !117)
!121 = !DILocation(line: 72, column: 6, scope: !107)
!122 = !DILocation(line: 73, column: 6, scope: !107)
!123 = !DILocation(line: 74, column: 3, scope: !107)
!124 = !DILocation(line: 74, column: 10, scope: !107)
!125 = !DILocation(line: 74, column: 15, scope: !107)
!126 = !DILocation(line: 74, column: 13, scope: !107)
!127 = !DILocation(line: 75, column: 10, scope: !128)
!128 = distinct !DILexicalBlock(scope: !107, file: !1, line: 74, column: 18)
!129 = !DILocation(line: 75, column: 13, scope: !128)
!130 = !DILocation(line: 75, column: 8, scope: !128)
!131 = !DILocation(line: 76, column: 10, scope: !128)
!132 = !DILocation(line: 76, column: 13, scope: !128)
!133 = !DILocation(line: 76, column: 8, scope: !128)
!134 = distinct !{!134, !123, !135, !93}
!135 = !DILocation(line: 77, column: 3, scope: !107)
!136 = !DILocation(line: 78, column: 10, scope: !107)
!137 = !DILocation(line: 78, column: 3, scope: !107)
!138 = !DILocation(line: 79, column: 1, scope: !107)
!139 = distinct !DISubprogram(name: "CalculateChecksum", scope: !1, file: !1, line: 117, type: !140, scopeLine: 119, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!140 = !DISubroutineType(types: !141)
!141 = !{null, !16, !15, !15, !15, !15, !142}
!142 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !143, size: 64)
!143 = !DICompositeType(tag: DW_TAG_array_type, baseType: !17, elements: !144)
!144 = !{!145, !145}
!145 = !DISubrange(count: -1)
!146 = !DILocalVariable(name: "csum", arg: 1, scope: !139, file: !1, line: 117, type: !16)
!147 = !DILocation(line: 117, column: 34, scope: !139)
!148 = !DILocalVariable(name: "iterN", arg: 2, scope: !139, file: !1, line: 117, type: !15)
!149 = !DILocation(line: 117, column: 44, scope: !139)
!150 = !DILocalVariable(name: "d1", arg: 3, scope: !139, file: !1, line: 117, type: !15)
!151 = !DILocation(line: 117, column: 55, scope: !139)
!152 = !DILocalVariable(name: "d2", arg: 4, scope: !139, file: !1, line: 117, type: !15)
!153 = !DILocation(line: 117, column: 63, scope: !139)
!154 = !DILocalVariable(name: "d3", arg: 5, scope: !139, file: !1, line: 117, type: !15)
!155 = !DILocation(line: 117, column: 71, scope: !139)
!156 = !DILocalVariable(name: "u", arg: 6, scope: !139, file: !1, line: 118, type: !142)
!157 = !DILocation(line: 118, column: 33, scope: !139)
!158 = !DILocation(line: 118, column: 35, scope: !139)
!159 = !DILocation(line: 118, column: 39, scope: !139)
!160 = !DILocation(line: 118, column: 43, scope: !139)
!161 = !DILocation(line: 118, column: 45, scope: !139)
!162 = !DILocalVariable(name: "i", scope: !139, file: !1, line: 120, type: !15)
!163 = !DILocation(line: 120, column: 7, scope: !139)
!164 = !DILocalVariable(name: "i1", scope: !139, file: !1, line: 120, type: !15)
!165 = !DILocation(line: 120, column: 10, scope: !139)
!166 = !DILocalVariable(name: "ii", scope: !139, file: !1, line: 120, type: !15)
!167 = !DILocation(line: 120, column: 14, scope: !139)
!168 = !DILocalVariable(name: "ji", scope: !139, file: !1, line: 120, type: !15)
!169 = !DILocation(line: 120, column: 18, scope: !139)
!170 = !DILocalVariable(name: "ki", scope: !139, file: !1, line: 120, type: !15)
!171 = !DILocation(line: 120, column: 22, scope: !139)
!172 = !DILocalVariable(name: "csum_temp", scope: !139, file: !1, line: 121, type: !17)
!173 = !DILocation(line: 121, column: 12, scope: !139)
!174 = !DILocation(line: 122, column: 10, scope: !175)
!175 = distinct !DILexicalBlock(scope: !139, file: !1, line: 122, column: 3)
!176 = !DILocation(line: 122, column: 8, scope: !175)
!177 = !DILocation(line: 122, column: 15, scope: !178)
!178 = distinct !DILexicalBlock(scope: !175, file: !1, line: 122, column: 3)
!179 = !DILocation(line: 122, column: 17, scope: !178)
!180 = !DILocation(line: 122, column: 3, scope: !175)
!181 = !DILocation(line: 123, column: 10, scope: !182)
!182 = distinct !DILexicalBlock(scope: !178, file: !1, line: 122, column: 31)
!183 = !DILocation(line: 123, column: 8, scope: !182)
!184 = !DILocation(line: 124, column: 10, scope: !182)
!185 = !DILocation(line: 124, column: 15, scope: !182)
!186 = !DILocation(line: 124, column: 13, scope: !182)
!187 = !DILocation(line: 124, column: 8, scope: !182)
!188 = !DILocation(line: 125, column: 14, scope: !182)
!189 = !DILocation(line: 125, column: 12, scope: !182)
!190 = !DILocation(line: 125, column: 19, scope: !182)
!191 = !DILocation(line: 125, column: 17, scope: !182)
!192 = !DILocation(line: 125, column: 8, scope: !182)
!193 = !DILocation(line: 126, column: 14, scope: !182)
!194 = !DILocation(line: 126, column: 12, scope: !182)
!195 = !DILocation(line: 126, column: 19, scope: !182)
!196 = !DILocation(line: 126, column: 17, scope: !182)
!197 = !DILocation(line: 126, column: 8, scope: !182)
!198 = !DILocation(line: 127, column: 17, scope: !182)
!199 = !DILocation(line: 128, column: 3, scope: !182)
!200 = !DILocation(line: 122, column: 27, scope: !178)
!201 = !DILocation(line: 122, column: 3, scope: !178)
!202 = distinct !{!202, !180, !203, !93}
!203 = !DILocation(line: 128, column: 3, scope: !175)
!204 = !DILocation(line: 129, column: 15, scope: !139)
!205 = !DILocation(line: 131, column: 7, scope: !139)
!206 = !DILocation(line: 131, column: 24, scope: !139)
!207 = !DILocation(line: 131, column: 40, scope: !139)
!208 = !DILocation(line: 130, column: 3, scope: !139)
!209 = !DILocation(line: 132, column: 4, scope: !139)
!210 = !DILocation(line: 132, column: 11, scope: !139)
!211 = !DILocation(line: 133, column: 1, scope: !139)
!212 = distinct !DISubprogram(name: "compute_initial_conditions", scope: !1, file: !1, line: 136, type: !213, scopeLine: 138, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!213 = !DISubroutineType(types: !214)
!214 = !{null, !15, !15, !15, !142}
!215 = !DILocalVariable(name: "d1", arg: 1, scope: !212, file: !1, line: 136, type: !15)
!216 = !DILocation(line: 136, column: 37, scope: !212)
!217 = !DILocalVariable(name: "d2", arg: 2, scope: !212, file: !1, line: 136, type: !15)
!218 = !DILocation(line: 136, column: 45, scope: !212)
!219 = !DILocalVariable(name: "d3", arg: 3, scope: !212, file: !1, line: 136, type: !15)
!220 = !DILocation(line: 136, column: 53, scope: !212)
!221 = !DILocalVariable(name: "u0", arg: 4, scope: !212, file: !1, line: 137, type: !142)
!222 = !DILocation(line: 137, column: 42, scope: !212)
!223 = !DILocation(line: 137, column: 45, scope: !212)
!224 = !DILocation(line: 137, column: 49, scope: !212)
!225 = !DILocation(line: 137, column: 53, scope: !212)
!226 = !DILocation(line: 137, column: 55, scope: !212)
!227 = !DILocalVariable(name: "tmp", scope: !212, file: !1, line: 139, type: !228)
!228 = !DICompositeType(tag: DW_TAG_array_type, baseType: !17, size: 8192, elements: !229)
!229 = !{!230}
!230 = !DISubrange(count: 64)
!231 = !DILocation(line: 139, column: 12, scope: !212)
!232 = !DILocalVariable(name: "x0", scope: !212, file: !1, line: 140, type: !4)
!233 = !DILocation(line: 140, column: 10, scope: !212)
!234 = !DILocalVariable(name: "start", scope: !212, file: !1, line: 140, type: !4)
!235 = !DILocation(line: 140, column: 14, scope: !212)
!236 = !DILocalVariable(name: "an", scope: !212, file: !1, line: 140, type: !4)
!237 = !DILocation(line: 140, column: 21, scope: !212)
!238 = !DILocalVariable(name: "dummy", scope: !212, file: !1, line: 140, type: !4)
!239 = !DILocation(line: 140, column: 25, scope: !212)
!240 = !DILocalVariable(name: "RanStarts", scope: !212, file: !1, line: 141, type: !241)
!241 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 4096, elements: !229)
!242 = !DILocation(line: 141, column: 10, scope: !212)
!243 = !DILocalVariable(name: "i", scope: !212, file: !1, line: 143, type: !15)
!244 = !DILocation(line: 143, column: 7, scope: !212)
!245 = !DILocalVariable(name: "j", scope: !212, file: !1, line: 143, type: !15)
!246 = !DILocation(line: 143, column: 10, scope: !212)
!247 = !DILocalVariable(name: "k", scope: !212, file: !1, line: 143, type: !15)
!248 = !DILocation(line: 143, column: 13, scope: !212)
!249 = !DILocalVariable(name: "seed", scope: !212, file: !1, line: 144, type: !45)
!250 = !DILocation(line: 144, column: 16, scope: !212)
!251 = !DILocalVariable(name: "a", scope: !212, file: !1, line: 145, type: !45)
!252 = !DILocation(line: 145, column: 16, scope: !212)
!253 = !DILocation(line: 147, column: 9, scope: !212)
!254 = !DILocation(line: 151, column: 8, scope: !212)
!255 = !DILocation(line: 151, column: 6, scope: !212)
!256 = !DILocation(line: 152, column: 26, scope: !212)
!257 = !DILocation(line: 152, column: 11, scope: !212)
!258 = !DILocation(line: 152, column: 9, scope: !212)
!259 = !DILocation(line: 153, column: 20, scope: !212)
!260 = !DILocation(line: 153, column: 19, scope: !212)
!261 = !DILocation(line: 153, column: 23, scope: !212)
!262 = !DILocation(line: 153, column: 22, scope: !212)
!263 = !DILocation(line: 153, column: 8, scope: !212)
!264 = !DILocation(line: 153, column: 6, scope: !212)
!265 = !DILocation(line: 157, column: 18, scope: !212)
!266 = !DILocation(line: 157, column: 3, scope: !212)
!267 = !DILocation(line: 157, column: 16, scope: !212)
!268 = !DILocation(line: 158, column: 10, scope: !269)
!269 = distinct !DILexicalBlock(scope: !212, file: !1, line: 158, column: 3)
!270 = !DILocation(line: 158, column: 8, scope: !269)
!271 = !DILocation(line: 158, column: 15, scope: !272)
!272 = distinct !DILexicalBlock(scope: !269, file: !1, line: 158, column: 3)
!273 = !DILocation(line: 158, column: 19, scope: !272)
!274 = !DILocation(line: 158, column: 17, scope: !272)
!275 = !DILocation(line: 158, column: 3, scope: !269)
!276 = !DILocation(line: 159, column: 28, scope: !277)
!277 = distinct !DILexicalBlock(scope: !272, file: !1, line: 158, column: 28)
!278 = !DILocation(line: 159, column: 13, scope: !277)
!279 = !DILocation(line: 159, column: 11, scope: !277)
!280 = !DILocation(line: 160, column: 20, scope: !277)
!281 = !DILocation(line: 160, column: 15, scope: !277)
!282 = !DILocation(line: 160, column: 5, scope: !277)
!283 = !DILocation(line: 160, column: 18, scope: !277)
!284 = !DILocation(line: 161, column: 3, scope: !277)
!285 = !DILocation(line: 158, column: 24, scope: !272)
!286 = !DILocation(line: 158, column: 3, scope: !272)
!287 = distinct !{!287, !275, !288, !93}
!288 = !DILocation(line: 161, column: 3, scope: !269)
!289 = !DILocation(line: 163, column: 10, scope: !290)
!290 = distinct !DILexicalBlock(scope: !212, file: !1, line: 163, column: 3)
!291 = !DILocation(line: 163, column: 8, scope: !290)
!292 = !DILocation(line: 163, column: 15, scope: !293)
!293 = distinct !DILexicalBlock(scope: !290, file: !1, line: 163, column: 3)
!294 = !DILocation(line: 163, column: 19, scope: !293)
!295 = !DILocation(line: 163, column: 17, scope: !293)
!296 = !DILocation(line: 163, column: 3, scope: !290)
!297 = !DILocation(line: 164, column: 20, scope: !298)
!298 = distinct !DILexicalBlock(scope: !293, file: !1, line: 163, column: 28)
!299 = !DILocation(line: 164, column: 10, scope: !298)
!300 = !DILocation(line: 164, column: 8, scope: !298)
!301 = !DILocation(line: 165, column: 12, scope: !302)
!302 = distinct !DILexicalBlock(scope: !298, file: !1, line: 165, column: 5)
!303 = !DILocation(line: 165, column: 10, scope: !302)
!304 = !DILocation(line: 165, column: 17, scope: !305)
!305 = distinct !DILexicalBlock(scope: !302, file: !1, line: 165, column: 5)
!306 = !DILocation(line: 165, column: 21, scope: !305)
!307 = !DILocation(line: 165, column: 19, scope: !305)
!308 = !DILocation(line: 165, column: 5, scope: !302)
!309 = !DILocation(line: 166, column: 16, scope: !310)
!310 = distinct !DILexicalBlock(scope: !305, file: !1, line: 165, column: 30)
!311 = !DILocation(line: 166, column: 15, scope: !310)
!312 = !DILocation(line: 166, column: 38, scope: !310)
!313 = !DILocation(line: 166, column: 28, scope: !310)
!314 = !DILocation(line: 166, column: 7, scope: !310)
!315 = !DILocation(line: 167, column: 14, scope: !316)
!316 = distinct !DILexicalBlock(scope: !310, file: !1, line: 167, column: 7)
!317 = !DILocation(line: 167, column: 12, scope: !316)
!318 = !DILocation(line: 167, column: 19, scope: !319)
!319 = distinct !DILexicalBlock(scope: !316, file: !1, line: 167, column: 7)
!320 = !DILocation(line: 167, column: 23, scope: !319)
!321 = !DILocation(line: 167, column: 21, scope: !319)
!322 = !DILocation(line: 167, column: 7, scope: !316)
!323 = !DILocation(line: 168, column: 9, scope: !324)
!324 = distinct !DILexicalBlock(scope: !319, file: !1, line: 167, column: 32)
!325 = !DILocation(line: 168, column: 12, scope: !324)
!326 = !DILocation(line: 168, column: 15, scope: !324)
!327 = !DILocation(line: 168, column: 18, scope: !324)
!328 = !DILocation(line: 168, column: 27, scope: !324)
!329 = !DILocation(line: 168, column: 23, scope: !324)
!330 = !DILocation(line: 169, column: 7, scope: !324)
!331 = !DILocation(line: 167, column: 28, scope: !319)
!332 = !DILocation(line: 167, column: 7, scope: !319)
!333 = distinct !{!333, !322, !334, !93}
!334 = !DILocation(line: 169, column: 7, scope: !316)
!335 = !DILocation(line: 170, column: 5, scope: !310)
!336 = !DILocation(line: 165, column: 26, scope: !305)
!337 = !DILocation(line: 165, column: 5, scope: !305)
!338 = distinct !{!338, !308, !339, !93}
!339 = !DILocation(line: 170, column: 5, scope: !302)
!340 = !DILocation(line: 171, column: 3, scope: !298)
!341 = !DILocation(line: 163, column: 24, scope: !293)
!342 = !DILocation(line: 163, column: 3, scope: !293)
!343 = distinct !{!343, !296, !344, !93}
!344 = !DILocation(line: 171, column: 3, scope: !290)
!345 = !DILocation(line: 172, column: 1, scope: !212)
!346 = distinct !DISubprogram(name: "ipow46", scope: !1, file: !1, line: 85, type: !347, scopeLine: 86, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!347 = !DISubroutineType(types: !348)
!348 = !{!4, !4, !15}
!349 = !DILocalVariable(name: "a", arg: 1, scope: !346, file: !1, line: 85, type: !4)
!350 = !DILocation(line: 85, column: 29, scope: !346)
!351 = !DILocalVariable(name: "exponent", arg: 2, scope: !346, file: !1, line: 85, type: !15)
!352 = !DILocation(line: 85, column: 36, scope: !346)
!353 = !DILocalVariable(name: "result", scope: !346, file: !1, line: 87, type: !4)
!354 = !DILocation(line: 87, column: 10, scope: !346)
!355 = !DILocalVariable(name: "dummy", scope: !346, file: !1, line: 87, type: !4)
!356 = !DILocation(line: 87, column: 18, scope: !346)
!357 = !DILocalVariable(name: "q", scope: !346, file: !1, line: 87, type: !4)
!358 = !DILocation(line: 87, column: 25, scope: !346)
!359 = !DILocalVariable(name: "r", scope: !346, file: !1, line: 87, type: !4)
!360 = !DILocation(line: 87, column: 28, scope: !346)
!361 = !DILocalVariable(name: "n", scope: !346, file: !1, line: 88, type: !15)
!362 = !DILocation(line: 88, column: 7, scope: !346)
!363 = !DILocalVariable(name: "n2", scope: !346, file: !1, line: 88, type: !15)
!364 = !DILocation(line: 88, column: 10, scope: !346)
!365 = !DILocation(line: 95, column: 10, scope: !346)
!366 = !DILocation(line: 96, column: 7, scope: !367)
!367 = distinct !DILexicalBlock(scope: !346, file: !1, line: 96, column: 7)
!368 = !DILocation(line: 96, column: 16, scope: !367)
!369 = !DILocation(line: 96, column: 7, scope: !346)
!370 = !DILocation(line: 96, column: 29, scope: !367)
!371 = !DILocation(line: 96, column: 22, scope: !367)
!372 = !DILocation(line: 97, column: 7, scope: !346)
!373 = !DILocation(line: 97, column: 5, scope: !346)
!374 = !DILocation(line: 98, column: 5, scope: !346)
!375 = !DILocation(line: 99, column: 7, scope: !346)
!376 = !DILocation(line: 99, column: 5, scope: !346)
!377 = !DILocation(line: 101, column: 3, scope: !346)
!378 = !DILocation(line: 101, column: 10, scope: !346)
!379 = !DILocation(line: 101, column: 12, scope: !346)
!380 = !DILocation(line: 102, column: 10, scope: !381)
!381 = distinct !DILexicalBlock(scope: !346, file: !1, line: 101, column: 17)
!382 = !DILocation(line: 102, column: 12, scope: !381)
!383 = !DILocation(line: 102, column: 8, scope: !381)
!384 = !DILocation(line: 103, column: 9, scope: !385)
!385 = distinct !DILexicalBlock(scope: !381, file: !1, line: 103, column: 9)
!386 = !DILocation(line: 103, column: 12, scope: !385)
!387 = !DILocation(line: 103, column: 19, scope: !385)
!388 = !DILocation(line: 103, column: 16, scope: !385)
!389 = !DILocation(line: 103, column: 9, scope: !381)
!390 = !DILocation(line: 104, column: 26, scope: !391)
!391 = distinct !DILexicalBlock(scope: !385, file: !1, line: 103, column: 22)
!392 = !DILocation(line: 104, column: 15, scope: !391)
!393 = !DILocation(line: 104, column: 13, scope: !391)
!394 = !DILocation(line: 105, column: 11, scope: !391)
!395 = !DILocation(line: 105, column: 9, scope: !391)
!396 = !DILocation(line: 106, column: 5, scope: !391)
!397 = !DILocation(line: 107, column: 26, scope: !398)
!398 = distinct !DILexicalBlock(scope: !385, file: !1, line: 106, column: 12)
!399 = !DILocation(line: 107, column: 15, scope: !398)
!400 = !DILocation(line: 107, column: 13, scope: !398)
!401 = !DILocation(line: 108, column: 11, scope: !398)
!402 = !DILocation(line: 108, column: 12, scope: !398)
!403 = !DILocation(line: 108, column: 9, scope: !398)
!404 = distinct !{!404, !377, !405, !93}
!405 = !DILocation(line: 110, column: 3, scope: !346)
!406 = !DILocation(line: 111, column: 22, scope: !346)
!407 = !DILocation(line: 111, column: 11, scope: !346)
!408 = !DILocation(line: 111, column: 9, scope: !346)
!409 = !DILocation(line: 112, column: 12, scope: !346)
!410 = !DILocation(line: 112, column: 10, scope: !346)
!411 = !DILocation(line: 113, column: 10, scope: !346)
!412 = !DILocation(line: 113, column: 3, scope: !346)
!413 = !DILocation(line: 114, column: 1, scope: !346)
!414 = distinct !DISubprogram(name: "evolve", scope: !1, file: !1, line: 175, type: !415, scopeLine: 178, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!415 = !DISubroutineType(types: !416)
!416 = !{null, !15, !15, !15, !142, !142, !417}
!417 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !418, size: 64)
!418 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, elements: !144)
!419 = !DILocalVariable(name: "nx", arg: 1, scope: !414, file: !1, line: 175, type: !15)
!420 = !DILocation(line: 175, column: 17, scope: !414)
!421 = !DILocalVariable(name: "ny", arg: 2, scope: !414, file: !1, line: 175, type: !15)
!422 = !DILocation(line: 175, column: 25, scope: !414)
!423 = !DILocalVariable(name: "nz", arg: 3, scope: !414, file: !1, line: 175, type: !15)
!424 = !DILocation(line: 175, column: 33, scope: !414)
!425 = !DILocalVariable(name: "x", arg: 4, scope: !414, file: !1, line: 176, type: !142)
!426 = !DILocation(line: 176, column: 22, scope: !414)
!427 = !DILocalVariable(name: "y", arg: 5, scope: !414, file: !1, line: 176, type: !142)
!428 = !DILocation(line: 176, column: 48, scope: !414)
!429 = !DILocalVariable(name: "twiddle", arg: 6, scope: !414, file: !1, line: 177, type: !417)
!430 = !DILocation(line: 177, column: 20, scope: !414)
!431 = !DILocation(line: 176, column: 24, scope: !414)
!432 = !DILocation(line: 176, column: 28, scope: !414)
!433 = !DILocation(line: 176, column: 32, scope: !414)
!434 = !DILocation(line: 176, column: 34, scope: !414)
!435 = !DILocation(line: 176, column: 50, scope: !414)
!436 = !DILocation(line: 176, column: 54, scope: !414)
!437 = !DILocation(line: 176, column: 58, scope: !414)
!438 = !DILocation(line: 176, column: 60, scope: !414)
!439 = !DILocation(line: 177, column: 28, scope: !414)
!440 = !DILocation(line: 177, column: 32, scope: !414)
!441 = !DILocation(line: 177, column: 36, scope: !414)
!442 = !DILocation(line: 177, column: 38, scope: !414)
!443 = !DILocalVariable(name: "i", scope: !414, file: !1, line: 179, type: !15)
!444 = !DILocation(line: 179, column: 7, scope: !414)
!445 = !DILocalVariable(name: "j", scope: !414, file: !1, line: 179, type: !15)
!446 = !DILocation(line: 179, column: 10, scope: !414)
!447 = !DILocalVariable(name: "k", scope: !414, file: !1, line: 179, type: !15)
!448 = !DILocation(line: 179, column: 13, scope: !414)
!449 = !DILocation(line: 180, column: 10, scope: !450)
!450 = distinct !DILexicalBlock(scope: !414, file: !1, line: 180, column: 3)
!451 = !DILocation(line: 180, column: 8, scope: !450)
!452 = !DILocation(line: 180, column: 15, scope: !453)
!453 = distinct !DILexicalBlock(scope: !450, file: !1, line: 180, column: 3)
!454 = !DILocation(line: 180, column: 19, scope: !453)
!455 = !DILocation(line: 180, column: 17, scope: !453)
!456 = !DILocation(line: 180, column: 3, scope: !450)
!457 = !DILocation(line: 181, column: 12, scope: !458)
!458 = distinct !DILexicalBlock(scope: !459, file: !1, line: 181, column: 5)
!459 = distinct !DILexicalBlock(scope: !453, file: !1, line: 180, column: 28)
!460 = !DILocation(line: 181, column: 10, scope: !458)
!461 = !DILocation(line: 181, column: 17, scope: !462)
!462 = distinct !DILexicalBlock(scope: !458, file: !1, line: 181, column: 5)
!463 = !DILocation(line: 181, column: 21, scope: !462)
!464 = !DILocation(line: 181, column: 19, scope: !462)
!465 = !DILocation(line: 181, column: 5, scope: !458)
!466 = !DILocation(line: 182, column: 14, scope: !467)
!467 = distinct !DILexicalBlock(scope: !468, file: !1, line: 182, column: 7)
!468 = distinct !DILexicalBlock(scope: !462, file: !1, line: 181, column: 30)
!469 = !DILocation(line: 182, column: 12, scope: !467)
!470 = !DILocation(line: 182, column: 19, scope: !471)
!471 = distinct !DILexicalBlock(scope: !467, file: !1, line: 182, column: 7)
!472 = !DILocation(line: 182, column: 23, scope: !471)
!473 = !DILocation(line: 182, column: 21, scope: !471)
!474 = !DILocation(line: 182, column: 7, scope: !467)
!475 = !DILocation(line: 183, column: 9, scope: !476)
!476 = distinct !DILexicalBlock(scope: !471, file: !1, line: 182, column: 32)
!477 = !DILocation(line: 183, column: 11, scope: !476)
!478 = !DILocation(line: 183, column: 14, scope: !476)
!479 = !DILocation(line: 183, column: 17, scope: !476)
!480 = !DILocation(line: 183, column: 22, scope: !476)
!481 = !DILocation(line: 184, column: 9, scope: !476)
!482 = !DILocation(line: 184, column: 11, scope: !476)
!483 = !DILocation(line: 184, column: 14, scope: !476)
!484 = !DILocation(line: 184, column: 17, scope: !476)
!485 = !DILocation(line: 184, column: 22, scope: !476)
!486 = !DILocation(line: 184, column: 24, scope: !476)
!487 = !DILocation(line: 184, column: 27, scope: !476)
!488 = !DILocation(line: 184, column: 30, scope: !476)
!489 = !DILocation(line: 185, column: 7, scope: !476)
!490 = !DILocation(line: 182, column: 28, scope: !471)
!491 = !DILocation(line: 182, column: 7, scope: !471)
!492 = distinct !{!492, !474, !493, !93}
!493 = !DILocation(line: 185, column: 7, scope: !467)
!494 = !DILocation(line: 186, column: 5, scope: !468)
!495 = !DILocation(line: 181, column: 26, scope: !462)
!496 = !DILocation(line: 181, column: 5, scope: !462)
!497 = distinct !{!497, !465, !498, !93}
!498 = !DILocation(line: 186, column: 5, scope: !458)
!499 = !DILocation(line: 187, column: 3, scope: !459)
!500 = !DILocation(line: 180, column: 24, scope: !453)
!501 = !DILocation(line: 180, column: 3, scope: !453)
!502 = distinct !{!502, !456, !503, !93}
!503 = !DILocation(line: 187, column: 3, scope: !450)
!504 = !DILocation(line: 188, column: 1, scope: !414)
