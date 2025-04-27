; ModuleID = 'randdp.c'
source_filename = "randdp.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @randlc(double* %x, double %a) #0 !dbg !11 {
entry:
  %x.addr = alloca double*, align 8
  %a.addr = alloca double, align 8
  %r23 = alloca double, align 8
  %r46 = alloca double, align 8
  %t23 = alloca double, align 8
  %t46 = alloca double, align 8
  %t1 = alloca double, align 8
  %t2 = alloca double, align 8
  %t3 = alloca double, align 8
  %t4 = alloca double, align 8
  %a1 = alloca double, align 8
  %a2 = alloca double, align 8
  %x1 = alloca double, align 8
  %x2 = alloca double, align 8
  %z = alloca double, align 8
  %r = alloca double, align 8
  store double* %x, double** %x.addr, align 8
  call void @llvm.dbg.declare(metadata double** %x.addr, metadata !16, metadata !DIExpression()), !dbg !17
  store double %a, double* %a.addr, align 8
  call void @llvm.dbg.declare(metadata double* %a.addr, metadata !18, metadata !DIExpression()), !dbg !19
  call void @llvm.dbg.declare(metadata double* %r23, metadata !20, metadata !DIExpression()), !dbg !22
  store double 0x3E80000000000000, double* %r23, align 8, !dbg !22
  call void @llvm.dbg.declare(metadata double* %r46, metadata !23, metadata !DIExpression()), !dbg !24
  store double 0x3D10000000000000, double* %r46, align 8, !dbg !24
  call void @llvm.dbg.declare(metadata double* %t23, metadata !25, metadata !DIExpression()), !dbg !26
  store double 0x4160000000000000, double* %t23, align 8, !dbg !26
  call void @llvm.dbg.declare(metadata double* %t46, metadata !27, metadata !DIExpression()), !dbg !28
  store double 0x42D0000000000000, double* %t46, align 8, !dbg !28
  call void @llvm.dbg.declare(metadata double* %t1, metadata !29, metadata !DIExpression()), !dbg !30
  call void @llvm.dbg.declare(metadata double* %t2, metadata !31, metadata !DIExpression()), !dbg !32
  call void @llvm.dbg.declare(metadata double* %t3, metadata !33, metadata !DIExpression()), !dbg !34
  call void @llvm.dbg.declare(metadata double* %t4, metadata !35, metadata !DIExpression()), !dbg !36
  call void @llvm.dbg.declare(metadata double* %a1, metadata !37, metadata !DIExpression()), !dbg !38
  call void @llvm.dbg.declare(metadata double* %a2, metadata !39, metadata !DIExpression()), !dbg !40
  call void @llvm.dbg.declare(metadata double* %x1, metadata !41, metadata !DIExpression()), !dbg !42
  call void @llvm.dbg.declare(metadata double* %x2, metadata !43, metadata !DIExpression()), !dbg !44
  call void @llvm.dbg.declare(metadata double* %z, metadata !45, metadata !DIExpression()), !dbg !46
  call void @llvm.dbg.declare(metadata double* %r, metadata !47, metadata !DIExpression()), !dbg !48
  %0 = load double, double* %a.addr, align 8, !dbg !49
  %mul = fmul double 0x3E80000000000000, %0, !dbg !50
  store double %mul, double* %t1, align 8, !dbg !51
  %1 = load double, double* %t1, align 8, !dbg !52
  %conv = fptosi double %1 to i32, !dbg !53
  %conv1 = sitofp i32 %conv to double, !dbg !53
  store double %conv1, double* %a1, align 8, !dbg !54
  %2 = load double, double* %a.addr, align 8, !dbg !55
  %3 = load double, double* %a1, align 8, !dbg !56
  %mul2 = fmul double 0x4160000000000000, %3, !dbg !57
  %sub = fsub double %2, %mul2, !dbg !58
  store double %sub, double* %a2, align 8, !dbg !59
  %4 = load double*, double** %x.addr, align 8, !dbg !60
  %5 = load double, double* %4, align 8, !dbg !61
  %mul3 = fmul double 0x3E80000000000000, %5, !dbg !62
  store double %mul3, double* %t1, align 8, !dbg !63
  %6 = load double, double* %t1, align 8, !dbg !64
  %conv4 = fptosi double %6 to i32, !dbg !65
  %conv5 = sitofp i32 %conv4 to double, !dbg !65
  store double %conv5, double* %x1, align 8, !dbg !66
  %7 = load double*, double** %x.addr, align 8, !dbg !67
  %8 = load double, double* %7, align 8, !dbg !68
  %9 = load double, double* %x1, align 8, !dbg !69
  %mul6 = fmul double 0x4160000000000000, %9, !dbg !70
  %sub7 = fsub double %8, %mul6, !dbg !71
  store double %sub7, double* %x2, align 8, !dbg !72
  %10 = load double, double* %a1, align 8, !dbg !73
  %11 = load double, double* %x2, align 8, !dbg !74
  %mul8 = fmul double %10, %11, !dbg !75
  %12 = load double, double* %a2, align 8, !dbg !76
  %13 = load double, double* %x1, align 8, !dbg !77
  %mul9 = fmul double %12, %13, !dbg !78
  %add = fadd double %mul8, %mul9, !dbg !79
  store double %add, double* %t1, align 8, !dbg !80
  %14 = load double, double* %t1, align 8, !dbg !81
  %mul10 = fmul double 0x3E80000000000000, %14, !dbg !82
  %conv11 = fptosi double %mul10 to i32, !dbg !83
  %conv12 = sitofp i32 %conv11 to double, !dbg !83
  store double %conv12, double* %t2, align 8, !dbg !84
  %15 = load double, double* %t1, align 8, !dbg !85
  %16 = load double, double* %t2, align 8, !dbg !86
  %mul13 = fmul double 0x4160000000000000, %16, !dbg !87
  %sub14 = fsub double %15, %mul13, !dbg !88
  store double %sub14, double* %z, align 8, !dbg !89
  %17 = load double, double* %z, align 8, !dbg !90
  %mul15 = fmul double 0x4160000000000000, %17, !dbg !91
  %18 = load double, double* %a2, align 8, !dbg !92
  %19 = load double, double* %x2, align 8, !dbg !93
  %mul16 = fmul double %18, %19, !dbg !94
  %add17 = fadd double %mul15, %mul16, !dbg !95
  store double %add17, double* %t3, align 8, !dbg !96
  %20 = load double, double* %t3, align 8, !dbg !97
  %mul18 = fmul double 0x3D10000000000000, %20, !dbg !98
  %conv19 = fptosi double %mul18 to i32, !dbg !99
  %conv20 = sitofp i32 %conv19 to double, !dbg !99
  store double %conv20, double* %t4, align 8, !dbg !100
  %21 = load double, double* %t3, align 8, !dbg !101
  %22 = load double, double* %t4, align 8, !dbg !102
  %mul21 = fmul double 0x42D0000000000000, %22, !dbg !103
  %sub22 = fsub double %21, %mul21, !dbg !104
  %23 = load double*, double** %x.addr, align 8, !dbg !105
  store double %sub22, double* %23, align 8, !dbg !106
  %24 = load double*, double** %x.addr, align 8, !dbg !107
  %25 = load double, double* %24, align 8, !dbg !108
  %mul23 = fmul double 0x3D10000000000000, %25, !dbg !109
  store double %mul23, double* %r, align 8, !dbg !110
  %26 = load double, double* %r, align 8, !dbg !111
  ret double %26, !dbg !112
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vranlc(i32 %n, double* %x, double %a, double* %y) #0 !dbg !113 {
entry:
  %n.addr = alloca i32, align 4
  %x.addr = alloca double*, align 8
  %a.addr = alloca double, align 8
  %y.addr = alloca double*, align 8
  %r23 = alloca double, align 8
  %r46 = alloca double, align 8
  %t23 = alloca double, align 8
  %t46 = alloca double, align 8
  %t1 = alloca double, align 8
  %t2 = alloca double, align 8
  %t3 = alloca double, align 8
  %t4 = alloca double, align 8
  %a1 = alloca double, align 8
  %a2 = alloca double, align 8
  %x1 = alloca double, align 8
  %x2 = alloca double, align 8
  %z = alloca double, align 8
  %i = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !116, metadata !DIExpression()), !dbg !117
  store double* %x, double** %x.addr, align 8
  call void @llvm.dbg.declare(metadata double** %x.addr, metadata !118, metadata !DIExpression()), !dbg !119
  store double %a, double* %a.addr, align 8
  call void @llvm.dbg.declare(metadata double* %a.addr, metadata !120, metadata !DIExpression()), !dbg !121
  store double* %y, double** %y.addr, align 8
  call void @llvm.dbg.declare(metadata double** %y.addr, metadata !122, metadata !DIExpression()), !dbg !123
  call void @llvm.dbg.declare(metadata double* %r23, metadata !124, metadata !DIExpression()), !dbg !125
  store double 0x3E80000000000000, double* %r23, align 8, !dbg !125
  call void @llvm.dbg.declare(metadata double* %r46, metadata !126, metadata !DIExpression()), !dbg !127
  store double 0x3D10000000000000, double* %r46, align 8, !dbg !127
  call void @llvm.dbg.declare(metadata double* %t23, metadata !128, metadata !DIExpression()), !dbg !129
  store double 0x4160000000000000, double* %t23, align 8, !dbg !129
  call void @llvm.dbg.declare(metadata double* %t46, metadata !130, metadata !DIExpression()), !dbg !131
  store double 0x42D0000000000000, double* %t46, align 8, !dbg !131
  call void @llvm.dbg.declare(metadata double* %t1, metadata !132, metadata !DIExpression()), !dbg !133
  call void @llvm.dbg.declare(metadata double* %t2, metadata !134, metadata !DIExpression()), !dbg !135
  call void @llvm.dbg.declare(metadata double* %t3, metadata !136, metadata !DIExpression()), !dbg !137
  call void @llvm.dbg.declare(metadata double* %t4, metadata !138, metadata !DIExpression()), !dbg !139
  call void @llvm.dbg.declare(metadata double* %a1, metadata !140, metadata !DIExpression()), !dbg !141
  call void @llvm.dbg.declare(metadata double* %a2, metadata !142, metadata !DIExpression()), !dbg !143
  call void @llvm.dbg.declare(metadata double* %x1, metadata !144, metadata !DIExpression()), !dbg !145
  call void @llvm.dbg.declare(metadata double* %x2, metadata !146, metadata !DIExpression()), !dbg !147
  call void @llvm.dbg.declare(metadata double* %z, metadata !148, metadata !DIExpression()), !dbg !149
  call void @llvm.dbg.declare(metadata i32* %i, metadata !150, metadata !DIExpression()), !dbg !151
  %0 = load double, double* %a.addr, align 8, !dbg !152
  %mul = fmul double 0x3E80000000000000, %0, !dbg !153
  store double %mul, double* %t1, align 8, !dbg !154
  %1 = load double, double* %t1, align 8, !dbg !155
  %conv = fptosi double %1 to i32, !dbg !156
  %conv1 = sitofp i32 %conv to double, !dbg !156
  store double %conv1, double* %a1, align 8, !dbg !157
  %2 = load double, double* %a.addr, align 8, !dbg !158
  %3 = load double, double* %a1, align 8, !dbg !159
  %mul2 = fmul double 0x4160000000000000, %3, !dbg !160
  %sub = fsub double %2, %mul2, !dbg !161
  store double %sub, double* %a2, align 8, !dbg !162
  store i32 0, i32* %i, align 4, !dbg !163
  br label %for.cond, !dbg !165

for.cond:                                         ; preds = %for.inc, %entry
  %4 = load i32, i32* %i, align 4, !dbg !166
  %5 = load i32, i32* %n.addr, align 4, !dbg !168
  %cmp = icmp slt i32 %4, %5, !dbg !169
  br i1 %cmp, label %for.body, label %for.end, !dbg !170

for.body:                                         ; preds = %for.cond
  %6 = load double*, double** %x.addr, align 8, !dbg !171
  %7 = load double, double* %6, align 8, !dbg !173
  %mul4 = fmul double 0x3E80000000000000, %7, !dbg !174
  store double %mul4, double* %t1, align 8, !dbg !175
  %8 = load double, double* %t1, align 8, !dbg !176
  %conv5 = fptosi double %8 to i32, !dbg !177
  %conv6 = sitofp i32 %conv5 to double, !dbg !177
  store double %conv6, double* %x1, align 8, !dbg !178
  %9 = load double*, double** %x.addr, align 8, !dbg !179
  %10 = load double, double* %9, align 8, !dbg !180
  %11 = load double, double* %x1, align 8, !dbg !181
  %mul7 = fmul double 0x4160000000000000, %11, !dbg !182
  %sub8 = fsub double %10, %mul7, !dbg !183
  store double %sub8, double* %x2, align 8, !dbg !184
  %12 = load double, double* %a1, align 8, !dbg !185
  %13 = load double, double* %x2, align 8, !dbg !186
  %mul9 = fmul double %12, %13, !dbg !187
  %14 = load double, double* %a2, align 8, !dbg !188
  %15 = load double, double* %x1, align 8, !dbg !189
  %mul10 = fmul double %14, %15, !dbg !190
  %add = fadd double %mul9, %mul10, !dbg !191
  store double %add, double* %t1, align 8, !dbg !192
  %16 = load double, double* %t1, align 8, !dbg !193
  %mul11 = fmul double 0x3E80000000000000, %16, !dbg !194
  %conv12 = fptosi double %mul11 to i32, !dbg !195
  %conv13 = sitofp i32 %conv12 to double, !dbg !195
  store double %conv13, double* %t2, align 8, !dbg !196
  %17 = load double, double* %t1, align 8, !dbg !197
  %18 = load double, double* %t2, align 8, !dbg !198
  %mul14 = fmul double 0x4160000000000000, %18, !dbg !199
  %sub15 = fsub double %17, %mul14, !dbg !200
  store double %sub15, double* %z, align 8, !dbg !201
  %19 = load double, double* %z, align 8, !dbg !202
  %mul16 = fmul double 0x4160000000000000, %19, !dbg !203
  %20 = load double, double* %a2, align 8, !dbg !204
  %21 = load double, double* %x2, align 8, !dbg !205
  %mul17 = fmul double %20, %21, !dbg !206
  %add18 = fadd double %mul16, %mul17, !dbg !207
  store double %add18, double* %t3, align 8, !dbg !208
  %22 = load double, double* %t3, align 8, !dbg !209
  %mul19 = fmul double 0x3D10000000000000, %22, !dbg !210
  %conv20 = fptosi double %mul19 to i32, !dbg !211
  %conv21 = sitofp i32 %conv20 to double, !dbg !211
  store double %conv21, double* %t4, align 8, !dbg !212
  %23 = load double, double* %t3, align 8, !dbg !213
  %24 = load double, double* %t4, align 8, !dbg !214
  %mul22 = fmul double 0x42D0000000000000, %24, !dbg !215
  %sub23 = fsub double %23, %mul22, !dbg !216
  %25 = load double*, double** %x.addr, align 8, !dbg !217
  store double %sub23, double* %25, align 8, !dbg !218
  %26 = load double*, double** %x.addr, align 8, !dbg !219
  %27 = load double, double* %26, align 8, !dbg !220
  %mul24 = fmul double 0x3D10000000000000, %27, !dbg !221
  %28 = load double*, double** %y.addr, align 8, !dbg !222
  %29 = load i32, i32* %i, align 4, !dbg !223
  %idxprom = sext i32 %29 to i64, !dbg !222
  %arrayidx = getelementptr inbounds double, double* %28, i64 %idxprom, !dbg !222
  store double %mul24, double* %arrayidx, align 8, !dbg !224
  br label %for.inc, !dbg !225

for.inc:                                          ; preds = %for.body
  %30 = load i32, i32* %i, align 4, !dbg !226
  %inc = add nsw i32 %30, 1, !dbg !226
  store i32 %inc, i32* %i, align 4, !dbg !226
  br label %for.cond, !dbg !227, !llvm.loop !228

for.end:                                          ; preds = %for.cond
  ret void, !dbg !231
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7, !8, !9}
!llvm.ident = !{!10}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, debugInfoForProfiling: true, nameTableKind: None)
!1 = !DIFile(filename: "randdp.c", directory: "/workspace/LLVM-Checker/test/benchmarks/NPB/FT")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!5 = !{i32 7, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{i32 7, !"uwtable", i32 1}
!9 = !{i32 7, !"frame-pointer", i32 2}
!10 = !{!"clang version 13.0.1"}
!11 = distinct !DISubprogram(name: "randlc", scope: !1, file: !1, line: 4, type: !12, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!12 = !DISubroutineType(types: !13)
!13 = !{!14, !15, !14}
!14 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!16 = !DILocalVariable(name: "x", arg: 1, scope: !11, file: !1, line: 4, type: !15)
!17 = !DILocation(line: 4, column: 24, scope: !11)
!18 = !DILocalVariable(name: "a", arg: 2, scope: !11, file: !1, line: 4, type: !14)
!19 = !DILocation(line: 4, column: 34, scope: !11)
!20 = !DILocalVariable(name: "r23", scope: !11, file: !1, line: 36, type: !21)
!21 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !14)
!22 = !DILocation(line: 36, column: 16, scope: !11)
!23 = !DILocalVariable(name: "r46", scope: !11, file: !1, line: 37, type: !21)
!24 = !DILocation(line: 37, column: 16, scope: !11)
!25 = !DILocalVariable(name: "t23", scope: !11, file: !1, line: 38, type: !21)
!26 = !DILocation(line: 38, column: 16, scope: !11)
!27 = !DILocalVariable(name: "t46", scope: !11, file: !1, line: 39, type: !21)
!28 = !DILocation(line: 39, column: 16, scope: !11)
!29 = !DILocalVariable(name: "t1", scope: !11, file: !1, line: 41, type: !14)
!30 = !DILocation(line: 41, column: 10, scope: !11)
!31 = !DILocalVariable(name: "t2", scope: !11, file: !1, line: 41, type: !14)
!32 = !DILocation(line: 41, column: 14, scope: !11)
!33 = !DILocalVariable(name: "t3", scope: !11, file: !1, line: 41, type: !14)
!34 = !DILocation(line: 41, column: 18, scope: !11)
!35 = !DILocalVariable(name: "t4", scope: !11, file: !1, line: 41, type: !14)
!36 = !DILocation(line: 41, column: 22, scope: !11)
!37 = !DILocalVariable(name: "a1", scope: !11, file: !1, line: 41, type: !14)
!38 = !DILocation(line: 41, column: 26, scope: !11)
!39 = !DILocalVariable(name: "a2", scope: !11, file: !1, line: 41, type: !14)
!40 = !DILocation(line: 41, column: 30, scope: !11)
!41 = !DILocalVariable(name: "x1", scope: !11, file: !1, line: 41, type: !14)
!42 = !DILocation(line: 41, column: 34, scope: !11)
!43 = !DILocalVariable(name: "x2", scope: !11, file: !1, line: 41, type: !14)
!44 = !DILocation(line: 41, column: 38, scope: !11)
!45 = !DILocalVariable(name: "z", scope: !11, file: !1, line: 41, type: !14)
!46 = !DILocation(line: 41, column: 42, scope: !11)
!47 = !DILocalVariable(name: "r", scope: !11, file: !1, line: 42, type: !14)
!48 = !DILocation(line: 42, column: 10, scope: !11)
!49 = !DILocation(line: 47, column: 14, scope: !11)
!50 = !DILocation(line: 47, column: 12, scope: !11)
!51 = !DILocation(line: 47, column: 6, scope: !11)
!52 = !DILocation(line: 48, column: 14, scope: !11)
!53 = !DILocation(line: 48, column: 8, scope: !11)
!54 = !DILocation(line: 48, column: 6, scope: !11)
!55 = !DILocation(line: 49, column: 8, scope: !11)
!56 = !DILocation(line: 49, column: 18, scope: !11)
!57 = !DILocation(line: 49, column: 16, scope: !11)
!58 = !DILocation(line: 49, column: 10, scope: !11)
!59 = !DILocation(line: 49, column: 6, scope: !11)
!60 = !DILocation(line: 56, column: 16, scope: !11)
!61 = !DILocation(line: 56, column: 15, scope: !11)
!62 = !DILocation(line: 56, column: 12, scope: !11)
!63 = !DILocation(line: 56, column: 6, scope: !11)
!64 = !DILocation(line: 57, column: 14, scope: !11)
!65 = !DILocation(line: 57, column: 8, scope: !11)
!66 = !DILocation(line: 57, column: 6, scope: !11)
!67 = !DILocation(line: 58, column: 9, scope: !11)
!68 = !DILocation(line: 58, column: 8, scope: !11)
!69 = !DILocation(line: 58, column: 19, scope: !11)
!70 = !DILocation(line: 58, column: 17, scope: !11)
!71 = !DILocation(line: 58, column: 11, scope: !11)
!72 = !DILocation(line: 58, column: 6, scope: !11)
!73 = !DILocation(line: 59, column: 8, scope: !11)
!74 = !DILocation(line: 59, column: 13, scope: !11)
!75 = !DILocation(line: 59, column: 11, scope: !11)
!76 = !DILocation(line: 59, column: 18, scope: !11)
!77 = !DILocation(line: 59, column: 23, scope: !11)
!78 = !DILocation(line: 59, column: 21, scope: !11)
!79 = !DILocation(line: 59, column: 16, scope: !11)
!80 = !DILocation(line: 59, column: 6, scope: !11)
!81 = !DILocation(line: 60, column: 21, scope: !11)
!82 = !DILocation(line: 60, column: 19, scope: !11)
!83 = !DILocation(line: 60, column: 8, scope: !11)
!84 = !DILocation(line: 60, column: 6, scope: !11)
!85 = !DILocation(line: 61, column: 7, scope: !11)
!86 = !DILocation(line: 61, column: 18, scope: !11)
!87 = !DILocation(line: 61, column: 16, scope: !11)
!88 = !DILocation(line: 61, column: 10, scope: !11)
!89 = !DILocation(line: 61, column: 5, scope: !11)
!90 = !DILocation(line: 62, column: 14, scope: !11)
!91 = !DILocation(line: 62, column: 12, scope: !11)
!92 = !DILocation(line: 62, column: 18, scope: !11)
!93 = !DILocation(line: 62, column: 23, scope: !11)
!94 = !DILocation(line: 62, column: 21, scope: !11)
!95 = !DILocation(line: 62, column: 16, scope: !11)
!96 = !DILocation(line: 62, column: 6, scope: !11)
!97 = !DILocation(line: 63, column: 21, scope: !11)
!98 = !DILocation(line: 63, column: 19, scope: !11)
!99 = !DILocation(line: 63, column: 8, scope: !11)
!100 = !DILocation(line: 63, column: 6, scope: !11)
!101 = !DILocation(line: 64, column: 8, scope: !11)
!102 = !DILocation(line: 64, column: 19, scope: !11)
!103 = !DILocation(line: 64, column: 17, scope: !11)
!104 = !DILocation(line: 64, column: 11, scope: !11)
!105 = !DILocation(line: 64, column: 4, scope: !11)
!106 = !DILocation(line: 64, column: 6, scope: !11)
!107 = !DILocation(line: 65, column: 15, scope: !11)
!108 = !DILocation(line: 65, column: 14, scope: !11)
!109 = !DILocation(line: 65, column: 11, scope: !11)
!110 = !DILocation(line: 65, column: 5, scope: !11)
!111 = !DILocation(line: 67, column: 10, scope: !11)
!112 = !DILocation(line: 67, column: 3, scope: !11)
!113 = distinct !DISubprogram(name: "vranlc", scope: !1, file: !1, line: 71, type: !114, scopeLine: 72, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!114 = !DISubroutineType(types: !115)
!115 = !{null, !4, !15, !14, !15}
!116 = !DILocalVariable(name: "n", arg: 1, scope: !113, file: !1, line: 71, type: !4)
!117 = !DILocation(line: 71, column: 18, scope: !113)
!118 = !DILocalVariable(name: "x", arg: 2, scope: !113, file: !1, line: 71, type: !15)
!119 = !DILocation(line: 71, column: 29, scope: !113)
!120 = !DILocalVariable(name: "a", arg: 3, scope: !113, file: !1, line: 71, type: !14)
!121 = !DILocation(line: 71, column: 39, scope: !113)
!122 = !DILocalVariable(name: "y", arg: 4, scope: !113, file: !1, line: 71, type: !15)
!123 = !DILocation(line: 71, column: 49, scope: !113)
!124 = !DILocalVariable(name: "r23", scope: !113, file: !1, line: 103, type: !21)
!125 = !DILocation(line: 103, column: 16, scope: !113)
!126 = !DILocalVariable(name: "r46", scope: !113, file: !1, line: 104, type: !21)
!127 = !DILocation(line: 104, column: 16, scope: !113)
!128 = !DILocalVariable(name: "t23", scope: !113, file: !1, line: 105, type: !21)
!129 = !DILocation(line: 105, column: 16, scope: !113)
!130 = !DILocalVariable(name: "t46", scope: !113, file: !1, line: 106, type: !21)
!131 = !DILocation(line: 106, column: 16, scope: !113)
!132 = !DILocalVariable(name: "t1", scope: !113, file: !1, line: 108, type: !14)
!133 = !DILocation(line: 108, column: 10, scope: !113)
!134 = !DILocalVariable(name: "t2", scope: !113, file: !1, line: 108, type: !14)
!135 = !DILocation(line: 108, column: 14, scope: !113)
!136 = !DILocalVariable(name: "t3", scope: !113, file: !1, line: 108, type: !14)
!137 = !DILocation(line: 108, column: 18, scope: !113)
!138 = !DILocalVariable(name: "t4", scope: !113, file: !1, line: 108, type: !14)
!139 = !DILocation(line: 108, column: 22, scope: !113)
!140 = !DILocalVariable(name: "a1", scope: !113, file: !1, line: 108, type: !14)
!141 = !DILocation(line: 108, column: 26, scope: !113)
!142 = !DILocalVariable(name: "a2", scope: !113, file: !1, line: 108, type: !14)
!143 = !DILocation(line: 108, column: 30, scope: !113)
!144 = !DILocalVariable(name: "x1", scope: !113, file: !1, line: 108, type: !14)
!145 = !DILocation(line: 108, column: 34, scope: !113)
!146 = !DILocalVariable(name: "x2", scope: !113, file: !1, line: 108, type: !14)
!147 = !DILocation(line: 108, column: 38, scope: !113)
!148 = !DILocalVariable(name: "z", scope: !113, file: !1, line: 108, type: !14)
!149 = !DILocation(line: 108, column: 42, scope: !113)
!150 = !DILocalVariable(name: "i", scope: !113, file: !1, line: 110, type: !4)
!151 = !DILocation(line: 110, column: 7, scope: !113)
!152 = !DILocation(line: 115, column: 14, scope: !113)
!153 = !DILocation(line: 115, column: 12, scope: !113)
!154 = !DILocation(line: 115, column: 6, scope: !113)
!155 = !DILocation(line: 116, column: 14, scope: !113)
!156 = !DILocation(line: 116, column: 8, scope: !113)
!157 = !DILocation(line: 116, column: 6, scope: !113)
!158 = !DILocation(line: 117, column: 8, scope: !113)
!159 = !DILocation(line: 117, column: 18, scope: !113)
!160 = !DILocation(line: 117, column: 16, scope: !113)
!161 = !DILocation(line: 117, column: 10, scope: !113)
!162 = !DILocation(line: 117, column: 6, scope: !113)
!163 = !DILocation(line: 122, column: 11, scope: !164)
!164 = distinct !DILexicalBlock(scope: !113, file: !1, line: 122, column: 3)
!165 = !DILocation(line: 122, column: 9, scope: !164)
!166 = !DILocation(line: 122, column: 16, scope: !167)
!167 = distinct !DILexicalBlock(scope: !164, file: !1, line: 122, column: 3)
!168 = !DILocation(line: 122, column: 20, scope: !167)
!169 = !DILocation(line: 122, column: 18, scope: !167)
!170 = !DILocation(line: 122, column: 3, scope: !164)
!171 = !DILocation(line: 128, column: 18, scope: !172)
!172 = distinct !DILexicalBlock(scope: !167, file: !1, line: 122, column: 29)
!173 = !DILocation(line: 128, column: 17, scope: !172)
!174 = !DILocation(line: 128, column: 14, scope: !172)
!175 = !DILocation(line: 128, column: 8, scope: !172)
!176 = !DILocation(line: 129, column: 16, scope: !172)
!177 = !DILocation(line: 129, column: 10, scope: !172)
!178 = !DILocation(line: 129, column: 8, scope: !172)
!179 = !DILocation(line: 130, column: 11, scope: !172)
!180 = !DILocation(line: 130, column: 10, scope: !172)
!181 = !DILocation(line: 130, column: 21, scope: !172)
!182 = !DILocation(line: 130, column: 19, scope: !172)
!183 = !DILocation(line: 130, column: 13, scope: !172)
!184 = !DILocation(line: 130, column: 8, scope: !172)
!185 = !DILocation(line: 131, column: 10, scope: !172)
!186 = !DILocation(line: 131, column: 15, scope: !172)
!187 = !DILocation(line: 131, column: 13, scope: !172)
!188 = !DILocation(line: 131, column: 20, scope: !172)
!189 = !DILocation(line: 131, column: 25, scope: !172)
!190 = !DILocation(line: 131, column: 23, scope: !172)
!191 = !DILocation(line: 131, column: 18, scope: !172)
!192 = !DILocation(line: 131, column: 8, scope: !172)
!193 = !DILocation(line: 132, column: 23, scope: !172)
!194 = !DILocation(line: 132, column: 21, scope: !172)
!195 = !DILocation(line: 132, column: 10, scope: !172)
!196 = !DILocation(line: 132, column: 8, scope: !172)
!197 = !DILocation(line: 133, column: 9, scope: !172)
!198 = !DILocation(line: 133, column: 20, scope: !172)
!199 = !DILocation(line: 133, column: 18, scope: !172)
!200 = !DILocation(line: 133, column: 12, scope: !172)
!201 = !DILocation(line: 133, column: 7, scope: !172)
!202 = !DILocation(line: 134, column: 16, scope: !172)
!203 = !DILocation(line: 134, column: 14, scope: !172)
!204 = !DILocation(line: 134, column: 20, scope: !172)
!205 = !DILocation(line: 134, column: 25, scope: !172)
!206 = !DILocation(line: 134, column: 23, scope: !172)
!207 = !DILocation(line: 134, column: 18, scope: !172)
!208 = !DILocation(line: 134, column: 8, scope: !172)
!209 = !DILocation(line: 135, column: 23, scope: !172)
!210 = !DILocation(line: 135, column: 21, scope: !172)
!211 = !DILocation(line: 135, column: 10, scope: !172)
!212 = !DILocation(line: 135, column: 8, scope: !172)
!213 = !DILocation(line: 136, column: 10, scope: !172)
!214 = !DILocation(line: 136, column: 21, scope: !172)
!215 = !DILocation(line: 136, column: 19, scope: !172)
!216 = !DILocation(line: 136, column: 13, scope: !172)
!217 = !DILocation(line: 136, column: 6, scope: !172)
!218 = !DILocation(line: 136, column: 8, scope: !172)
!219 = !DILocation(line: 137, column: 20, scope: !172)
!220 = !DILocation(line: 137, column: 19, scope: !172)
!221 = !DILocation(line: 137, column: 16, scope: !172)
!222 = !DILocation(line: 137, column: 5, scope: !172)
!223 = !DILocation(line: 137, column: 7, scope: !172)
!224 = !DILocation(line: 137, column: 10, scope: !172)
!225 = !DILocation(line: 138, column: 3, scope: !172)
!226 = !DILocation(line: 122, column: 24, scope: !167)
!227 = !DILocation(line: 122, column: 3, scope: !167)
!228 = distinct !{!228, !170, !229, !230}
!229 = !DILocation(line: 138, column: 3, scope: !164)
!230 = !{!"llvm.loop.mustprogress"}
!231 = !DILocation(line: 140, column: 3, scope: !113)
