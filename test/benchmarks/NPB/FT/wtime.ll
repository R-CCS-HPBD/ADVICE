; ModuleID = 'wtime.c'
source_filename = "wtime.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.timeval = type { i64, i64 }

@wtime_.sec = internal global i32 -1, align 4, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @wtime_(double* %t) #0 !dbg !2 {
entry:
  %t.addr = alloca double*, align 8
  %tv = alloca %struct.timeval, align 8
  store double* %t, double** %t.addr, align 8
  call void @llvm.dbg.declare(metadata double** %t.addr, metadata !20, metadata !DIExpression()), !dbg !21
  call void @llvm.dbg.declare(metadata %struct.timeval* %tv, metadata !22, metadata !DIExpression()), !dbg !32
  %call = call i32 @gettimeofday(%struct.timeval* %tv, i8* null) #3, !dbg !33
  %0 = load i32, i32* @wtime_.sec, align 4, !dbg !34
  %cmp = icmp slt i32 %0, 0, !dbg !36
  br i1 %cmp, label %if.then, label %if.end, !dbg !37

if.then:                                          ; preds = %entry
  %tv_sec = getelementptr inbounds %struct.timeval, %struct.timeval* %tv, i32 0, i32 0, !dbg !38
  %1 = load i64, i64* %tv_sec, align 8, !dbg !38
  %conv = trunc i64 %1 to i32, !dbg !39
  store i32 %conv, i32* @wtime_.sec, align 4, !dbg !40
  br label %if.end, !dbg !41

if.end:                                           ; preds = %if.then, %entry
  %tv_sec1 = getelementptr inbounds %struct.timeval, %struct.timeval* %tv, i32 0, i32 0, !dbg !42
  %2 = load i64, i64* %tv_sec1, align 8, !dbg !42
  %3 = load i32, i32* @wtime_.sec, align 4, !dbg !43
  %conv2 = sext i32 %3 to i64, !dbg !43
  %sub = sub nsw i64 %2, %conv2, !dbg !44
  %conv3 = sitofp i64 %sub to double, !dbg !45
  %tv_usec = getelementptr inbounds %struct.timeval, %struct.timeval* %tv, i32 0, i32 1, !dbg !46
  %4 = load i64, i64* %tv_usec, align 8, !dbg !46
  %conv4 = sitofp i64 %4 to double, !dbg !47
  %mul = fmul double 0x3EB0C6F7A0B5ED8D, %conv4, !dbg !48
  %add = fadd double %conv3, %mul, !dbg !49
  %5 = load double*, double** %t.addr, align 8, !dbg !50
  store double %add, double* %5, align 8, !dbg !51
  ret void, !dbg !52
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local i32 @gettimeofday(%struct.timeval*, i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!8}
!llvm.module.flags = !{!14, !15, !16, !17, !18}
!llvm.ident = !{!19}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "sec", scope: !2, file: !3, line: 9, type: !13, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "wtime_", scope: !3, file: !3, line: 7, type: !4, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !8, retainedNodes: !9)
!3 = !DIFile(filename: "wtime.c", directory: "/workspace/LLVM-Checker/test/benchmarks/NPB/FT")
!4 = !DISubroutineType(types: !5)
!5 = !{null, !6}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!8 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 13.0.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !9, retainedTypes: !10, globals: !12, splitDebugInlining: false, debugInfoForProfiling: true, nameTableKind: None)
!9 = !{}
!10 = !{!11}
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!12 = !{!0}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !{i32 7, !"Dwarf Version", i32 4}
!15 = !{i32 2, !"Debug Info Version", i32 3}
!16 = !{i32 1, !"wchar_size", i32 4}
!17 = !{i32 7, !"uwtable", i32 1}
!18 = !{i32 7, !"frame-pointer", i32 2}
!19 = !{!"clang version 13.0.1"}
!20 = !DILocalVariable(name: "t", arg: 1, scope: !2, file: !3, line: 7, type: !6)
!21 = !DILocation(line: 7, column: 20, scope: !2)
!22 = !DILocalVariable(name: "tv", scope: !2, file: !3, line: 10, type: !23)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timeval", file: !24, line: 8, size: 128, elements: !25)
!24 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h", directory: "")
!25 = !{!26, !30}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !23, file: !24, line: 10, baseType: !27, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !28, line: 160, baseType: !29)
!28 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "")
!29 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!30 = !DIDerivedType(tag: DW_TAG_member, name: "tv_usec", scope: !23, file: !24, line: 11, baseType: !31, size: 64, offset: 64)
!31 = !DIDerivedType(tag: DW_TAG_typedef, name: "__suseconds_t", file: !28, line: 162, baseType: !29)
!32 = !DILocation(line: 10, column: 18, scope: !2)
!33 = !DILocation(line: 11, column: 3, scope: !2)
!34 = !DILocation(line: 12, column: 7, scope: !35)
!35 = distinct !DILexicalBlock(scope: !2, file: !3, line: 12, column: 7)
!36 = !DILocation(line: 12, column: 11, scope: !35)
!37 = !DILocation(line: 12, column: 7, scope: !2)
!38 = !DILocation(line: 12, column: 25, scope: !35)
!39 = !DILocation(line: 12, column: 22, scope: !35)
!40 = !DILocation(line: 12, column: 20, scope: !35)
!41 = !DILocation(line: 12, column: 16, scope: !35)
!42 = !DILocation(line: 13, column: 12, scope: !2)
!43 = !DILocation(line: 13, column: 21, scope: !2)
!44 = !DILocation(line: 13, column: 19, scope: !2)
!45 = !DILocation(line: 13, column: 8, scope: !2)
!46 = !DILocation(line: 13, column: 38, scope: !2)
!47 = !DILocation(line: 13, column: 35, scope: !2)
!48 = !DILocation(line: 13, column: 34, scope: !2)
!49 = !DILocation(line: 13, column: 26, scope: !2)
!50 = !DILocation(line: 13, column: 4, scope: !2)
!51 = !DILocation(line: 13, column: 6, scope: !2)
!52 = !DILocation(line: 14, column: 1, scope: !2)
