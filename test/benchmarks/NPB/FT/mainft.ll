; ModuleID = 'mainft.c'
source_filename = "mainft.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, %struct._IO_codecvt*, %struct._IO_wide_data*, %struct._IO_FILE*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type opaque
%struct._IO_codecvt = type opaque
%struct._IO_wide_data = type opaque

@.str = private unnamed_addr constant [11 x i8] c"timer.flag\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@timers_enabled = dso_local global i32 0, align 4, !dbg !0
@.str.2 = private unnamed_addr constant [59 x i8] c"\0A\0A NAS Parallel Benchmarks (NPB3.3-SER-C) - FT Benchmark\0A\0A\00", align 1
@.str.3 = private unnamed_addr constant [36 x i8] c" Size                : %4dx%4dx%4d\0A\00", align 1
@.str.4 = private unnamed_addr constant [33 x i8] c" Iterations          :     %10d\0A\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.6 = private unnamed_addr constant [3 x i8] c"FT\00", align 1
@.str.7 = private unnamed_addr constant [25 x i8] c"          floating point\00", align 1
@.str.8 = private unnamed_addr constant [6 x i8] c"3.3.1\00", align 1
@.str.9 = private unnamed_addr constant [12 x i8] c"11 Aug 2023\00", align 1
@.str.10 = private unnamed_addr constant [4 x i8] c"gcc\00", align 1
@.str.11 = private unnamed_addr constant [6 x i8] c"$(CC)\00", align 1
@.str.12 = private unnamed_addr constant [4 x i8] c"-lm\00", align 1
@.str.13 = private unnamed_addr constant [12 x i8] c"-I../common\00", align 1
@.str.14 = private unnamed_addr constant [29 x i8] c"-g -Wall -O3 -mcmodel=medium\00", align 1
@.str.15 = private unnamed_addr constant [20 x i8] c"-O3 -mcmodel=medium\00", align 1
@.str.16 = private unnamed_addr constant [7 x i8] c"randdp\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 %argc, i8** %argv) #0 !dbg !22 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %niter = alloca i32, align 4
  %Class = alloca i8, align 1
  %total_time = alloca double, align 8
  %mflops = alloca double, align 8
  %verified = alloca i32, align 4
  %fp = alloca %struct._IO_FILE*, align 8
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %argc.addr, metadata !30, metadata !DIExpression()), !dbg !31
  store i8** %argv, i8*** %argv.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %argv.addr, metadata !32, metadata !DIExpression()), !dbg !33
  call void @llvm.dbg.declare(metadata i32* %niter, metadata !34, metadata !DIExpression()), !dbg !35
  call void @llvm.dbg.declare(metadata i8* %Class, metadata !36, metadata !DIExpression()), !dbg !37
  call void @llvm.dbg.declare(metadata double* %total_time, metadata !38, metadata !DIExpression()), !dbg !39
  call void @llvm.dbg.declare(metadata double* %mflops, metadata !40, metadata !DIExpression()), !dbg !41
  call void @llvm.dbg.declare(metadata i32* %verified, metadata !42, metadata !DIExpression()), !dbg !43
  call void @llvm.dbg.declare(metadata %struct._IO_FILE** %fp, metadata !44, metadata !DIExpression()), !dbg !104
  %call = call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0)), !dbg !105
  store %struct._IO_FILE* %call, %struct._IO_FILE** %fp, align 8, !dbg !107
  %cmp = icmp ne %struct._IO_FILE* %call, null, !dbg !108
  br i1 %cmp, label %if.then, label %if.else, !dbg !109

if.then:                                          ; preds = %entry
  store i32 1, i32* @timers_enabled, align 4, !dbg !110
  %0 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8, !dbg !112
  %call1 = call i32 @fclose(%struct._IO_FILE* %0), !dbg !113
  br label %if.end, !dbg !114

if.else:                                          ; preds = %entry
  store i32 0, i32* @timers_enabled, align 4, !dbg !115
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  store i32 6, i32* %niter, align 4, !dbg !117
  %call2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([59 x i8], [59 x i8]* @.str.2, i64 0, i64 0)), !dbg !118
  %call3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.3, i64 0, i64 0), i32 64, i32 64, i32 64), !dbg !119
  %1 = load i32, i32* %niter, align 4, !dbg !120
  %call4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.4, i64 0, i64 0), i32 %1), !dbg !121
  %call5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0)), !dbg !122
  %call6 = call signext i8 @getclass(), !dbg !123
  store i8 %call6, i8* %Class, align 1, !dbg !124
  %2 = load i32, i32* %niter, align 4, !dbg !125
  call void @appft(i32 %2, double* %total_time, i32* %verified), !dbg !126
  %3 = load double, double* %total_time, align 8, !dbg !127
  %cmp7 = fcmp une double %3, 0.000000e+00, !dbg !129
  br i1 %cmp7, label %if.then8, label %if.else16, !dbg !130

if.then8:                                         ; preds = %if.end
  %call9 = call double @log(double 2.621440e+05) #4, !dbg !131
  %mul = fmul double 7.196410e+00, %call9, !dbg !133
  %add = fadd double 1.481570e+01, %mul, !dbg !134
  %call10 = call double @log(double 2.621440e+05) #4, !dbg !135
  %mul11 = fmul double 7.211130e+00, %call10, !dbg !136
  %add12 = fadd double 5.235180e+00, %mul11, !dbg !137
  %4 = load i32, i32* %niter, align 4, !dbg !138
  %conv = sitofp i32 %4 to double, !dbg !138
  %mul13 = fmul double %add12, %conv, !dbg !139
  %add14 = fadd double %add, %mul13, !dbg !140
  %mul15 = fmul double 2.621440e-01, %add14, !dbg !141
  %5 = load double, double* %total_time, align 8, !dbg !142
  %div = fdiv double %mul15, %5, !dbg !143
  store double %div, double* %mflops, align 8, !dbg !144
  br label %if.end17, !dbg !145

if.else16:                                        ; preds = %if.end
  store double 0.000000e+00, double* %mflops, align 8, !dbg !146
  br label %if.end17

if.end17:                                         ; preds = %if.else16, %if.then8
  %6 = load i8, i8* %Class, align 1, !dbg !148
  %7 = load i32, i32* %niter, align 4, !dbg !149
  %8 = load double, double* %total_time, align 8, !dbg !150
  %9 = load double, double* %mflops, align 8, !dbg !151
  %10 = load i32, i32* %verified, align 4, !dbg !152
  call void @print_results(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.6, i64 0, i64 0), i8 signext %6, i32 64, i32 64, i32 64, i32 %7, double %8, double %9, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.7, i64 0, i64 0), i32 %10, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.11, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.12, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.13, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.14, i64 0, i64 0), i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.15, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.16, i64 0, i64 0)), !dbg !153
  ret i32 0, !dbg !154
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local %struct._IO_FILE* @fopen(i8*, i8*) #2

declare dso_local i32 @fclose(%struct._IO_FILE*) #2

declare dso_local i32 @printf(i8*, ...) #2

declare dso_local void @appft(i32, double*, i32*) #2

; Function Attrs: nounwind
declare dso_local double @log(double) #3

declare dso_local void @print_results(i8*, i8 signext, i32, i32, i32, i32, double, double, i8*, i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal signext i8 @getclass() #0 !dbg !155 {
entry:
  ret i8 83, !dbg !158
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!16, !17, !18, !19, !20}
!llvm.ident = !{!21}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "timers_enabled", scope: !2, file: !3, line: 47, type: !15, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 13.0.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !11, globals: !14, splitDebugInlining: false, debugInfoForProfiling: true, nameTableKind: None)
!3 = !DIFile(filename: "mainft.c", directory: "/workspace/LLVM-Checker/test/benchmarks/NPB/FT")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 4, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "../common/type.h", directory: "/workspace/LLVM-Checker/test/benchmarks/NPB/FT")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10}
!9 = !DIEnumerator(name: "false", value: 0)
!10 = !DIEnumerator(name: "true", value: 1)
!11 = !{!12, !13}
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!13 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!14 = !{!0}
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "logical", file: !6, line: 4, baseType: !5)
!16 = !{i32 7, !"Dwarf Version", i32 4}
!17 = !{i32 2, !"Debug Info Version", i32 3}
!18 = !{i32 1, !"wchar_size", i32 4}
!19 = !{i32 7, !"uwtable", i32 1}
!20 = !{i32 7, !"frame-pointer", i32 2}
!21 = !{!"clang version 13.0.1"}
!22 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 50, type: !23, scopeLine: 51, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !29)
!23 = !DISubroutineType(types: !24)
!24 = !{!25, !25, !26}
!25 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !27, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!28 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!29 = !{}
!30 = !DILocalVariable(name: "argc", arg: 1, scope: !22, file: !3, line: 50, type: !25)
!31 = !DILocation(line: 50, column: 14, scope: !22)
!32 = !DILocalVariable(name: "argv", arg: 2, scope: !22, file: !3, line: 50, type: !26)
!33 = !DILocation(line: 50, column: 26, scope: !22)
!34 = !DILocalVariable(name: "niter", scope: !22, file: !3, line: 52, type: !25)
!35 = !DILocation(line: 52, column: 7, scope: !22)
!36 = !DILocalVariable(name: "Class", scope: !22, file: !3, line: 53, type: !28)
!37 = !DILocation(line: 53, column: 8, scope: !22)
!38 = !DILocalVariable(name: "total_time", scope: !22, file: !3, line: 54, type: !13)
!39 = !DILocation(line: 54, column: 10, scope: !22)
!40 = !DILocalVariable(name: "mflops", scope: !22, file: !3, line: 54, type: !13)
!41 = !DILocation(line: 54, column: 22, scope: !22)
!42 = !DILocalVariable(name: "verified", scope: !22, file: !3, line: 55, type: !15)
!43 = !DILocation(line: 55, column: 11, scope: !22)
!44 = !DILocalVariable(name: "fp", scope: !22, file: !3, line: 57, type: !45)
!45 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !46, size: 64)
!46 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !47, line: 7, baseType: !48)
!47 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/FILE.h", directory: "")
!48 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !49, line: 49, size: 1728, elements: !50)
!49 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h", directory: "")
!50 = !{!51, !52, !53, !54, !55, !56, !57, !58, !59, !60, !61, !62, !63, !66, !68, !69, !70, !74, !76, !78, !82, !85, !87, !90, !93, !94, !95, !99, !100}
!51 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !48, file: !49, line: 51, baseType: !25, size: 32)
!52 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !48, file: !49, line: 54, baseType: !27, size: 64, offset: 64)
!53 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !48, file: !49, line: 55, baseType: !27, size: 64, offset: 128)
!54 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !48, file: !49, line: 56, baseType: !27, size: 64, offset: 192)
!55 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !48, file: !49, line: 57, baseType: !27, size: 64, offset: 256)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !48, file: !49, line: 58, baseType: !27, size: 64, offset: 320)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !48, file: !49, line: 59, baseType: !27, size: 64, offset: 384)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !48, file: !49, line: 60, baseType: !27, size: 64, offset: 448)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !48, file: !49, line: 61, baseType: !27, size: 64, offset: 512)
!60 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !48, file: !49, line: 64, baseType: !27, size: 64, offset: 576)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !48, file: !49, line: 65, baseType: !27, size: 64, offset: 640)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !48, file: !49, line: 66, baseType: !27, size: 64, offset: 704)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !48, file: !49, line: 68, baseType: !64, size: 64, offset: 768)
!64 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !65, size: 64)
!65 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !49, line: 36, flags: DIFlagFwdDecl)
!66 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !48, file: !49, line: 70, baseType: !67, size: 64, offset: 832)
!67 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!68 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !48, file: !49, line: 72, baseType: !25, size: 32, offset: 896)
!69 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !48, file: !49, line: 73, baseType: !25, size: 32, offset: 928)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !48, file: !49, line: 74, baseType: !71, size: 64, offset: 960)
!71 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !72, line: 152, baseType: !73)
!72 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "")
!73 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !48, file: !49, line: 77, baseType: !75, size: 16, offset: 1024)
!75 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !48, file: !49, line: 78, baseType: !77, size: 8, offset: 1040)
!77 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !48, file: !49, line: 79, baseType: !79, size: 8, offset: 1048)
!79 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 8, elements: !80)
!80 = !{!81}
!81 = !DISubrange(count: 1)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !48, file: !49, line: 81, baseType: !83, size: 64, offset: 1088)
!83 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !84, size: 64)
!84 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !49, line: 43, baseType: null)
!85 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !48, file: !49, line: 89, baseType: !86, size: 64, offset: 1152)
!86 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !72, line: 153, baseType: !73)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !48, file: !49, line: 91, baseType: !88, size: 64, offset: 1216)
!88 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !89, size: 64)
!89 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !49, line: 37, flags: DIFlagFwdDecl)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !48, file: !49, line: 92, baseType: !91, size: 64, offset: 1280)
!91 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !92, size: 64)
!92 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !49, line: 38, flags: DIFlagFwdDecl)
!93 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !48, file: !49, line: 93, baseType: !67, size: 64, offset: 1344)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !48, file: !49, line: 94, baseType: !12, size: 64, offset: 1408)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "__pad5", scope: !48, file: !49, line: 95, baseType: !96, size: 64, offset: 1472)
!96 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !97, line: 46, baseType: !98)
!97 = !DIFile(filename: "/usr/local/clang-13.0.1/lib/clang/13.0.1/include/stddef.h", directory: "")
!98 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!99 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !48, file: !49, line: 96, baseType: !25, size: 32, offset: 1536)
!100 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !48, file: !49, line: 98, baseType: !101, size: 160, offset: 1568)
!101 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 160, elements: !102)
!102 = !{!103}
!103 = !DISubrange(count: 20)
!104 = !DILocation(line: 57, column: 9, scope: !22)
!105 = !DILocation(line: 58, column: 13, scope: !106)
!106 = distinct !DILexicalBlock(scope: !22, file: !3, line: 58, column: 7)
!107 = !DILocation(line: 58, column: 11, scope: !106)
!108 = !DILocation(line: 58, column: 39, scope: !106)
!109 = !DILocation(line: 58, column: 7, scope: !22)
!110 = !DILocation(line: 59, column: 20, scope: !111)
!111 = distinct !DILexicalBlock(scope: !106, file: !3, line: 58, column: 48)
!112 = !DILocation(line: 60, column: 12, scope: !111)
!113 = !DILocation(line: 60, column: 5, scope: !111)
!114 = !DILocation(line: 61, column: 3, scope: !111)
!115 = !DILocation(line: 62, column: 20, scope: !116)
!116 = distinct !DILexicalBlock(scope: !106, file: !3, line: 61, column: 10)
!117 = !DILocation(line: 65, column: 9, scope: !22)
!118 = !DILocation(line: 67, column: 3, scope: !22)
!119 = !DILocation(line: 68, column: 3, scope: !22)
!120 = !DILocation(line: 69, column: 47, scope: !22)
!121 = !DILocation(line: 69, column: 3, scope: !22)
!122 = !DILocation(line: 70, column: 3, scope: !22)
!123 = !DILocation(line: 72, column: 11, scope: !22)
!124 = !DILocation(line: 72, column: 9, scope: !22)
!125 = !DILocation(line: 74, column: 9, scope: !22)
!126 = !DILocation(line: 74, column: 3, scope: !22)
!127 = !DILocation(line: 76, column: 7, scope: !128)
!128 = distinct !DILexicalBlock(scope: !22, file: !3, line: 76, column: 7)
!129 = !DILocation(line: 76, column: 18, scope: !128)
!130 = !DILocation(line: 76, column: 7, scope: !22)
!131 = !DILocation(line: 78, column: 34, scope: !132)
!132 = distinct !DILexicalBlock(scope: !128, file: !3, line: 76, column: 26)
!133 = !DILocation(line: 78, column: 32, scope: !132)
!134 = !DILocation(line: 78, column: 22, scope: !132)
!135 = !DILocation(line: 79, column: 37, scope: !132)
!136 = !DILocation(line: 79, column: 35, scope: !132)
!137 = !DILocation(line: 79, column: 25, scope: !132)
!138 = !DILocation(line: 79, column: 60, scope: !132)
!139 = !DILocation(line: 79, column: 58, scope: !132)
!140 = !DILocation(line: 79, column: 14, scope: !132)
!141 = !DILocation(line: 77, column: 38, scope: !132)
!142 = !DILocation(line: 80, column: 15, scope: !132)
!143 = !DILocation(line: 80, column: 13, scope: !132)
!144 = !DILocation(line: 77, column: 12, scope: !132)
!145 = !DILocation(line: 81, column: 3, scope: !132)
!146 = !DILocation(line: 82, column: 12, scope: !147)
!147 = distinct !DILexicalBlock(scope: !128, file: !3, line: 81, column: 10)
!148 = !DILocation(line: 85, column: 23, scope: !22)
!149 = !DILocation(line: 85, column: 42, scope: !22)
!150 = !DILocation(line: 86, column: 17, scope: !22)
!151 = !DILocation(line: 86, column: 29, scope: !22)
!152 = !DILocation(line: 86, column: 65, scope: !22)
!153 = !DILocation(line: 85, column: 3, scope: !22)
!154 = !DILocation(line: 90, column: 3, scope: !22)
!155 = distinct !DISubprogram(name: "getclass", scope: !3, file: !3, line: 94, type: !156, scopeLine: 95, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !29)
!156 = !DISubroutineType(types: !157)
!157 = !{!28}
!158 = !DILocation(line: 98, column: 5, scope: !159)
!159 = distinct !DILexicalBlock(scope: !160, file: !3, line: 97, column: 43)
!160 = distinct !DILexicalBlock(scope: !155, file: !3, line: 96, column: 7)
