; ModuleID = 'util.c'
source_filename = "util.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [43 x i8] c"NULL pointer from malloc call in %s at %d\0A\00", align 1
@counter_malloc = external dso_local global i32, align 4
@size_malloc = external dso_local global double, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @timer() #0 !dbg !12 {
entry:
  %call = call double @MPI_Wtime(), !dbg !15
  ret double %call, !dbg !16
}

declare dso_local double @MPI_Wtime() #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @ma_malloc(i64 %size, i8* %file, i32 %line) #0 !dbg !17 {
entry:
  %size.addr = alloca i64, align 8
  %file.addr = alloca i8*, align 8
  %line.addr = alloca i32, align 4
  %ptr = alloca i8*, align 8
  store i64 %size, i64* %size.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %size.addr, metadata !26, metadata !DIExpression()), !dbg !27
  store i8* %file, i8** %file.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %file.addr, metadata !28, metadata !DIExpression()), !dbg !29
  store i32 %line, i32* %line.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %line.addr, metadata !30, metadata !DIExpression()), !dbg !31
  call void @llvm.dbg.declare(metadata i8** %ptr, metadata !32, metadata !DIExpression()), !dbg !33
  %0 = load i64, i64* %size.addr, align 8, !dbg !34
  %call = call noalias align 16 i8* @malloc(i64 %0) #5, !dbg !35
  store i8* %call, i8** %ptr, align 8, !dbg !36
  %1 = load i8*, i8** %ptr, align 8, !dbg !37
  %cmp = icmp eq i8* %1, null, !dbg !39
  br i1 %cmp, label %if.then, label %if.end, !dbg !40

if.then:                                          ; preds = %entry
  %2 = load i8*, i8** %file.addr, align 8, !dbg !41
  %3 = load i32, i32* %line.addr, align 4, !dbg !43
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str, i64 0, i64 0), i8* %2, i32 %3), !dbg !44
  call void @exit(i32 -1) #6, !dbg !45
  unreachable, !dbg !45

if.end:                                           ; preds = %entry
  %4 = load i32, i32* @counter_malloc, align 4, !dbg !46
  %inc = add nsw i32 %4, 1, !dbg !46
  store i32 %inc, i32* @counter_malloc, align 4, !dbg !46
  %5 = load i64, i64* %size.addr, align 8, !dbg !47
  %conv = uitofp i64 %5 to double, !dbg !48
  %6 = load double, double* @size_malloc, align 8, !dbg !49
  %add = fadd double %6, %conv, !dbg !49
  store double %add, double* @size_malloc, align 8, !dbg !49
  %7 = load i8*, i8** %ptr, align 8, !dbg !50
  ret i8* %7, !dbg !51
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: nounwind
declare dso_local noalias align 16 i8* @malloc(i64) #3

declare dso_local i32 @printf(i8*, ...) #1

; Function Attrs: noreturn nounwind
declare dso_local void @exit(i32) #4

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #3 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind }
attributes #6 = { noreturn nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!6, !7, !8, !9, !10}
!llvm.ident = !{!11}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 13.0.1-++20220120110924+75e33f71c2da-1~exp1~20220120231001.58", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, debugInfoForProfiling: true, nameTableKind: None)
!1 = !DIFile(filename: "util.c", directory: "/workspace/LLVM-Checker/test/benchmarks/miniAMR/openmp")
!2 = !{}
!3 = !{!4, !5}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!6 = !{i32 7, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = !{i32 7, !"uwtable", i32 1}
!10 = !{i32 7, !"frame-pointer", i32 2}
!11 = !{!"Ubuntu clang version 13.0.1-++20220120110924+75e33f71c2da-1~exp1~20220120231001.58"}
!12 = distinct !DISubprogram(name: "timer", scope: !1, file: !1, line: 36, type: !13, scopeLine: 37, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!13 = !DISubroutineType(types: !14)
!14 = !{!5}
!15 = !DILocation(line: 38, column: 11, scope: !12)
!16 = !DILocation(line: 38, column: 4, scope: !12)
!17 = distinct !DISubprogram(name: "ma_malloc", scope: !1, file: !1, line: 41, type: !18, scopeLine: 42, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!18 = !DISubroutineType(types: !19)
!19 = !{!4, !20, !23, !25}
!20 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !21, line: 46, baseType: !22)
!21 = !DIFile(filename: "/usr/lib/llvm-13/lib/clang/13.0.1/include/stddef.h", directory: "")
!22 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!23 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!24 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!25 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!26 = !DILocalVariable(name: "size", arg: 1, scope: !17, file: !1, line: 41, type: !20)
!27 = !DILocation(line: 41, column: 24, scope: !17)
!28 = !DILocalVariable(name: "file", arg: 2, scope: !17, file: !1, line: 41, type: !23)
!29 = !DILocation(line: 41, column: 36, scope: !17)
!30 = !DILocalVariable(name: "line", arg: 3, scope: !17, file: !1, line: 41, type: !25)
!31 = !DILocation(line: 41, column: 46, scope: !17)
!32 = !DILocalVariable(name: "ptr", scope: !17, file: !1, line: 43, type: !4)
!33 = !DILocation(line: 43, column: 10, scope: !17)
!34 = !DILocation(line: 45, column: 26, scope: !17)
!35 = !DILocation(line: 45, column: 19, scope: !17)
!36 = !DILocation(line: 45, column: 8, scope: !17)
!37 = !DILocation(line: 47, column: 8, scope: !38)
!38 = distinct !DILexicalBlock(scope: !17, file: !1, line: 47, column: 8)
!39 = !DILocation(line: 47, column: 12, scope: !38)
!40 = !DILocation(line: 47, column: 8, scope: !17)
!41 = !DILocation(line: 48, column: 61, scope: !42)
!42 = distinct !DILexicalBlock(scope: !38, file: !1, line: 47, column: 21)
!43 = !DILocation(line: 48, column: 67, scope: !42)
!44 = !DILocation(line: 48, column: 7, scope: !42)
!45 = !DILocation(line: 49, column: 7, scope: !42)
!46 = !DILocation(line: 52, column: 18, scope: !17)
!47 = !DILocation(line: 53, column: 28, scope: !17)
!48 = !DILocation(line: 53, column: 19, scope: !17)
!49 = !DILocation(line: 53, column: 16, scope: !17)
!50 = !DILocation(line: 55, column: 11, scope: !17)
!51 = !DILocation(line: 55, column: 4, scope: !17)
