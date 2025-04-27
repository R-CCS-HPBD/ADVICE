; ModuleID = 'driver.c'
source_filename = "driver.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.object = type { i32, i32, [3 x double], [3 x double], [3 x double], [3 x double], [3 x double], [3 x double], [3 x double] }
%struct.block = type { i64, i32, i32, i32, i64, i32, i32, [6 x i32], [6 x i32], [6 x [2 x [2 x i32]]], [3 x i32], double**** }

@counter_malloc = external dso_local global i32, align 4
@counter_malloc_init = external dso_local global i32, align 4
@size_malloc = external dso_local global double, align 8
@size_malloc_init = external dso_local global double, align 8
@num_refine = external dso_local global i32, align 4
@uniform_refine = external dso_local global i32, align 4
@timer_refine_all = external dso_local global double, align 8
@plot_freq = external dso_local global i32, align 4
@timer_plot = external dso_local global double, align 8
@global_active = external dso_local global i64, align 8
@nb_max = external dso_local global i64, align 8
@nb_min = external dso_local global i64, align 8
@use_time = external dso_local global i32, align 4
@stages_per_ts = external dso_local global i32, align 4
@total_blocks = external dso_local global i64, align 8
@num_vars = external dso_local global i32, align 4
@comm_vars = external dso_local global i32, align 4
@timer_comm_all = external dso_local global double, align 8
@timer_calc_all = external dso_local global double, align 8
@checksum_freq = external dso_local global i32, align 4
@report_diffusion = external dso_local global i32, align 4
@my_pe = external dso_local global i32, align 4
@.str = private unnamed_addr constant [48 x i8] c"%d var %d sum %lf old %lf diff %lf %lf tol %lf\0A\00", align 1
@grid_sum = external dso_local global double*, align 8
@tol = external dso_local global double, align 8
@stencil = external dso_local global i32, align 4
@.str.1 = private unnamed_addr constant [65 x i8] c"Time step %d sum %lf (old %lf) variable %d difference too large\0A\00", align 1
@timer_cs_all = external dso_local global double, align 8
@refine_freq = external dso_local global i32, align 4
@end_time = external dso_local global double, align 8
@num_tsteps = external dso_local global i32, align 4
@timer_all = external dso_local global double, align 8
@mesh_size = external dso_local global [3 x i32], align 4
@x_block_size = external dso_local global i32, align 4
@y_block_size = external dso_local global i32, align 4
@z_block_size = external dso_local global i32, align 4
@num_objects = external dso_local global i32, align 4
@objects = external dso_local global %struct.object*, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @driver() #0 !dbg !11 {
entry:
  %ts = alloca i32, align 4
  %var = alloca i32, align 4
  %start = alloca i32, align 4
  %number = alloca i32, align 4
  %stage = alloca i32, align 4
  %comm_stage = alloca i32, align 4
  %calc_stage = alloca i32, align 4
  %done = alloca i32, align 4
  %in = alloca i32, align 4
  %t1 = alloca double, align 8
  %t2 = alloca double, align 8
  %t3 = alloca double, align 8
  %t4 = alloca double, align 8
  %sum = alloca double, align 8
  %delta = alloca double, align 8
  %sim_time = alloca double, align 8
  %bp = alloca %struct.block*, align 8
  call void @llvm.dbg.declare(metadata i32* %ts, metadata !14, metadata !DIExpression()), !dbg !16
  call void @llvm.dbg.declare(metadata i32* %var, metadata !17, metadata !DIExpression()), !dbg !18
  call void @llvm.dbg.declare(metadata i32* %start, metadata !19, metadata !DIExpression()), !dbg !20
  call void @llvm.dbg.declare(metadata i32* %number, metadata !21, metadata !DIExpression()), !dbg !22
  call void @llvm.dbg.declare(metadata i32* %stage, metadata !23, metadata !DIExpression()), !dbg !24
  call void @llvm.dbg.declare(metadata i32* %comm_stage, metadata !25, metadata !DIExpression()), !dbg !26
  call void @llvm.dbg.declare(metadata i32* %calc_stage, metadata !27, metadata !DIExpression()), !dbg !28
  call void @llvm.dbg.declare(metadata i32* %done, metadata !29, metadata !DIExpression()), !dbg !30
  call void @llvm.dbg.declare(metadata i32* %in, metadata !31, metadata !DIExpression()), !dbg !32
  call void @llvm.dbg.declare(metadata double* %t1, metadata !33, metadata !DIExpression()), !dbg !34
  call void @llvm.dbg.declare(metadata double* %t2, metadata !35, metadata !DIExpression()), !dbg !36
  call void @llvm.dbg.declare(metadata double* %t3, metadata !37, metadata !DIExpression()), !dbg !38
  call void @llvm.dbg.declare(metadata double* %t4, metadata !39, metadata !DIExpression()), !dbg !40
  call void @llvm.dbg.declare(metadata double* %sum, metadata !41, metadata !DIExpression()), !dbg !42
  call void @llvm.dbg.declare(metadata double* %delta, metadata !43, metadata !DIExpression()), !dbg !44
  store double 1.000000e+00, double* %delta, align 8, !dbg !44
  call void @llvm.dbg.declare(metadata double* %sim_time, metadata !45, metadata !DIExpression()), !dbg !46
  call void @llvm.dbg.declare(metadata %struct.block** %bp, metadata !47, metadata !DIExpression()), !dbg !80
  call void @init(), !dbg !81
  call void @init_profile(), !dbg !82
  %0 = load i32, i32* @counter_malloc, align 4, !dbg !83
  store i32 %0, i32* @counter_malloc_init, align 4, !dbg !84
  %1 = load double, double* @size_malloc, align 8, !dbg !85
  store double %1, double* @size_malloc_init, align 8, !dbg !86
  %call = call double @timer(), !dbg !87
  store double %call, double* %t1, align 8, !dbg !88
  %2 = load i32, i32* @num_refine, align 4, !dbg !89
  %tobool = icmp ne i32 %2, 0, !dbg !89
  br i1 %tobool, label %if.then, label %lor.lhs.false, !dbg !91

lor.lhs.false:                                    ; preds = %entry
  %3 = load i32, i32* @uniform_refine, align 4, !dbg !92
  %tobool1 = icmp ne i32 %3, 0, !dbg !92
  br i1 %tobool1, label %if.then, label %if.end, !dbg !93

if.then:                                          ; preds = %lor.lhs.false, %entry
  call void @refine(i32 0), !dbg !94
  br label %if.end, !dbg !94

if.end:                                           ; preds = %if.then, %lor.lhs.false
  %call2 = call double @timer(), !dbg !95
  store double %call2, double* %t2, align 8, !dbg !96
  %4 = load double, double* %t2, align 8, !dbg !97
  %5 = load double, double* %t1, align 8, !dbg !98
  %sub = fsub double %4, %5, !dbg !99
  %6 = load double, double* @timer_refine_all, align 8, !dbg !100
  %add = fadd double %6, %sub, !dbg !100
  store double %add, double* @timer_refine_all, align 8, !dbg !100
  %7 = load i32, i32* @plot_freq, align 4, !dbg !101
  %tobool3 = icmp ne i32 %7, 0, !dbg !101
  br i1 %tobool3, label %if.then4, label %if.end5, !dbg !103

if.then4:                                         ; preds = %if.end
  call void @plot(i32 0), !dbg !104
  br label %if.end5, !dbg !104

if.end5:                                          ; preds = %if.then4, %if.end
  %call6 = call double @timer(), !dbg !105
  store double %call6, double* %t3, align 8, !dbg !106
  %8 = load double, double* %t3, align 8, !dbg !107
  %9 = load double, double* %t2, align 8, !dbg !108
  %sub7 = fsub double %8, %9, !dbg !109
  %10 = load double, double* @timer_plot, align 8, !dbg !110
  %add8 = fadd double %10, %sub7, !dbg !110
  store double %add8, double* @timer_plot, align 8, !dbg !110
  %11 = load i64, i64* @global_active, align 8, !dbg !111
  store i64 %11, i64* @nb_max, align 8, !dbg !112
  store i64 %11, i64* @nb_min, align 8, !dbg !113
  %12 = load i32, i32* @use_time, align 4, !dbg !114
  %tobool9 = icmp ne i32 %12, 0, !dbg !114
  br i1 %tobool9, label %if.then10, label %if.end12, !dbg !116

if.then10:                                        ; preds = %if.end5
  %call11 = call double @calc_time_step(), !dbg !117
  store double %call11, double* %delta, align 8, !dbg !118
  br label %if.end12, !dbg !119

if.end12:                                         ; preds = %if.then10, %if.end5
  store double 0.000000e+00, double* %sim_time, align 8, !dbg !120
  store i32 0, i32* %calc_stage, align 4, !dbg !122
  store i32 0, i32* %comm_stage, align 4, !dbg !123
  store i32 0, i32* %done, align 4, !dbg !124
  store i32 1, i32* %ts, align 4, !dbg !125
  br label %for.cond, !dbg !126

for.cond:                                         ; preds = %for.inc129, %if.end12
  %13 = load i32, i32* %done, align 4, !dbg !127
  %tobool13 = icmp ne i32 %13, 0, !dbg !129
  %lnot = xor i1 %tobool13, true, !dbg !129
  br i1 %lnot, label %for.body, label %for.end131, !dbg !130

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %stage, align 4, !dbg !131
  br label %for.cond14, !dbg !134

for.cond14:                                       ; preds = %for.inc89, %for.body
  %14 = load i32, i32* %stage, align 4, !dbg !135
  %15 = load i32, i32* @stages_per_ts, align 4, !dbg !137
  %cmp = icmp slt i32 %14, %15, !dbg !138
  br i1 %cmp, label %for.body15, label %for.end93, !dbg !139

for.body15:                                       ; preds = %for.cond14
  %16 = load i64, i64* @global_active, align 8, !dbg !140
  %17 = load i64, i64* @total_blocks, align 8, !dbg !142
  %add16 = add nsw i64 %17, %16, !dbg !142
  store i64 %add16, i64* @total_blocks, align 8, !dbg !142
  %18 = load i64, i64* @global_active, align 8, !dbg !143
  %19 = load i64, i64* @nb_min, align 8, !dbg !145
  %cmp17 = icmp slt i64 %18, %19, !dbg !146
  br i1 %cmp17, label %if.then18, label %if.end19, !dbg !147

if.then18:                                        ; preds = %for.body15
  %20 = load i64, i64* @global_active, align 8, !dbg !148
  store i64 %20, i64* @nb_min, align 8, !dbg !149
  br label %if.end19, !dbg !150

if.end19:                                         ; preds = %if.then18, %for.body15
  %21 = load i64, i64* @global_active, align 8, !dbg !151
  %22 = load i64, i64* @nb_max, align 8, !dbg !153
  %cmp20 = icmp sgt i64 %21, %22, !dbg !154
  br i1 %cmp20, label %if.then21, label %if.end22, !dbg !155

if.then21:                                        ; preds = %if.end19
  %23 = load i64, i64* @global_active, align 8, !dbg !156
  store i64 %23, i64* @nb_max, align 8, !dbg !157
  br label %if.end22, !dbg !158

if.end22:                                         ; preds = %if.then21, %if.end19
  store i32 0, i32* %start, align 4, !dbg !159
  br label %for.cond23, !dbg !161

for.cond23:                                       ; preds = %for.inc86, %if.end22
  %24 = load i32, i32* %start, align 4, !dbg !162
  %25 = load i32, i32* @num_vars, align 4, !dbg !164
  %cmp24 = icmp slt i32 %24, %25, !dbg !165
  br i1 %cmp24, label %for.body25, label %for.end88, !dbg !166

for.body25:                                       ; preds = %for.cond23
  %26 = load i32, i32* %start, align 4, !dbg !167
  %27 = load i32, i32* @comm_vars, align 4, !dbg !170
  %add26 = add nsw i32 %26, %27, !dbg !171
  %28 = load i32, i32* @num_vars, align 4, !dbg !172
  %cmp27 = icmp sgt i32 %add26, %28, !dbg !173
  br i1 %cmp27, label %if.then28, label %if.else, !dbg !174

if.then28:                                        ; preds = %for.body25
  %29 = load i32, i32* @num_vars, align 4, !dbg !175
  %30 = load i32, i32* %start, align 4, !dbg !176
  %sub29 = sub nsw i32 %29, %30, !dbg !177
  store i32 %sub29, i32* %number, align 4, !dbg !178
  br label %if.end30, !dbg !179

if.else:                                          ; preds = %for.body25
  %31 = load i32, i32* @comm_vars, align 4, !dbg !180
  store i32 %31, i32* %number, align 4, !dbg !181
  br label %if.end30

if.end30:                                         ; preds = %if.else, %if.then28
  %call31 = call double @timer(), !dbg !182
  store double %call31, double* %t3, align 8, !dbg !183
  %32 = load i32, i32* %start, align 4, !dbg !184
  %33 = load i32, i32* %number, align 4, !dbg !185
  %34 = load i32, i32* %comm_stage, align 4, !dbg !186
  call void @comm(i32 %32, i32 %33, i32 %34), !dbg !187
  %call32 = call double @timer(), !dbg !188
  store double %call32, double* %t4, align 8, !dbg !189
  %35 = load double, double* %t4, align 8, !dbg !190
  %36 = load double, double* %t3, align 8, !dbg !191
  %sub33 = fsub double %35, %36, !dbg !192
  %37 = load double, double* @timer_comm_all, align 8, !dbg !193
  %add34 = fadd double %37, %sub33, !dbg !193
  store double %add34, double* @timer_comm_all, align 8, !dbg !193
  %38 = load i32, i32* %start, align 4, !dbg !194
  store i32 %38, i32* %var, align 4, !dbg !196
  br label %for.cond35, !dbg !197

for.cond35:                                       ; preds = %for.inc, %if.end30
  %39 = load i32, i32* %var, align 4, !dbg !198
  %40 = load i32, i32* %start, align 4, !dbg !200
  %41 = load i32, i32* %number, align 4, !dbg !201
  %add36 = add nsw i32 %40, %41, !dbg !202
  %cmp37 = icmp slt i32 %39, %add36, !dbg !203
  br i1 %cmp37, label %for.body38, label %for.end, !dbg !204

for.body38:                                       ; preds = %for.cond35
  %42 = load i32, i32* %var, align 4, !dbg !205
  %43 = load i32, i32* %calc_stage, align 4, !dbg !207
  call void @stencil_driver(i32 %42, i32 %43), !dbg !208
  %call39 = call double @timer(), !dbg !209
  store double %call39, double* %t3, align 8, !dbg !210
  %44 = load double, double* %t3, align 8, !dbg !211
  %45 = load double, double* %t4, align 8, !dbg !212
  %sub40 = fsub double %44, %45, !dbg !213
  %46 = load double, double* @timer_calc_all, align 8, !dbg !214
  %add41 = fadd double %46, %sub40, !dbg !214
  store double %add41, double* @timer_calc_all, align 8, !dbg !214
  %47 = load i32, i32* @checksum_freq, align 4, !dbg !215
  %tobool42 = icmp ne i32 %47, 0, !dbg !215
  br i1 %tobool42, label %land.lhs.true, label %if.end82, !dbg !217

land.lhs.true:                                    ; preds = %for.body38
  %48 = load i32, i32* %stage, align 4, !dbg !218
  %49 = load i32, i32* @checksum_freq, align 4, !dbg !219
  %rem = srem i32 %48, %49, !dbg !220
  %tobool43 = icmp ne i32 %rem, 0, !dbg !220
  br i1 %tobool43, label %if.end82, label %if.then44, !dbg !221

if.then44:                                        ; preds = %land.lhs.true
  %50 = load i32, i32* %var, align 4, !dbg !222
  %call45 = call double @check_sum(i32 %50), !dbg !224
  store double %call45, double* %sum, align 8, !dbg !225
  %51 = load i32, i32* @report_diffusion, align 4, !dbg !226
  %tobool46 = icmp ne i32 %51, 0, !dbg !226
  br i1 %tobool46, label %land.lhs.true47, label %if.end59, !dbg !228

land.lhs.true47:                                  ; preds = %if.then44
  %52 = load i32, i32* @my_pe, align 4, !dbg !229
  %tobool48 = icmp ne i32 %52, 0, !dbg !229
  br i1 %tobool48, label %if.end59, label %if.then49, !dbg !230

if.then49:                                        ; preds = %land.lhs.true47
  %53 = load i32, i32* %ts, align 4, !dbg !231
  %54 = load i32, i32* %var, align 4, !dbg !232
  %55 = load double, double* %sum, align 8, !dbg !233
  %56 = load double*, double** @grid_sum, align 8, !dbg !234
  %57 = load i32, i32* %var, align 4, !dbg !235
  %idxprom = sext i32 %57 to i64, !dbg !234
  %arrayidx = getelementptr inbounds double, double* %56, i64 %idxprom, !dbg !234
  %58 = load double, double* %arrayidx, align 8, !dbg !234
  %59 = load double, double* %sum, align 8, !dbg !236
  %60 = load double*, double** @grid_sum, align 8, !dbg !237
  %61 = load i32, i32* %var, align 4, !dbg !238
  %idxprom50 = sext i32 %61 to i64, !dbg !237
  %arrayidx51 = getelementptr inbounds double, double* %60, i64 %idxprom50, !dbg !237
  %62 = load double, double* %arrayidx51, align 8, !dbg !237
  %sub52 = fsub double %59, %62, !dbg !239
  %63 = load double, double* %sum, align 8, !dbg !240
  %64 = load double*, double** @grid_sum, align 8, !dbg !241
  %65 = load i32, i32* %var, align 4, !dbg !242
  %idxprom53 = sext i32 %65 to i64, !dbg !241
  %arrayidx54 = getelementptr inbounds double, double* %64, i64 %idxprom53, !dbg !241
  %66 = load double, double* %arrayidx54, align 8, !dbg !241
  %sub55 = fsub double %63, %66, !dbg !243
  %67 = call double @llvm.fabs.f64(double %sub55), !dbg !244
  %68 = load double*, double** @grid_sum, align 8, !dbg !245
  %69 = load i32, i32* %var, align 4, !dbg !246
  %idxprom56 = sext i32 %69 to i64, !dbg !245
  %arrayidx57 = getelementptr inbounds double, double* %68, i64 %idxprom56, !dbg !245
  %70 = load double, double* %arrayidx57, align 8, !dbg !245
  %div = fdiv double %67, %70, !dbg !247
  %71 = load double, double* @tol, align 8, !dbg !248
  %call58 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str, i64 0, i64 0), i32 %53, i32 %54, double %55, double %58, double %sub52, double %div, double %71), !dbg !249
  br label %if.end59, !dbg !249

if.end59:                                         ; preds = %if.then49, %land.lhs.true47, %if.then44
  %72 = load i32, i32* @stencil, align 4, !dbg !250
  %tobool60 = icmp ne i32 %72, 0, !dbg !250
  br i1 %tobool60, label %if.then63, label %lor.lhs.false61, !dbg !252

lor.lhs.false61:                                  ; preds = %if.end59
  %73 = load i32, i32* %var, align 4, !dbg !253
  %cmp62 = icmp eq i32 %73, 0, !dbg !254
  br i1 %cmp62, label %if.then63, label %if.end79, !dbg !255

if.then63:                                        ; preds = %lor.lhs.false61, %if.end59
  %74 = load double, double* %sum, align 8, !dbg !256
  %75 = load double*, double** @grid_sum, align 8, !dbg !258
  %76 = load i32, i32* %var, align 4, !dbg !259
  %idxprom64 = sext i32 %76 to i64, !dbg !258
  %arrayidx65 = getelementptr inbounds double, double* %75, i64 %idxprom64, !dbg !258
  %77 = load double, double* %arrayidx65, align 8, !dbg !258
  %sub66 = fsub double %74, %77, !dbg !260
  %78 = call double @llvm.fabs.f64(double %sub66), !dbg !261
  %79 = load double*, double** @grid_sum, align 8, !dbg !262
  %80 = load i32, i32* %var, align 4, !dbg !263
  %idxprom67 = sext i32 %80 to i64, !dbg !262
  %arrayidx68 = getelementptr inbounds double, double* %79, i64 %idxprom67, !dbg !262
  %81 = load double, double* %arrayidx68, align 8, !dbg !262
  %div69 = fdiv double %78, %81, !dbg !264
  %82 = load double, double* @tol, align 8, !dbg !265
  %cmp70 = fcmp ogt double %div69, %82, !dbg !266
  br i1 %cmp70, label %if.then71, label %if.end78, !dbg !267

if.then71:                                        ; preds = %if.then63
  %83 = load i32, i32* @my_pe, align 4, !dbg !268
  %tobool72 = icmp ne i32 %83, 0, !dbg !268
  br i1 %tobool72, label %if.end77, label %if.then73, !dbg !271

if.then73:                                        ; preds = %if.then71
  %84 = load i32, i32* %ts, align 4, !dbg !272
  %85 = load double, double* %sum, align 8, !dbg !273
  %86 = load double*, double** @grid_sum, align 8, !dbg !274
  %87 = load i32, i32* %var, align 4, !dbg !275
  %idxprom74 = sext i32 %87 to i64, !dbg !274
  %arrayidx75 = getelementptr inbounds double, double* %86, i64 %idxprom74, !dbg !274
  %88 = load double, double* %arrayidx75, align 8, !dbg !274
  %89 = load i32, i32* %var, align 4, !dbg !276
  %call76 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([65 x i8], [65 x i8]* @.str.1, i64 0, i64 0), i32 %84, double %85, double %88, i32 %89), !dbg !277
  br label %if.end77, !dbg !277

if.end77:                                         ; preds = %if.then73, %if.then71
  br label %return, !dbg !278

if.end78:                                         ; preds = %if.then63
  br label %if.end79, !dbg !265

if.end79:                                         ; preds = %if.end78, %lor.lhs.false61
  %90 = load double, double* %sum, align 8, !dbg !279
  %91 = load double*, double** @grid_sum, align 8, !dbg !280
  %92 = load i32, i32* %var, align 4, !dbg !281
  %idxprom80 = sext i32 %92 to i64, !dbg !280
  %arrayidx81 = getelementptr inbounds double, double* %91, i64 %idxprom80, !dbg !280
  store double %90, double* %arrayidx81, align 8, !dbg !282
  br label %if.end82, !dbg !283

if.end82:                                         ; preds = %if.end79, %land.lhs.true, %for.body38
  %call83 = call double @timer(), !dbg !284
  store double %call83, double* %t4, align 8, !dbg !285
  %93 = load double, double* %t4, align 8, !dbg !286
  %94 = load double, double* %t3, align 8, !dbg !287
  %sub84 = fsub double %93, %94, !dbg !288
  %95 = load double, double* @timer_cs_all, align 8, !dbg !289
  %add85 = fadd double %95, %sub84, !dbg !289
  store double %add85, double* @timer_cs_all, align 8, !dbg !289
  br label %for.inc, !dbg !290

for.inc:                                          ; preds = %if.end82
  %96 = load i32, i32* %var, align 4, !dbg !291
  %inc = add nsw i32 %96, 1, !dbg !291
  store i32 %inc, i32* %var, align 4, !dbg !291
  br label %for.cond35, !dbg !292, !llvm.loop !293

for.end:                                          ; preds = %for.cond35
  br label %for.inc86, !dbg !296

for.inc86:                                        ; preds = %for.end
  %97 = load i32, i32* @comm_vars, align 4, !dbg !297
  %98 = load i32, i32* %start, align 4, !dbg !298
  %add87 = add nsw i32 %98, %97, !dbg !298
  store i32 %add87, i32* %start, align 4, !dbg !298
  br label %for.cond23, !dbg !299, !llvm.loop !300

for.end88:                                        ; preds = %for.cond23
  br label %for.inc89, !dbg !302

for.inc89:                                        ; preds = %for.end88
  %99 = load i32, i32* %stage, align 4, !dbg !303
  %inc90 = add nsw i32 %99, 1, !dbg !303
  store i32 %inc90, i32* %stage, align 4, !dbg !303
  %100 = load i32, i32* %comm_stage, align 4, !dbg !304
  %inc91 = add nsw i32 %100, 1, !dbg !304
  store i32 %inc91, i32* %comm_stage, align 4, !dbg !304
  %101 = load i32, i32* %calc_stage, align 4, !dbg !305
  %inc92 = add nsw i32 %101, 1, !dbg !305
  store i32 %inc92, i32* %calc_stage, align 4, !dbg !305
  br label %for.cond14, !dbg !306, !llvm.loop !307

for.end93:                                        ; preds = %for.cond14
  %102 = load i32, i32* @num_refine, align 4, !dbg !309
  %tobool94 = icmp ne i32 %102, 0, !dbg !309
  br i1 %tobool94, label %land.lhs.true95, label %if.end102, !dbg !311

land.lhs.true95:                                  ; preds = %for.end93
  %103 = load i32, i32* @uniform_refine, align 4, !dbg !312
  %tobool96 = icmp ne i32 %103, 0, !dbg !312
  br i1 %tobool96, label %if.end102, label %if.then97, !dbg !313

if.then97:                                        ; preds = %land.lhs.true95
  %104 = load double, double* %delta, align 8, !dbg !314
  call void @move(double %104), !dbg !316
  %105 = load i32, i32* %ts, align 4, !dbg !317
  %106 = load i32, i32* @refine_freq, align 4, !dbg !319
  %rem98 = srem i32 %105, %106, !dbg !320
  %tobool99 = icmp ne i32 %rem98, 0, !dbg !320
  br i1 %tobool99, label %if.end101, label %if.then100, !dbg !321

if.then100:                                       ; preds = %if.then97
  %107 = load i32, i32* %ts, align 4, !dbg !322
  call void @refine(i32 %107), !dbg !323
  br label %if.end101, !dbg !323

if.end101:                                        ; preds = %if.then100, %if.then97
  br label %if.end102, !dbg !324

if.end102:                                        ; preds = %if.end101, %land.lhs.true95, %for.end93
  %call103 = call double @timer(), !dbg !325
  store double %call103, double* %t2, align 8, !dbg !326
  %108 = load double, double* %t2, align 8, !dbg !327
  %109 = load double, double* %t4, align 8, !dbg !328
  %sub104 = fsub double %108, %109, !dbg !329
  %110 = load double, double* @timer_refine_all, align 8, !dbg !330
  %add105 = fadd double %110, %sub104, !dbg !330
  store double %add105, double* @timer_refine_all, align 8, !dbg !330
  %call106 = call double @timer(), !dbg !331
  store double %call106, double* %t3, align 8, !dbg !332
  %111 = load i32, i32* @plot_freq, align 4, !dbg !333
  %tobool107 = icmp ne i32 %111, 0, !dbg !333
  br i1 %tobool107, label %land.lhs.true108, label %if.end112, !dbg !335

land.lhs.true108:                                 ; preds = %if.end102
  %112 = load i32, i32* %ts, align 4, !dbg !336
  %113 = load i32, i32* @plot_freq, align 4, !dbg !337
  %rem109 = srem i32 %112, %113, !dbg !338
  %tobool110 = icmp ne i32 %rem109, 0, !dbg !338
  br i1 %tobool110, label %if.end112, label %if.then111, !dbg !339

if.then111:                                       ; preds = %land.lhs.true108
  %114 = load i32, i32* %ts, align 4, !dbg !340
  call void @plot(i32 %114), !dbg !341
  br label %if.end112, !dbg !341

if.end112:                                        ; preds = %if.then111, %land.lhs.true108, %if.end102
  %call113 = call double @timer(), !dbg !342
  %115 = load double, double* %t3, align 8, !dbg !343
  %sub114 = fsub double %call113, %115, !dbg !344
  %116 = load double, double* @timer_plot, align 8, !dbg !345
  %add115 = fadd double %116, %sub114, !dbg !345
  store double %add115, double* @timer_plot, align 8, !dbg !345
  %117 = load i32, i32* @use_time, align 4, !dbg !346
  %tobool116 = icmp ne i32 %117, 0, !dbg !346
  br i1 %tobool116, label %if.then117, label %if.else124, !dbg !348

if.then117:                                       ; preds = %if.end112
  %call118 = call double @calc_time_step(), !dbg !349
  store double %call118, double* %delta, align 8, !dbg !351
  %118 = load double, double* %sim_time, align 8, !dbg !352
  %119 = load double, double* @end_time, align 8, !dbg !354
  %cmp119 = fcmp oge double %118, %119, !dbg !355
  br i1 %cmp119, label %if.then120, label %if.else121, !dbg !356

if.then120:                                       ; preds = %if.then117
  store i32 1, i32* %done, align 4, !dbg !357
  br label %if.end123, !dbg !358

if.else121:                                       ; preds = %if.then117
  %120 = load double, double* %delta, align 8, !dbg !359
  %121 = load double, double* %sim_time, align 8, !dbg !360
  %add122 = fadd double %121, %120, !dbg !360
  store double %add122, double* %sim_time, align 8, !dbg !360
  br label %if.end123

if.end123:                                        ; preds = %if.else121, %if.then120
  br label %if.end128, !dbg !361

if.else124:                                       ; preds = %if.end112
  %122 = load i32, i32* %ts, align 4, !dbg !362
  %123 = load i32, i32* @num_tsteps, align 4, !dbg !364
  %cmp125 = icmp sge i32 %122, %123, !dbg !365
  br i1 %cmp125, label %if.then126, label %if.end127, !dbg !366

if.then126:                                       ; preds = %if.else124
  store i32 1, i32* %done, align 4, !dbg !367
  br label %if.end127, !dbg !368

if.end127:                                        ; preds = %if.then126, %if.else124
  br label %if.end128

if.end128:                                        ; preds = %if.end127, %if.end123
  br label %for.inc129, !dbg !369

for.inc129:                                       ; preds = %if.end128
  %124 = load i32, i32* %ts, align 4, !dbg !370
  %inc130 = add nsw i32 %124, 1, !dbg !370
  store i32 %inc130, i32* %ts, align 4, !dbg !370
  br label %for.cond, !dbg !371, !llvm.loop !372

for.end131:                                       ; preds = %for.cond
  %125 = load double, double* %sim_time, align 8, !dbg !374
  store double %125, double* @end_time, align 8, !dbg !375
  %126 = load i32, i32* %ts, align 4, !dbg !376
  %sub132 = sub nsw i32 %126, 1, !dbg !377
  store i32 %sub132, i32* @num_tsteps, align 4, !dbg !378
  %call133 = call double @timer(), !dbg !379
  %127 = load double, double* %t1, align 8, !dbg !380
  %sub134 = fsub double %call133, %127, !dbg !381
  store double %sub134, double* @timer_all, align 8, !dbg !382
  br label %return, !dbg !383

return:                                           ; preds = %for.end131, %if.end77
  ret void, !dbg !383
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local void @init() #2

declare dso_local void @init_profile() #2

declare dso_local double @timer() #2

declare dso_local void @refine(i32) #2

declare dso_local void @plot(i32) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @calc_time_step() #0 !dbg !384 {
entry:
  %o = alloca i32, align 4
  %dir = alloca i32, align 4
  %done = alloca i32, align 4
  %delta = alloca double, align 8
  %tmp = alloca double, align 8
  %inv_cell_size = alloca [3 x double], align 16
  %op = alloca %struct.object*, align 8
  call void @llvm.dbg.declare(metadata i32* %o, metadata !386, metadata !DIExpression()), !dbg !387
  call void @llvm.dbg.declare(metadata i32* %dir, metadata !388, metadata !DIExpression()), !dbg !389
  call void @llvm.dbg.declare(metadata i32* %done, metadata !390, metadata !DIExpression()), !dbg !391
  call void @llvm.dbg.declare(metadata double* %delta, metadata !392, metadata !DIExpression()), !dbg !393
  call void @llvm.dbg.declare(metadata double* %tmp, metadata !394, metadata !DIExpression()), !dbg !395
  call void @llvm.dbg.declare(metadata [3 x double]* %inv_cell_size, metadata !396, metadata !DIExpression()), !dbg !398
  call void @llvm.dbg.declare(metadata %struct.object** %op, metadata !399, metadata !DIExpression()), !dbg !413
  %0 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @mesh_size, i64 0, i64 0), align 4, !dbg !414
  %1 = load i32, i32* @x_block_size, align 4, !dbg !415
  %mul = mul nsw i32 %0, %1, !dbg !416
  %conv = sitofp i32 %mul to double, !dbg !417
  %arrayidx = getelementptr inbounds [3 x double], [3 x double]* %inv_cell_size, i64 0, i64 0, !dbg !418
  store double %conv, double* %arrayidx, align 16, !dbg !419
  %2 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @mesh_size, i64 0, i64 1), align 4, !dbg !420
  %3 = load i32, i32* @y_block_size, align 4, !dbg !421
  %mul1 = mul nsw i32 %2, %3, !dbg !422
  %conv2 = sitofp i32 %mul1 to double, !dbg !423
  %arrayidx3 = getelementptr inbounds [3 x double], [3 x double]* %inv_cell_size, i64 0, i64 1, !dbg !424
  store double %conv2, double* %arrayidx3, align 8, !dbg !425
  %4 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @mesh_size, i64 0, i64 2), align 4, !dbg !426
  %5 = load i32, i32* @z_block_size, align 4, !dbg !427
  %mul4 = mul nsw i32 %4, %5, !dbg !428
  %conv5 = sitofp i32 %mul4 to double, !dbg !429
  %arrayidx6 = getelementptr inbounds [3 x double], [3 x double]* %inv_cell_size, i64 0, i64 2, !dbg !430
  store double %conv5, double* %arrayidx6, align 16, !dbg !431
  store double 0.000000e+00, double* %delta, align 8, !dbg !432
  store i32 0, i32* %o, align 4, !dbg !433
  br label %for.cond, !dbg !435

for.cond:                                         ; preds = %for.inc80, %entry
  %6 = load i32, i32* %o, align 4, !dbg !436
  %7 = load i32, i32* @num_objects, align 4, !dbg !438
  %cmp = icmp slt i32 %6, %7, !dbg !439
  br i1 %cmp, label %for.body, label %for.end82, !dbg !440

for.body:                                         ; preds = %for.cond
  %8 = load %struct.object*, %struct.object** @objects, align 8, !dbg !441
  %9 = load i32, i32* %o, align 4, !dbg !443
  %idxprom = sext i32 %9 to i64, !dbg !441
  %arrayidx8 = getelementptr inbounds %struct.object, %struct.object* %8, i64 %idxprom, !dbg !441
  store %struct.object* %arrayidx8, %struct.object** %op, align 8, !dbg !444
  %10 = load %struct.object*, %struct.object** %op, align 8, !dbg !445
  %size = getelementptr inbounds %struct.object, %struct.object* %10, i32 0, i32 6, !dbg !447
  %arrayidx9 = getelementptr inbounds [3 x double], [3 x double]* %size, i64 0, i64 0, !dbg !445
  %11 = load double, double* %arrayidx9, align 8, !dbg !445
  %cmp10 = fcmp olt double %11, 0.000000e+00, !dbg !448
  br i1 %cmp10, label %if.then, label %lor.lhs.false, !dbg !449

lor.lhs.false:                                    ; preds = %for.body
  %12 = load %struct.object*, %struct.object** %op, align 8, !dbg !450
  %size12 = getelementptr inbounds %struct.object, %struct.object* %12, i32 0, i32 6, !dbg !451
  %arrayidx13 = getelementptr inbounds [3 x double], [3 x double]* %size12, i64 0, i64 1, !dbg !450
  %13 = load double, double* %arrayidx13, align 8, !dbg !450
  %cmp14 = fcmp olt double %13, 0.000000e+00, !dbg !452
  br i1 %cmp14, label %if.then, label %lor.lhs.false16, !dbg !453

lor.lhs.false16:                                  ; preds = %lor.lhs.false
  %14 = load %struct.object*, %struct.object** %op, align 8, !dbg !454
  %size17 = getelementptr inbounds %struct.object, %struct.object* %14, i32 0, i32 6, !dbg !455
  %arrayidx18 = getelementptr inbounds [3 x double], [3 x double]* %size17, i64 0, i64 2, !dbg !454
  %15 = load double, double* %arrayidx18, align 8, !dbg !454
  %cmp19 = fcmp olt double %15, 0.000000e+00, !dbg !456
  br i1 %cmp19, label %if.then, label %if.end, !dbg !457

if.then:                                          ; preds = %lor.lhs.false16, %lor.lhs.false, %for.body
  br label %for.end82, !dbg !458

if.end:                                           ; preds = %lor.lhs.false16
  store i32 0, i32* %dir, align 4, !dbg !459
  store i32 0, i32* %done, align 4, !dbg !461
  br label %for.cond21, !dbg !462

for.cond21:                                       ; preds = %for.inc, %if.end
  %16 = load i32, i32* %dir, align 4, !dbg !463
  %cmp22 = icmp slt i32 %16, 3, !dbg !465
  br i1 %cmp22, label %for.body24, label %for.end, !dbg !466

for.body24:                                       ; preds = %for.cond21
  %17 = load %struct.object*, %struct.object** %op, align 8, !dbg !467
  %cen = getelementptr inbounds %struct.object, %struct.object* %17, i32 0, i32 2, !dbg !469
  %18 = load i32, i32* %dir, align 4, !dbg !470
  %idxprom25 = sext i32 %18 to i64, !dbg !467
  %arrayidx26 = getelementptr inbounds [3 x double], [3 x double]* %cen, i64 0, i64 %idxprom25, !dbg !467
  %19 = load double, double* %arrayidx26, align 8, !dbg !467
  %cmp27 = fcmp olt double %19, 0.000000e+00, !dbg !471
  br i1 %cmp27, label %if.then29, label %if.else, !dbg !472

if.then29:                                        ; preds = %for.body24
  %20 = load %struct.object*, %struct.object** %op, align 8, !dbg !473
  %cen30 = getelementptr inbounds %struct.object, %struct.object* %20, i32 0, i32 2, !dbg !476
  %21 = load i32, i32* %dir, align 4, !dbg !477
  %idxprom31 = sext i32 %21 to i64, !dbg !473
  %arrayidx32 = getelementptr inbounds [3 x double], [3 x double]* %cen30, i64 0, i64 %idxprom31, !dbg !473
  %22 = load double, double* %arrayidx32, align 8, !dbg !473
  %23 = load %struct.object*, %struct.object** %op, align 8, !dbg !478
  %size33 = getelementptr inbounds %struct.object, %struct.object* %23, i32 0, i32 6, !dbg !479
  %24 = load i32, i32* %dir, align 4, !dbg !480
  %idxprom34 = sext i32 %24 to i64, !dbg !478
  %arrayidx35 = getelementptr inbounds [3 x double], [3 x double]* %size33, i64 0, i64 %idxprom34, !dbg !478
  %25 = load double, double* %arrayidx35, align 8, !dbg !478
  %add = fadd double %22, %25, !dbg !481
  %cmp36 = fcmp olt double %add, 0.000000e+00, !dbg !482
  br i1 %cmp36, label %if.then38, label %if.end39, !dbg !483

if.then38:                                        ; preds = %if.then29
  store i32 1, i32* %done, align 4, !dbg !484
  br label %if.end39, !dbg !485

if.end39:                                         ; preds = %if.then38, %if.then29
  br label %if.end57, !dbg !486

if.else:                                          ; preds = %for.body24
  %26 = load %struct.object*, %struct.object** %op, align 8, !dbg !487
  %cen40 = getelementptr inbounds %struct.object, %struct.object* %26, i32 0, i32 2, !dbg !489
  %27 = load i32, i32* %dir, align 4, !dbg !490
  %idxprom41 = sext i32 %27 to i64, !dbg !487
  %arrayidx42 = getelementptr inbounds [3 x double], [3 x double]* %cen40, i64 0, i64 %idxprom41, !dbg !487
  %28 = load double, double* %arrayidx42, align 8, !dbg !487
  %cmp43 = fcmp ogt double %28, 1.000000e+00, !dbg !491
  br i1 %cmp43, label %if.then45, label %if.end56, !dbg !492

if.then45:                                        ; preds = %if.else
  %29 = load %struct.object*, %struct.object** %op, align 8, !dbg !493
  %cen46 = getelementptr inbounds %struct.object, %struct.object* %29, i32 0, i32 2, !dbg !496
  %30 = load i32, i32* %dir, align 4, !dbg !497
  %idxprom47 = sext i32 %30 to i64, !dbg !493
  %arrayidx48 = getelementptr inbounds [3 x double], [3 x double]* %cen46, i64 0, i64 %idxprom47, !dbg !493
  %31 = load double, double* %arrayidx48, align 8, !dbg !493
  %32 = load %struct.object*, %struct.object** %op, align 8, !dbg !498
  %size49 = getelementptr inbounds %struct.object, %struct.object* %32, i32 0, i32 6, !dbg !499
  %33 = load i32, i32* %dir, align 4, !dbg !500
  %idxprom50 = sext i32 %33 to i64, !dbg !498
  %arrayidx51 = getelementptr inbounds [3 x double], [3 x double]* %size49, i64 0, i64 %idxprom50, !dbg !498
  %34 = load double, double* %arrayidx51, align 8, !dbg !498
  %sub = fsub double %31, %34, !dbg !501
  %cmp52 = fcmp ogt double %sub, 1.000000e+00, !dbg !502
  br i1 %cmp52, label %if.then54, label %if.end55, !dbg !503

if.then54:                                        ; preds = %if.then45
  store i32 1, i32* %done, align 4, !dbg !504
  br label %if.end55, !dbg !505

if.end55:                                         ; preds = %if.then54, %if.then45
  br label %if.end56, !dbg !506

if.end56:                                         ; preds = %if.end55, %if.else
  br label %if.end57

if.end57:                                         ; preds = %if.end56, %if.end39
  br label %for.inc, !dbg !507

for.inc:                                          ; preds = %if.end57
  %35 = load i32, i32* %dir, align 4, !dbg !508
  %inc = add nsw i32 %35, 1, !dbg !508
  store i32 %inc, i32* %dir, align 4, !dbg !508
  br label %for.cond21, !dbg !509, !llvm.loop !510

for.end:                                          ; preds = %for.cond21
  %36 = load i32, i32* %done, align 4, !dbg !512
  %tobool = icmp ne i32 %36, 0, !dbg !512
  br i1 %tobool, label %if.then58, label %if.end59, !dbg !514

if.then58:                                        ; preds = %for.end
  br label %for.end82, !dbg !515

if.end59:                                         ; preds = %for.end
  store i32 0, i32* %dir, align 4, !dbg !516
  store i32 0, i32* %done, align 4, !dbg !518
  br label %for.cond60, !dbg !519

for.cond60:                                       ; preds = %for.inc77, %if.end59
  %37 = load i32, i32* %dir, align 4, !dbg !520
  %cmp61 = icmp slt i32 %37, 3, !dbg !522
  br i1 %cmp61, label %for.body63, label %for.end79, !dbg !523

for.body63:                                       ; preds = %for.cond60
  %38 = load %struct.object*, %struct.object** %op, align 8, !dbg !524
  %move = getelementptr inbounds %struct.object, %struct.object* %38, i32 0, i32 4, !dbg !526
  %39 = load i32, i32* %dir, align 4, !dbg !527
  %idxprom64 = sext i32 %39 to i64, !dbg !524
  %arrayidx65 = getelementptr inbounds [3 x double], [3 x double]* %move, i64 0, i64 %idxprom64, !dbg !524
  %40 = load double, double* %arrayidx65, align 8, !dbg !524
  %41 = call double @llvm.fabs.f64(double %40), !dbg !528
  %42 = load %struct.object*, %struct.object** %op, align 8, !dbg !529
  %inc66 = getelementptr inbounds %struct.object, %struct.object* %42, i32 0, i32 8, !dbg !530
  %43 = load i32, i32* %dir, align 4, !dbg !531
  %idxprom67 = sext i32 %43 to i64, !dbg !529
  %arrayidx68 = getelementptr inbounds [3 x double], [3 x double]* %inc66, i64 0, i64 %idxprom67, !dbg !529
  %44 = load double, double* %arrayidx68, align 8, !dbg !529
  %45 = call double @llvm.fabs.f64(double %44), !dbg !532
  %add69 = fadd double %41, %45, !dbg !533
  %46 = load i32, i32* %dir, align 4, !dbg !534
  %idxprom70 = sext i32 %46 to i64, !dbg !535
  %arrayidx71 = getelementptr inbounds [3 x double], [3 x double]* %inv_cell_size, i64 0, i64 %idxprom70, !dbg !535
  %47 = load double, double* %arrayidx71, align 8, !dbg !535
  %mul72 = fmul double %add69, %47, !dbg !536
  store double %mul72, double* %tmp, align 8, !dbg !537
  %48 = load double, double* %tmp, align 8, !dbg !538
  %49 = load double, double* %delta, align 8, !dbg !540
  %cmp73 = fcmp ogt double %48, %49, !dbg !541
  br i1 %cmp73, label %if.then75, label %if.end76, !dbg !542

if.then75:                                        ; preds = %for.body63
  %50 = load double, double* %tmp, align 8, !dbg !543
  store double %50, double* %delta, align 8, !dbg !544
  br label %if.end76, !dbg !545

if.end76:                                         ; preds = %if.then75, %for.body63
  br label %for.inc77, !dbg !546

for.inc77:                                        ; preds = %if.end76
  %51 = load i32, i32* %dir, align 4, !dbg !547
  %inc78 = add nsw i32 %51, 1, !dbg !547
  store i32 %inc78, i32* %dir, align 4, !dbg !547
  br label %for.cond60, !dbg !548, !llvm.loop !549

for.end79:                                        ; preds = %for.cond60
  br label %for.inc80, !dbg !551

for.inc80:                                        ; preds = %for.end79
  %52 = load i32, i32* %o, align 4, !dbg !552
  %inc81 = add nsw i32 %52, 1, !dbg !552
  store i32 %inc81, i32* %o, align 4, !dbg !552
  br label %for.cond, !dbg !553, !llvm.loop !554

for.end82:                                        ; preds = %if.then58, %if.then, %for.cond
  %53 = load double, double* %delta, align 8, !dbg !556
  %cmp83 = fcmp ogt double %53, 0.000000e+00, !dbg !558
  br i1 %cmp83, label %if.then85, label %if.else86, !dbg !559

if.then85:                                        ; preds = %for.end82
  %54 = load double, double* %delta, align 8, !dbg !560
  %div = fdiv double 1.000000e+00, %54, !dbg !561
  store double %div, double* %delta, align 8, !dbg !562
  br label %if.end87, !dbg !563

if.else86:                                        ; preds = %for.end82
  store double 1.000000e+00, double* %delta, align 8, !dbg !564
  br label %if.end87

if.end87:                                         ; preds = %if.else86, %if.then85
  %55 = load double, double* %delta, align 8, !dbg !565
  ret double %55, !dbg !566
}

declare dso_local void @comm(i32, i32, i32) #2

declare dso_local void @stencil_driver(i32, i32) #2

declare dso_local double @check_sum(i32) #2

declare dso_local i32 @printf(i8*, ...) #2

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.fabs.f64(double) #1

declare dso_local void @move(double) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7, !8, !9}
!llvm.ident = !{!10}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 13.0.1-++20220120110924+75e33f71c2da-1~exp1~20220120231001.58", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, debugInfoForProfiling: true, nameTableKind: None)
!1 = !DIFile(filename: "driver.c", directory: "/workspace/LLVM-Checker/test/benchmarks/miniAMR/openmp")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!5 = !{i32 7, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{i32 7, !"uwtable", i32 1}
!9 = !{i32 7, !"frame-pointer", i32 2}
!10 = !{!"Ubuntu clang version 13.0.1-++20220120110924+75e33f71c2da-1~exp1~20220120231001.58"}
!11 = distinct !DISubprogram(name: "driver", scope: !1, file: !1, line: 37, type: !12, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!12 = !DISubroutineType(types: !13)
!13 = !{null}
!14 = !DILocalVariable(name: "ts", scope: !11, file: !1, line: 39, type: !15)
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DILocation(line: 39, column: 8, scope: !11)
!17 = !DILocalVariable(name: "var", scope: !11, file: !1, line: 39, type: !15)
!18 = !DILocation(line: 39, column: 12, scope: !11)
!19 = !DILocalVariable(name: "start", scope: !11, file: !1, line: 39, type: !15)
!20 = !DILocation(line: 39, column: 17, scope: !11)
!21 = !DILocalVariable(name: "number", scope: !11, file: !1, line: 39, type: !15)
!22 = !DILocation(line: 39, column: 24, scope: !11)
!23 = !DILocalVariable(name: "stage", scope: !11, file: !1, line: 39, type: !15)
!24 = !DILocation(line: 39, column: 32, scope: !11)
!25 = !DILocalVariable(name: "comm_stage", scope: !11, file: !1, line: 39, type: !15)
!26 = !DILocation(line: 39, column: 39, scope: !11)
!27 = !DILocalVariable(name: "calc_stage", scope: !11, file: !1, line: 39, type: !15)
!28 = !DILocation(line: 39, column: 51, scope: !11)
!29 = !DILocalVariable(name: "done", scope: !11, file: !1, line: 39, type: !15)
!30 = !DILocation(line: 39, column: 63, scope: !11)
!31 = !DILocalVariable(name: "in", scope: !11, file: !1, line: 39, type: !15)
!32 = !DILocation(line: 39, column: 69, scope: !11)
!33 = !DILocalVariable(name: "t1", scope: !11, file: !1, line: 40, type: !4)
!34 = !DILocation(line: 40, column: 11, scope: !11)
!35 = !DILocalVariable(name: "t2", scope: !11, file: !1, line: 40, type: !4)
!36 = !DILocation(line: 40, column: 15, scope: !11)
!37 = !DILocalVariable(name: "t3", scope: !11, file: !1, line: 40, type: !4)
!38 = !DILocation(line: 40, column: 19, scope: !11)
!39 = !DILocalVariable(name: "t4", scope: !11, file: !1, line: 40, type: !4)
!40 = !DILocation(line: 40, column: 23, scope: !11)
!41 = !DILocalVariable(name: "sum", scope: !11, file: !1, line: 41, type: !4)
!42 = !DILocation(line: 41, column: 11, scope: !11)
!43 = !DILocalVariable(name: "delta", scope: !11, file: !1, line: 41, type: !4)
!44 = !DILocation(line: 41, column: 16, scope: !11)
!45 = !DILocalVariable(name: "sim_time", scope: !11, file: !1, line: 41, type: !4)
!46 = !DILocation(line: 41, column: 29, scope: !11)
!47 = !DILocalVariable(name: "bp", scope: !11, file: !1, line: 42, type: !48)
!48 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !49, size: 64)
!49 = !DIDerivedType(tag: DW_TAG_typedef, name: "block", file: !50, line: 46, baseType: !51)
!50 = !DIFile(filename: "./block.h", directory: "/workspace/LLVM-Checker/test/benchmarks/miniAMR/openmp")
!51 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !50, line: 31, size: 1664, elements: !52)
!52 = !{!53, !56, !57, !58, !59, !60, !61, !62, !66, !67, !71, !75}
!53 = !DIDerivedType(tag: DW_TAG_member, name: "number", scope: !51, file: !50, line: 32, baseType: !54, size: 64)
!54 = !DIDerivedType(tag: DW_TAG_typedef, name: "num_sz", file: !50, line: 29, baseType: !55)
!55 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "level", scope: !51, file: !50, line: 33, baseType: !15, size: 32, offset: 64)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "refine", scope: !51, file: !50, line: 34, baseType: !15, size: 32, offset: 96)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "new_proc", scope: !51, file: !50, line: 35, baseType: !15, size: 32, offset: 128)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "parent", scope: !51, file: !50, line: 36, baseType: !54, size: 64, offset: 192)
!60 = !DIDerivedType(tag: DW_TAG_member, name: "parent_node", scope: !51, file: !50, line: 39, baseType: !15, size: 32, offset: 256)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "child_number", scope: !51, file: !50, line: 40, baseType: !15, size: 32, offset: 288)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "nei_refine", scope: !51, file: !50, line: 41, baseType: !63, size: 192, offset: 320)
!63 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 192, elements: !64)
!64 = !{!65}
!65 = !DISubrange(count: 6)
!66 = !DIDerivedType(tag: DW_TAG_member, name: "nei_level", scope: !51, file: !50, line: 42, baseType: !63, size: 192, offset: 512)
!67 = !DIDerivedType(tag: DW_TAG_member, name: "nei", scope: !51, file: !50, line: 43, baseType: !68, size: 768, offset: 704)
!68 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 768, elements: !69)
!69 = !{!65, !70, !70}
!70 = !DISubrange(count: 2)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "cen", scope: !51, file: !50, line: 44, baseType: !72, size: 96, offset: 1472)
!72 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 96, elements: !73)
!73 = !{!74}
!74 = !DISubrange(count: 3)
!75 = !DIDerivedType(tag: DW_TAG_member, name: "array", scope: !51, file: !50, line: 45, baseType: !76, size: 64, offset: 1600)
!76 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !77, size: 64)
!77 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !78, size: 64)
!78 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !79, size: 64)
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!80 = !DILocation(line: 42, column: 11, scope: !11)
!81 = !DILocation(line: 44, column: 4, scope: !11)
!82 = !DILocation(line: 45, column: 4, scope: !11)
!83 = !DILocation(line: 46, column: 26, scope: !11)
!84 = !DILocation(line: 46, column: 24, scope: !11)
!85 = !DILocation(line: 47, column: 23, scope: !11)
!86 = !DILocation(line: 47, column: 21, scope: !11)
!87 = !DILocation(line: 49, column: 9, scope: !11)
!88 = !DILocation(line: 49, column: 7, scope: !11)
!89 = !DILocation(line: 51, column: 8, scope: !90)
!90 = distinct !DILexicalBlock(scope: !11, file: !1, line: 51, column: 8)
!91 = !DILocation(line: 51, column: 19, scope: !90)
!92 = !DILocation(line: 51, column: 22, scope: !90)
!93 = !DILocation(line: 51, column: 8, scope: !11)
!94 = !DILocation(line: 51, column: 38, scope: !90)
!95 = !DILocation(line: 52, column: 9, scope: !11)
!96 = !DILocation(line: 52, column: 7, scope: !11)
!97 = !DILocation(line: 53, column: 24, scope: !11)
!98 = !DILocation(line: 53, column: 29, scope: !11)
!99 = !DILocation(line: 53, column: 27, scope: !11)
!100 = !DILocation(line: 53, column: 21, scope: !11)
!101 = !DILocation(line: 55, column: 8, scope: !102)
!102 = distinct !DILexicalBlock(scope: !11, file: !1, line: 55, column: 8)
!103 = !DILocation(line: 55, column: 8, scope: !11)
!104 = !DILocation(line: 56, column: 7, scope: !102)
!105 = !DILocation(line: 57, column: 9, scope: !11)
!106 = !DILocation(line: 57, column: 7, scope: !11)
!107 = !DILocation(line: 58, column: 18, scope: !11)
!108 = !DILocation(line: 58, column: 23, scope: !11)
!109 = !DILocation(line: 58, column: 21, scope: !11)
!110 = !DILocation(line: 58, column: 15, scope: !11)
!111 = !DILocation(line: 60, column: 22, scope: !11)
!112 = !DILocation(line: 60, column: 20, scope: !11)
!113 = !DILocation(line: 60, column: 11, scope: !11)
!114 = !DILocation(line: 62, column: 8, scope: !115)
!115 = distinct !DILexicalBlock(scope: !11, file: !1, line: 62, column: 8)
!116 = !DILocation(line: 62, column: 8, scope: !11)
!117 = !DILocation(line: 62, column: 26, scope: !115)
!118 = !DILocation(line: 62, column: 24, scope: !115)
!119 = !DILocation(line: 62, column: 18, scope: !115)
!120 = !DILocation(line: 63, column: 18, scope: !121)
!121 = distinct !DILexicalBlock(scope: !11, file: !1, line: 63, column: 4)
!122 = !DILocation(line: 63, column: 54, scope: !121)
!123 = !DILocation(line: 63, column: 43, scope: !121)
!124 = !DILocation(line: 63, column: 30, scope: !121)
!125 = !DILocation(line: 63, column: 61, scope: !121)
!126 = !DILocation(line: 63, column: 9, scope: !121)
!127 = !DILocation(line: 63, column: 67, scope: !128)
!128 = distinct !DILexicalBlock(scope: !121, file: !1, line: 63, column: 4)
!129 = !DILocation(line: 63, column: 66, scope: !128)
!130 = !DILocation(line: 63, column: 4, scope: !121)
!131 = !DILocation(line: 64, column: 17, scope: !132)
!132 = distinct !DILexicalBlock(scope: !133, file: !1, line: 64, column: 7)
!133 = distinct !DILexicalBlock(scope: !128, file: !1, line: 63, column: 79)
!134 = !DILocation(line: 64, column: 12, scope: !132)
!135 = !DILocation(line: 64, column: 21, scope: !136)
!136 = distinct !DILexicalBlock(scope: !132, file: !1, line: 64, column: 7)
!137 = !DILocation(line: 64, column: 29, scope: !136)
!138 = !DILocation(line: 64, column: 27, scope: !136)
!139 = !DILocation(line: 64, column: 7, scope: !132)
!140 = !DILocation(line: 65, column: 26, scope: !141)
!141 = distinct !DILexicalBlock(scope: !136, file: !1, line: 64, column: 79)
!142 = !DILocation(line: 65, column: 23, scope: !141)
!143 = !DILocation(line: 66, column: 14, scope: !144)
!144 = distinct !DILexicalBlock(scope: !141, file: !1, line: 66, column: 14)
!145 = !DILocation(line: 66, column: 30, scope: !144)
!146 = !DILocation(line: 66, column: 28, scope: !144)
!147 = !DILocation(line: 66, column: 14, scope: !141)
!148 = !DILocation(line: 67, column: 22, scope: !144)
!149 = !DILocation(line: 67, column: 20, scope: !144)
!150 = !DILocation(line: 67, column: 13, scope: !144)
!151 = !DILocation(line: 68, column: 14, scope: !152)
!152 = distinct !DILexicalBlock(scope: !141, file: !1, line: 68, column: 14)
!153 = !DILocation(line: 68, column: 30, scope: !152)
!154 = !DILocation(line: 68, column: 28, scope: !152)
!155 = !DILocation(line: 68, column: 14, scope: !141)
!156 = !DILocation(line: 69, column: 22, scope: !152)
!157 = !DILocation(line: 69, column: 20, scope: !152)
!158 = !DILocation(line: 69, column: 13, scope: !152)
!159 = !DILocation(line: 70, column: 21, scope: !160)
!160 = distinct !DILexicalBlock(scope: !141, file: !1, line: 70, column: 10)
!161 = !DILocation(line: 70, column: 15, scope: !160)
!162 = !DILocation(line: 70, column: 26, scope: !163)
!163 = distinct !DILexicalBlock(scope: !160, file: !1, line: 70, column: 10)
!164 = !DILocation(line: 70, column: 34, scope: !163)
!165 = !DILocation(line: 70, column: 32, scope: !163)
!166 = !DILocation(line: 70, column: 10, scope: !160)
!167 = !DILocation(line: 71, column: 17, scope: !168)
!168 = distinct !DILexicalBlock(scope: !169, file: !1, line: 71, column: 17)
!169 = distinct !DILexicalBlock(scope: !163, file: !1, line: 70, column: 64)
!170 = !DILocation(line: 71, column: 23, scope: !168)
!171 = !DILocation(line: 71, column: 22, scope: !168)
!172 = !DILocation(line: 71, column: 35, scope: !168)
!173 = !DILocation(line: 71, column: 33, scope: !168)
!174 = !DILocation(line: 71, column: 17, scope: !169)
!175 = !DILocation(line: 72, column: 25, scope: !168)
!176 = !DILocation(line: 72, column: 36, scope: !168)
!177 = !DILocation(line: 72, column: 34, scope: !168)
!178 = !DILocation(line: 72, column: 23, scope: !168)
!179 = !DILocation(line: 72, column: 16, scope: !168)
!180 = !DILocation(line: 74, column: 25, scope: !168)
!181 = !DILocation(line: 74, column: 23, scope: !168)
!182 = !DILocation(line: 75, column: 18, scope: !169)
!183 = !DILocation(line: 75, column: 16, scope: !169)
!184 = !DILocation(line: 76, column: 18, scope: !169)
!185 = !DILocation(line: 76, column: 25, scope: !169)
!186 = !DILocation(line: 76, column: 33, scope: !169)
!187 = !DILocation(line: 76, column: 13, scope: !169)
!188 = !DILocation(line: 77, column: 18, scope: !169)
!189 = !DILocation(line: 77, column: 16, scope: !169)
!190 = !DILocation(line: 78, column: 31, scope: !169)
!191 = !DILocation(line: 78, column: 36, scope: !169)
!192 = !DILocation(line: 78, column: 34, scope: !169)
!193 = !DILocation(line: 78, column: 28, scope: !169)
!194 = !DILocation(line: 79, column: 24, scope: !195)
!195 = distinct !DILexicalBlock(scope: !169, file: !1, line: 79, column: 13)
!196 = !DILocation(line: 79, column: 22, scope: !195)
!197 = !DILocation(line: 79, column: 18, scope: !195)
!198 = !DILocation(line: 79, column: 31, scope: !199)
!199 = distinct !DILexicalBlock(scope: !195, file: !1, line: 79, column: 13)
!200 = !DILocation(line: 79, column: 38, scope: !199)
!201 = !DILocation(line: 79, column: 44, scope: !199)
!202 = !DILocation(line: 79, column: 43, scope: !199)
!203 = !DILocation(line: 79, column: 35, scope: !199)
!204 = !DILocation(line: 79, column: 13, scope: !195)
!205 = !DILocation(line: 80, column: 31, scope: !206)
!206 = distinct !DILexicalBlock(scope: !199, file: !1, line: 79, column: 61)
!207 = !DILocation(line: 80, column: 36, scope: !206)
!208 = !DILocation(line: 80, column: 16, scope: !206)
!209 = !DILocation(line: 86, column: 21, scope: !206)
!210 = !DILocation(line: 86, column: 19, scope: !206)
!211 = !DILocation(line: 88, column: 34, scope: !206)
!212 = !DILocation(line: 88, column: 39, scope: !206)
!213 = !DILocation(line: 88, column: 37, scope: !206)
!214 = !DILocation(line: 88, column: 31, scope: !206)
!215 = !DILocation(line: 89, column: 20, scope: !216)
!216 = distinct !DILexicalBlock(scope: !206, file: !1, line: 89, column: 20)
!217 = !DILocation(line: 89, column: 34, scope: !216)
!218 = !DILocation(line: 89, column: 39, scope: !216)
!219 = !DILocation(line: 89, column: 45, scope: !216)
!220 = !DILocation(line: 89, column: 44, scope: !216)
!221 = !DILocation(line: 89, column: 20, scope: !206)
!222 = !DILocation(line: 90, column: 35, scope: !223)
!223 = distinct !DILexicalBlock(scope: !216, file: !1, line: 89, column: 61)
!224 = !DILocation(line: 90, column: 25, scope: !223)
!225 = !DILocation(line: 90, column: 23, scope: !223)
!226 = !DILocation(line: 91, column: 23, scope: !227)
!227 = distinct !DILexicalBlock(scope: !223, file: !1, line: 91, column: 23)
!228 = !DILocation(line: 91, column: 40, scope: !227)
!229 = !DILocation(line: 91, column: 44, scope: !227)
!230 = !DILocation(line: 91, column: 23, scope: !223)
!231 = !DILocation(line: 93, column: 29, scope: !227)
!232 = !DILocation(line: 93, column: 33, scope: !227)
!233 = !DILocation(line: 93, column: 38, scope: !227)
!234 = !DILocation(line: 93, column: 43, scope: !227)
!235 = !DILocation(line: 93, column: 52, scope: !227)
!236 = !DILocation(line: 93, column: 59, scope: !227)
!237 = !DILocation(line: 93, column: 65, scope: !227)
!238 = !DILocation(line: 93, column: 74, scope: !227)
!239 = !DILocation(line: 93, column: 63, scope: !227)
!240 = !DILocation(line: 94, column: 35, scope: !227)
!241 = !DILocation(line: 94, column: 41, scope: !227)
!242 = !DILocation(line: 94, column: 50, scope: !227)
!243 = !DILocation(line: 94, column: 39, scope: !227)
!244 = !DILocation(line: 94, column: 30, scope: !227)
!245 = !DILocation(line: 94, column: 56, scope: !227)
!246 = !DILocation(line: 94, column: 65, scope: !227)
!247 = !DILocation(line: 94, column: 55, scope: !227)
!248 = !DILocation(line: 94, column: 72, scope: !227)
!249 = !DILocation(line: 92, column: 22, scope: !227)
!250 = !DILocation(line: 95, column: 23, scope: !251)
!251 = distinct !DILexicalBlock(scope: !223, file: !1, line: 95, column: 23)
!252 = !DILocation(line: 95, column: 31, scope: !251)
!253 = !DILocation(line: 95, column: 34, scope: !251)
!254 = !DILocation(line: 95, column: 38, scope: !251)
!255 = !DILocation(line: 95, column: 23, scope: !223)
!256 = !DILocation(line: 96, column: 31, scope: !257)
!257 = distinct !DILexicalBlock(scope: !251, file: !1, line: 96, column: 26)
!258 = !DILocation(line: 96, column: 37, scope: !257)
!259 = !DILocation(line: 96, column: 46, scope: !257)
!260 = !DILocation(line: 96, column: 35, scope: !257)
!261 = !DILocation(line: 96, column: 26, scope: !257)
!262 = !DILocation(line: 96, column: 52, scope: !257)
!263 = !DILocation(line: 96, column: 61, scope: !257)
!264 = !DILocation(line: 96, column: 51, scope: !257)
!265 = !DILocation(line: 96, column: 68, scope: !257)
!266 = !DILocation(line: 96, column: 66, scope: !257)
!267 = !DILocation(line: 96, column: 26, scope: !251)
!268 = !DILocation(line: 97, column: 30, scope: !269)
!269 = distinct !DILexicalBlock(scope: !270, file: !1, line: 97, column: 29)
!270 = distinct !DILexicalBlock(scope: !257, file: !1, line: 96, column: 73)
!271 = !DILocation(line: 97, column: 29, scope: !270)
!272 = !DILocation(line: 98, column: 104, scope: !269)
!273 = !DILocation(line: 98, column: 108, scope: !269)
!274 = !DILocation(line: 98, column: 113, scope: !269)
!275 = !DILocation(line: 98, column: 122, scope: !269)
!276 = !DILocation(line: 98, column: 128, scope: !269)
!277 = !DILocation(line: 98, column: 28, scope: !269)
!278 = !DILocation(line: 99, column: 28, scope: !270)
!279 = !DILocation(line: 101, column: 35, scope: !223)
!280 = !DILocation(line: 101, column: 19, scope: !223)
!281 = !DILocation(line: 101, column: 28, scope: !223)
!282 = !DILocation(line: 101, column: 33, scope: !223)
!283 = !DILocation(line: 102, column: 16, scope: !223)
!284 = !DILocation(line: 103, column: 21, scope: !206)
!285 = !DILocation(line: 103, column: 19, scope: !206)
!286 = !DILocation(line: 104, column: 32, scope: !206)
!287 = !DILocation(line: 104, column: 37, scope: !206)
!288 = !DILocation(line: 104, column: 35, scope: !206)
!289 = !DILocation(line: 104, column: 29, scope: !206)
!290 = !DILocation(line: 105, column: 13, scope: !206)
!291 = !DILocation(line: 79, column: 57, scope: !199)
!292 = !DILocation(line: 79, column: 13, scope: !199)
!293 = distinct !{!293, !204, !294, !295}
!294 = !DILocation(line: 105, column: 13, scope: !195)
!295 = !{!"llvm.loop.mustprogress"}
!296 = !DILocation(line: 106, column: 10, scope: !169)
!297 = !DILocation(line: 70, column: 53, scope: !163)
!298 = !DILocation(line: 70, column: 50, scope: !163)
!299 = !DILocation(line: 70, column: 10, scope: !163)
!300 = distinct !{!300, !166, !301, !295}
!301 = !DILocation(line: 106, column: 10, scope: !160)
!302 = !DILocation(line: 107, column: 7, scope: !141)
!303 = !DILocation(line: 64, column: 49, scope: !136)
!304 = !DILocation(line: 64, column: 62, scope: !136)
!305 = !DILocation(line: 64, column: 75, scope: !136)
!306 = !DILocation(line: 64, column: 7, scope: !136)
!307 = distinct !{!307, !139, !308, !295}
!308 = !DILocation(line: 107, column: 7, scope: !132)
!309 = !DILocation(line: 109, column: 11, scope: !310)
!310 = distinct !DILexicalBlock(scope: !133, file: !1, line: 109, column: 11)
!311 = !DILocation(line: 109, column: 22, scope: !310)
!312 = !DILocation(line: 109, column: 26, scope: !310)
!313 = !DILocation(line: 109, column: 11, scope: !133)
!314 = !DILocation(line: 110, column: 15, scope: !315)
!315 = distinct !DILexicalBlock(scope: !310, file: !1, line: 109, column: 42)
!316 = !DILocation(line: 110, column: 10, scope: !315)
!317 = !DILocation(line: 111, column: 16, scope: !318)
!318 = distinct !DILexicalBlock(scope: !315, file: !1, line: 111, column: 14)
!319 = !DILocation(line: 111, column: 19, scope: !318)
!320 = !DILocation(line: 111, column: 18, scope: !318)
!321 = !DILocation(line: 111, column: 14, scope: !315)
!322 = !DILocation(line: 112, column: 20, scope: !318)
!323 = !DILocation(line: 112, column: 13, scope: !318)
!324 = !DILocation(line: 113, column: 7, scope: !315)
!325 = !DILocation(line: 114, column: 12, scope: !133)
!326 = !DILocation(line: 114, column: 10, scope: !133)
!327 = !DILocation(line: 115, column: 27, scope: !133)
!328 = !DILocation(line: 115, column: 32, scope: !133)
!329 = !DILocation(line: 115, column: 30, scope: !133)
!330 = !DILocation(line: 115, column: 24, scope: !133)
!331 = !DILocation(line: 117, column: 12, scope: !133)
!332 = !DILocation(line: 117, column: 10, scope: !133)
!333 = !DILocation(line: 118, column: 11, scope: !334)
!334 = distinct !DILexicalBlock(scope: !133, file: !1, line: 118, column: 11)
!335 = !DILocation(line: 118, column: 21, scope: !334)
!336 = !DILocation(line: 118, column: 26, scope: !334)
!337 = !DILocation(line: 118, column: 29, scope: !334)
!338 = !DILocation(line: 118, column: 28, scope: !334)
!339 = !DILocation(line: 118, column: 11, scope: !133)
!340 = !DILocation(line: 119, column: 15, scope: !334)
!341 = !DILocation(line: 119, column: 10, scope: !334)
!342 = !DILocation(line: 120, column: 21, scope: !133)
!343 = !DILocation(line: 120, column: 31, scope: !133)
!344 = !DILocation(line: 120, column: 29, scope: !133)
!345 = !DILocation(line: 120, column: 18, scope: !133)
!346 = !DILocation(line: 122, column: 11, scope: !347)
!347 = distinct !DILexicalBlock(scope: !133, file: !1, line: 122, column: 11)
!348 = !DILocation(line: 122, column: 11, scope: !133)
!349 = !DILocation(line: 123, column: 18, scope: !350)
!350 = distinct !DILexicalBlock(scope: !347, file: !1, line: 122, column: 21)
!351 = !DILocation(line: 123, column: 16, scope: !350)
!352 = !DILocation(line: 124, column: 14, scope: !353)
!353 = distinct !DILexicalBlock(scope: !350, file: !1, line: 124, column: 14)
!354 = !DILocation(line: 124, column: 26, scope: !353)
!355 = !DILocation(line: 124, column: 23, scope: !353)
!356 = !DILocation(line: 124, column: 14, scope: !350)
!357 = !DILocation(line: 125, column: 18, scope: !353)
!358 = !DILocation(line: 125, column: 13, scope: !353)
!359 = !DILocation(line: 127, column: 25, scope: !353)
!360 = !DILocation(line: 127, column: 22, scope: !353)
!361 = !DILocation(line: 128, column: 7, scope: !350)
!362 = !DILocation(line: 129, column: 14, scope: !363)
!363 = distinct !DILexicalBlock(scope: !347, file: !1, line: 129, column: 14)
!364 = !DILocation(line: 129, column: 20, scope: !363)
!365 = !DILocation(line: 129, column: 17, scope: !363)
!366 = !DILocation(line: 129, column: 14, scope: !347)
!367 = !DILocation(line: 130, column: 18, scope: !363)
!368 = !DILocation(line: 130, column: 13, scope: !363)
!369 = !DILocation(line: 131, column: 4, scope: !133)
!370 = !DILocation(line: 63, column: 75, scope: !128)
!371 = !DILocation(line: 63, column: 4, scope: !128)
!372 = distinct !{!372, !130, !373, !295}
!373 = !DILocation(line: 131, column: 4, scope: !121)
!374 = !DILocation(line: 133, column: 15, scope: !11)
!375 = !DILocation(line: 133, column: 13, scope: !11)
!376 = !DILocation(line: 134, column: 17, scope: !11)
!377 = !DILocation(line: 134, column: 20, scope: !11)
!378 = !DILocation(line: 134, column: 15, scope: !11)
!379 = !DILocation(line: 135, column: 16, scope: !11)
!380 = !DILocation(line: 135, column: 26, scope: !11)
!381 = !DILocation(line: 135, column: 24, scope: !11)
!382 = !DILocation(line: 135, column: 14, scope: !11)
!383 = !DILocation(line: 136, column: 1, scope: !11)
!384 = distinct !DISubprogram(name: "calc_time_step", scope: !1, file: !1, line: 142, type: !385, scopeLine: 143, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!385 = !DISubroutineType(types: !3)
!386 = !DILocalVariable(name: "o", scope: !384, file: !1, line: 144, type: !15)
!387 = !DILocation(line: 144, column: 8, scope: !384)
!388 = !DILocalVariable(name: "dir", scope: !384, file: !1, line: 144, type: !15)
!389 = !DILocation(line: 144, column: 11, scope: !384)
!390 = !DILocalVariable(name: "done", scope: !384, file: !1, line: 144, type: !15)
!391 = !DILocation(line: 144, column: 16, scope: !384)
!392 = !DILocalVariable(name: "delta", scope: !384, file: !1, line: 145, type: !4)
!393 = !DILocation(line: 145, column: 11, scope: !384)
!394 = !DILocalVariable(name: "tmp", scope: !384, file: !1, line: 145, type: !4)
!395 = !DILocation(line: 145, column: 18, scope: !384)
!396 = !DILocalVariable(name: "inv_cell_size", scope: !384, file: !1, line: 145, type: !397)
!397 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 192, elements: !73)
!398 = !DILocation(line: 145, column: 23, scope: !384)
!399 = !DILocalVariable(name: "op", scope: !384, file: !1, line: 146, type: !400)
!400 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !401, size: 64)
!401 = !DIDerivedType(tag: DW_TAG_typedef, name: "object", file: !50, line: 138, baseType: !402)
!402 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !50, line: 128, size: 1408, elements: !403)
!403 = !{!404, !405, !406, !407, !408, !409, !410, !411, !412}
!404 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !402, file: !50, line: 129, baseType: !15, size: 32)
!405 = !DIDerivedType(tag: DW_TAG_member, name: "bounce", scope: !402, file: !50, line: 130, baseType: !15, size: 32, offset: 32)
!406 = !DIDerivedType(tag: DW_TAG_member, name: "cen", scope: !402, file: !50, line: 131, baseType: !397, size: 192, offset: 64)
!407 = !DIDerivedType(tag: DW_TAG_member, name: "orig_cen", scope: !402, file: !50, line: 132, baseType: !397, size: 192, offset: 256)
!408 = !DIDerivedType(tag: DW_TAG_member, name: "move", scope: !402, file: !50, line: 133, baseType: !397, size: 192, offset: 448)
!409 = !DIDerivedType(tag: DW_TAG_member, name: "orig_move", scope: !402, file: !50, line: 134, baseType: !397, size: 192, offset: 640)
!410 = !DIDerivedType(tag: DW_TAG_member, name: "size", scope: !402, file: !50, line: 135, baseType: !397, size: 192, offset: 832)
!411 = !DIDerivedType(tag: DW_TAG_member, name: "orig_size", scope: !402, file: !50, line: 136, baseType: !397, size: 192, offset: 1024)
!412 = !DIDerivedType(tag: DW_TAG_member, name: "inc", scope: !402, file: !50, line: 137, baseType: !397, size: 192, offset: 1216)
!413 = !DILocation(line: 146, column: 12, scope: !384)
!414 = !DILocation(line: 148, column: 33, scope: !384)
!415 = !DILocation(line: 148, column: 46, scope: !384)
!416 = !DILocation(line: 148, column: 45, scope: !384)
!417 = !DILocation(line: 148, column: 23, scope: !384)
!418 = !DILocation(line: 148, column: 4, scope: !384)
!419 = !DILocation(line: 148, column: 21, scope: !384)
!420 = !DILocation(line: 149, column: 33, scope: !384)
!421 = !DILocation(line: 149, column: 46, scope: !384)
!422 = !DILocation(line: 149, column: 45, scope: !384)
!423 = !DILocation(line: 149, column: 23, scope: !384)
!424 = !DILocation(line: 149, column: 4, scope: !384)
!425 = !DILocation(line: 149, column: 21, scope: !384)
!426 = !DILocation(line: 150, column: 33, scope: !384)
!427 = !DILocation(line: 150, column: 46, scope: !384)
!428 = !DILocation(line: 150, column: 45, scope: !384)
!429 = !DILocation(line: 150, column: 23, scope: !384)
!430 = !DILocation(line: 150, column: 4, scope: !384)
!431 = !DILocation(line: 150, column: 21, scope: !384)
!432 = !DILocation(line: 151, column: 10, scope: !384)
!433 = !DILocation(line: 152, column: 11, scope: !434)
!434 = distinct !DILexicalBlock(scope: !384, file: !1, line: 152, column: 4)
!435 = !DILocation(line: 152, column: 9, scope: !434)
!436 = !DILocation(line: 152, column: 16, scope: !437)
!437 = distinct !DILexicalBlock(scope: !434, file: !1, line: 152, column: 4)
!438 = !DILocation(line: 152, column: 20, scope: !437)
!439 = !DILocation(line: 152, column: 18, scope: !437)
!440 = !DILocation(line: 152, column: 4, scope: !434)
!441 = !DILocation(line: 153, column: 13, scope: !442)
!442 = distinct !DILexicalBlock(scope: !437, file: !1, line: 152, column: 38)
!443 = !DILocation(line: 153, column: 21, scope: !442)
!444 = !DILocation(line: 153, column: 10, scope: !442)
!445 = !DILocation(line: 154, column: 11, scope: !446)
!446 = distinct !DILexicalBlock(scope: !442, file: !1, line: 154, column: 11)
!447 = !DILocation(line: 154, column: 15, scope: !446)
!448 = !DILocation(line: 154, column: 23, scope: !446)
!449 = !DILocation(line: 154, column: 29, scope: !446)
!450 = !DILocation(line: 154, column: 32, scope: !446)
!451 = !DILocation(line: 154, column: 36, scope: !446)
!452 = !DILocation(line: 154, column: 44, scope: !446)
!453 = !DILocation(line: 154, column: 50, scope: !446)
!454 = !DILocation(line: 154, column: 53, scope: !446)
!455 = !DILocation(line: 154, column: 57, scope: !446)
!456 = !DILocation(line: 154, column: 65, scope: !446)
!457 = !DILocation(line: 154, column: 11, scope: !442)
!458 = !DILocation(line: 155, column: 10, scope: !446)
!459 = !DILocation(line: 156, column: 23, scope: !460)
!460 = distinct !DILexicalBlock(scope: !442, file: !1, line: 156, column: 7)
!461 = !DILocation(line: 156, column: 17, scope: !460)
!462 = !DILocation(line: 156, column: 12, scope: !460)
!463 = !DILocation(line: 156, column: 28, scope: !464)
!464 = distinct !DILexicalBlock(scope: !460, file: !1, line: 156, column: 7)
!465 = !DILocation(line: 156, column: 32, scope: !464)
!466 = !DILocation(line: 156, column: 7, scope: !460)
!467 = !DILocation(line: 157, column: 14, scope: !468)
!468 = distinct !DILexicalBlock(scope: !464, file: !1, line: 157, column: 14)
!469 = !DILocation(line: 157, column: 18, scope: !468)
!470 = !DILocation(line: 157, column: 22, scope: !468)
!471 = !DILocation(line: 157, column: 27, scope: !468)
!472 = !DILocation(line: 157, column: 14, scope: !464)
!473 = !DILocation(line: 158, column: 17, scope: !474)
!474 = distinct !DILexicalBlock(scope: !475, file: !1, line: 158, column: 17)
!475 = distinct !DILexicalBlock(scope: !468, file: !1, line: 157, column: 34)
!476 = !DILocation(line: 158, column: 21, scope: !474)
!477 = !DILocation(line: 158, column: 25, scope: !474)
!478 = !DILocation(line: 158, column: 32, scope: !474)
!479 = !DILocation(line: 158, column: 36, scope: !474)
!480 = !DILocation(line: 158, column: 41, scope: !474)
!481 = !DILocation(line: 158, column: 30, scope: !474)
!482 = !DILocation(line: 158, column: 46, scope: !474)
!483 = !DILocation(line: 158, column: 17, scope: !475)
!484 = !DILocation(line: 159, column: 21, scope: !474)
!485 = !DILocation(line: 159, column: 16, scope: !474)
!486 = !DILocation(line: 160, column: 10, scope: !475)
!487 = !DILocation(line: 160, column: 21, scope: !488)
!488 = distinct !DILexicalBlock(scope: !468, file: !1, line: 160, column: 21)
!489 = !DILocation(line: 160, column: 25, scope: !488)
!490 = !DILocation(line: 160, column: 29, scope: !488)
!491 = !DILocation(line: 160, column: 34, scope: !488)
!492 = !DILocation(line: 160, column: 21, scope: !468)
!493 = !DILocation(line: 161, column: 17, scope: !494)
!494 = distinct !DILexicalBlock(scope: !495, file: !1, line: 161, column: 17)
!495 = distinct !DILexicalBlock(scope: !488, file: !1, line: 160, column: 41)
!496 = !DILocation(line: 161, column: 21, scope: !494)
!497 = !DILocation(line: 161, column: 25, scope: !494)
!498 = !DILocation(line: 161, column: 32, scope: !494)
!499 = !DILocation(line: 161, column: 36, scope: !494)
!500 = !DILocation(line: 161, column: 41, scope: !494)
!501 = !DILocation(line: 161, column: 30, scope: !494)
!502 = !DILocation(line: 161, column: 46, scope: !494)
!503 = !DILocation(line: 161, column: 17, scope: !495)
!504 = !DILocation(line: 162, column: 21, scope: !494)
!505 = !DILocation(line: 162, column: 16, scope: !494)
!506 = !DILocation(line: 163, column: 10, scope: !495)
!507 = !DILocation(line: 157, column: 29, scope: !468)
!508 = !DILocation(line: 156, column: 40, scope: !464)
!509 = !DILocation(line: 156, column: 7, scope: !464)
!510 = distinct !{!510, !466, !511, !295}
!511 = !DILocation(line: 163, column: 10, scope: !460)
!512 = !DILocation(line: 164, column: 11, scope: !513)
!513 = distinct !DILexicalBlock(scope: !442, file: !1, line: 164, column: 11)
!514 = !DILocation(line: 164, column: 11, scope: !442)
!515 = !DILocation(line: 165, column: 10, scope: !513)
!516 = !DILocation(line: 166, column: 23, scope: !517)
!517 = distinct !DILexicalBlock(scope: !442, file: !1, line: 166, column: 7)
!518 = !DILocation(line: 166, column: 17, scope: !517)
!519 = !DILocation(line: 166, column: 12, scope: !517)
!520 = !DILocation(line: 166, column: 28, scope: !521)
!521 = distinct !DILexicalBlock(scope: !517, file: !1, line: 166, column: 7)
!522 = !DILocation(line: 166, column: 32, scope: !521)
!523 = !DILocation(line: 166, column: 7, scope: !517)
!524 = !DILocation(line: 167, column: 22, scope: !525)
!525 = distinct !DILexicalBlock(scope: !521, file: !1, line: 166, column: 44)
!526 = !DILocation(line: 167, column: 26, scope: !525)
!527 = !DILocation(line: 167, column: 31, scope: !525)
!528 = !DILocation(line: 167, column: 17, scope: !525)
!529 = !DILocation(line: 167, column: 44, scope: !525)
!530 = !DILocation(line: 167, column: 48, scope: !525)
!531 = !DILocation(line: 167, column: 52, scope: !525)
!532 = !DILocation(line: 167, column: 39, scope: !525)
!533 = !DILocation(line: 167, column: 37, scope: !525)
!534 = !DILocation(line: 167, column: 73, scope: !525)
!535 = !DILocation(line: 167, column: 59, scope: !525)
!536 = !DILocation(line: 167, column: 58, scope: !525)
!537 = !DILocation(line: 167, column: 14, scope: !525)
!538 = !DILocation(line: 168, column: 14, scope: !539)
!539 = distinct !DILexicalBlock(scope: !525, file: !1, line: 168, column: 14)
!540 = !DILocation(line: 168, column: 20, scope: !539)
!541 = !DILocation(line: 168, column: 18, scope: !539)
!542 = !DILocation(line: 168, column: 14, scope: !525)
!543 = !DILocation(line: 169, column: 21, scope: !539)
!544 = !DILocation(line: 169, column: 19, scope: !539)
!545 = !DILocation(line: 169, column: 13, scope: !539)
!546 = !DILocation(line: 170, column: 7, scope: !525)
!547 = !DILocation(line: 166, column: 40, scope: !521)
!548 = !DILocation(line: 166, column: 7, scope: !521)
!549 = distinct !{!549, !523, !550, !295}
!550 = !DILocation(line: 170, column: 7, scope: !517)
!551 = !DILocation(line: 171, column: 4, scope: !442)
!552 = !DILocation(line: 152, column: 34, scope: !437)
!553 = !DILocation(line: 152, column: 4, scope: !437)
!554 = distinct !{!554, !440, !555, !295}
!555 = !DILocation(line: 171, column: 4, scope: !434)
!556 = !DILocation(line: 173, column: 8, scope: !557)
!557 = distinct !DILexicalBlock(scope: !384, file: !1, line: 173, column: 8)
!558 = !DILocation(line: 173, column: 14, scope: !557)
!559 = !DILocation(line: 173, column: 8, scope: !384)
!560 = !DILocation(line: 174, column: 19, scope: !557)
!561 = !DILocation(line: 174, column: 18, scope: !557)
!562 = !DILocation(line: 174, column: 13, scope: !557)
!563 = !DILocation(line: 174, column: 7, scope: !557)
!564 = !DILocation(line: 176, column: 13, scope: !557)
!565 = !DILocation(line: 178, column: 11, scope: !384)
!566 = !DILocation(line: 178, column: 4, scope: !384)
