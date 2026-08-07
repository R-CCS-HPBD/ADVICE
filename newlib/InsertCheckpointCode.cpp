    //
    // Created by KLzhang on 2024-01-05.
    //

    #include "llvm/Pass.h"

    #include "llvm/IR/IRBuilder.h"
    #include "llvm/IR/Value.h"

    #include "llvm/IR/Module.h"
    #include "llvm/IR/Function.h"
    #include "llvm/IR/Instruction.h"
    #include "llvm/IR/Instructions.h"
    #include "llvm/IR/BasicBlock.h"
    #include <llvm/IR/Constants.h>
    #include <llvm/IR/GlobalVariable.h>
    #include <llvm/IR/DerivedTypes.h>
    #include "llvm/IR/SymbolTableListTraits.h"
    #include "llvm/IR/ValueSymbolTable.h"

    #include "llvm/IR/DebugLoc.h"
    #include "llvm/IR/DebugInfo.h"
    #include "llvm/Support/Debug.h"
    #include "llvm/Support/Casting.h"


    #include "llvm/Analysis/LoopPass.h"
    #include "llvm/Analysis/LoopInfo.h"

    #include "llvm/Support/CommandLine.h"
    #include "llvm/Support/SourceMgr.h"
    #include "llvm/Support/raw_ostream.h"

    #include <sstream>
    #include <cstdint>
    #include <fstream>
    #include <iostream>
    #include <vector>
    #include <map>
    #include <utility>
    #include <string>
    #include <set>

    #include "CheckerPaths.h"

    using namespace llvm;

    #define VELOC_SUCCESS (0)
    #define VELOC_FAILURE (-1)
    #define VELOC_IGNORED (-2)

    extern "C" {
    void* malloc(size_t);
    }

    namespace {
        struct InsertCheckpointCode : public FunctionPass {
            static char ID;
            int mainloopbegin = 0;
            int mainloopend = 0;
            std::string mainLoopFuncName;

            int selectId;/// 0 R_w , 1 FTI  ,2 VeloC
            std::string iter_name;

            ///global
            GlobalVariable *cpc_Rank;
            GlobalVariable *cpc_Loc;

            /// update global
            GlobalVariable *cpc_Iter;

            Function *readCpFunc;
            Function *writeCpFunc;


            ///FTI
            Function *fti_protect;
            Function *fti_init;
            Function *fti_status;
            Function *fti_recover;
            Function *fti_checkpoint;
            Function *fti_finalize;

            ///FTIT_type
            GlobalVariable *FTIDBLE; ///double
            GlobalVariable *FTIINTG; ///int
            GlobalVariable *FTILONG; ///long
            GlobalVariable *FTILDBE; ///float


            /// VeloC 2 ==============================
            Function *VELOC_Mem_protect;
            Function *VELOC_Restart_test;
            Function *VELOC_Checkpoint;
            Function *VELOC_Restart;
            Function *assertFunc ;
            GlobalVariable *vrt;


            Constant *skptStr;

            void loadFromFileToMainLoop();
            void loadFromFileToCpVars();
            void loadFromFileToCPCode();///加载选择CP的code

            void findCpVarsAlloca();

            void findCpVarsAlloca(Module& M);
            void insertCheckpointCode(Module& M);
            void dCPCVar(Module& M);

            std::string getTypeToString(Type* valType);
            Type* getBaseElementType(Type *Ty);
            Value* rtTypeSize(std::string type,LLVMContext &Context);

            unsigned vReByte(std::string vtype,unsigned elems);

            struct cpNode{
                std::string vname;
                std::string fname;
                std::string vtype;///实际类型

                std::string vvname="";
                int isArray = 0;
                int ispoiArr = 0;
                unsigned elemsTotal = 1;///元素个数

                unsigned bytes = 0;///字节数
                Value* v = NULL;
            };

            std::set<std::string>cpFnames;
            std::map<std::string ,cpNode>cpVarsMap;///存储所有的cp变量

            std::string FILELIB = cher_dataDir();
    //        std::vector<cpNode>cpVarsMap;

            InsertCheckpointCode() : FunctionPass(ID) {}
            void getAnalysisUsage(AnalysisUsage& AU) const override {
                AU.setPreservesAll();
                AU.addRequired<LoopInfoWrapperPass>();
            }

            bool runOnFunction(Function& F);
            bool doInitialization(Module& M);
        };

    }

    void InsertCheckpointCode::dCPCVar(Module& M){
        LLVMContext &Context = M.getContext();
        Type *Int32Ty = Type::getInt32Ty(Context);

        ///创建全局变量 rank、location
        // 创建全局变量 cpc_Rank
        cpc_Rank = new GlobalVariable(M, Int32Ty, false,GlobalValue::ExternalLinkage, nullptr, "cpc_Rank");
        cpc_Rank->setInitializer(ConstantInt::get(Int32Ty, 0)); // 初始化为 0
        // 创建全局变量 cpc_Loc
        cpc_Loc = new GlobalVariable(M, Int32Ty, false,
                                     GlobalValue::ExternalLinkage, nullptr, "cpc_Loc");
        cpc_Loc->setInitializer(ConstantInt::get(Int32Ty, 0)); // 初始化为 0


        if(0 == selectId){
            ///找到write_cp和read_cp
            readCpFunc = M.getFunction("read_cp");
            writeCpFunc = M.getFunction("write_cp");
        }

        if(1 == selectId){
            ///FTI

            ///声明FTI函数
            // FTI_Protect 函数声明
            FunctionType* fti_protect_type = FunctionType::get(Type::getInt32Ty(Context), {Type::getInt32Ty(Context), Type::getInt8PtrTy(Context), Type::getInt64Ty(Context), Type::getInt32Ty(Context)}, false);
            Function::Create(fti_protect_type, Function::ExternalLinkage, "FTI_Protect", M); ///InternalLinkage 代表具有本地链接

            // FTI_Checkpoint 函数声明
            FunctionType* fti_checkpoint_type = FunctionType::get(Type::getInt32Ty(Context), {Type::getInt32Ty(Context), Type::getInt32Ty(Context)}, false);
            Function::Create(fti_checkpoint_type, Function::ExternalLinkage, "FTI_Checkpoint", M);

            // FTI_Status 函数声明
            FunctionType* fti_status_type = FunctionType::get(Type::getInt32Ty(Context), {}, false);
            Function::Create(fti_status_type, Function::ExternalLinkage, "FTI_Status", M);

            // FTI_Recover 函数声明
            FunctionType* fti_recover_type = FunctionType::get(Type::getInt32Ty(Context), {}, false);
            Function::Create(fti_recover_type, Function::ExternalLinkage, "FTI_Recover", M);


            ///全局变量声明
            //        FTIDBLE = M.getGlobalVariable("FTIINTG");
            FTIDBLE = dyn_cast<GlobalVariable>(M.getOrInsertGlobal("FTI_DBLE", Type::getInt32Ty(Context)));
            FTIINTG = dyn_cast<GlobalVariable>(M.getOrInsertGlobal("FTI_INTG", Type::getInt32Ty(Context)));
            FTILONG = dyn_cast<GlobalVariable>(M.getOrInsertGlobal("FTI_LONG", Type::getInt32Ty(Context)));
            FTILDBE = dyn_cast<GlobalVariable>(M.getOrInsertGlobal("FTI_LDBE", Type::getInt32Ty(Context)));

            fti_protect = M.getFunction("FTI_Protect"); /// before
            fti_status = M.getFunction("FTI_Status"); ///before
            fti_recover = M.getFunction("FTI_Recover");///before
            fti_checkpoint = M.getFunction("FTI_Checkpoint");///in




        }
        if(2 == selectId) {
            /// 声明 VELOC_Mem_protect 函数
            FunctionType *mem_protect_type = FunctionType::get(Type::getInt32Ty(Context),
                                                               {Type::getInt32Ty(Context), Type::getInt8PtrTy(Context),
                                                                Type::getInt64Ty(Context), Type::getInt32Ty(Context)},
                                                               false);
            Function::Create(mem_protect_type, Function::ExternalLinkage, "VELOC_Mem_protect", M);

            /// 声明 VELOC_Restart_test 函数
            FunctionType *restart_test_type = FunctionType::get(Type::getInt32Ty(Context),
                                                                {Type::getInt8PtrTy(Context),
                                                                 Type::getInt32Ty(Context)},
                                                                false);
            Function::Create(restart_test_type, Function::ExternalLinkage, "VELOC_Restart_test", M);

            /// 声明 VELOC_Restart 函数
            FunctionType *restart_type = FunctionType::get(Type::getInt32Ty(Context),
                                                           {Type::getInt8PtrTy(Context), Type::getInt32Ty(Context)},
                                                           false);
            Function::Create(restart_type, Function::ExternalLinkage, "VELOC_Restart", M);

            /// 声明 VELOC_Checkpoint 函数
            FunctionType *checkpoint_type = FunctionType::get(Type::getInt32Ty(Context),
                                                              {Type::getInt8PtrTy(Context), Type::getInt32Ty(Context)},
                                                              false);
            Function::Create(checkpoint_type, Function::ExternalLinkage, "VELOC_Checkpoint", M);


            vrt = new GlobalVariable(M, Int32Ty, false,
                                          GlobalValue::ExternalLinkage, nullptr, "vc_vrt");


            VELOC_Mem_protect = M.getFunction("VELOC_Mem_protect");///in
            VELOC_Restart_test = M.getFunction("VELOC_Restart_test");///in
            VELOC_Restart = M.getFunction("VELOC_Restart");///in
            VELOC_Checkpoint = M.getFunction("VELOC_Checkpoint");///in

            assertFunc = Intrinsic::getDeclaration(&M, Intrinsic::dbg_declare);


        }
    }
    void InsertCheckpointCode::loadFromFileToCPCode(){
        std::string filename = FILELIB+"selectCpCode.txt";
        std::ifstream file(filename);
        if (file.is_open()) {
            std::string line;
            if (std::getline(file, line)) {
                selectId = std::stoi(line);
            }
            if (std::getline(file, line)) {
                iter_name = line;
            }
            errs()<<selectId<<" ===  "<<iter_name<<"\n";
            file.close();
        }
    }

    void InsertCheckpointCode::loadFromFileToMainLoop() {
        std::string filename = FILELIB+"mainloopData.txt";
        std::ifstream file(filename);
        if (file.is_open()) {
            std::string line;
            //获取main loop所在的范围
            if (std::getline(file, line)) {
                //errs() << "the line is " << line << "\n";
                std::string str = "";
                for (int i = 0; i < line.size(); ++i) {
                    if (line[i] != ',') str += line[i];
                    else {
                        mainloopbegin = std::stoi(str);
                        str = "";
                    }
                }
                mainloopend = std::stoi(str);
            }
            //获取main loop所在的文件名
            if (std::getline(file, line)) {
                mainLoopFuncName = line;
            }
            cpFnames.insert(mainLoopFuncName);
            file.close();
        }
    //    errs() << mainLoopFuncName << "\n";
    }

    void InsertCheckpointCode::loadFromFileToCpVars() {
        std::string filename = FILELIB+"CpVar.txt";
        std::ifstream file(filename);
        if (file.is_open()) {
            std::string line;
            while (std::getline(file, line)) {
                std::stringstream ss(line);
                std::string token;
                std::vector<std::string> tokens;
                while (std::getline(ss, token, ',')) {
                    tokens.push_back(token);
                    //printf("%s\t", token.c_str());
                }
                if (tokens.size() == 4) {
                    std::string fname = tokens[0];
                    std::string vname = tokens[1];
                    std::string vtype = tokens[2];
                    unsigned elemsTotal = std::stoi(tokens[3]);
                    cpNode ce ;
                    ce.fname = fname;
                    ce.vname = vname;
                    ce.vtype = vtype;
                    ce.elemsTotal = elemsTotal;
                    if(vtype == "array") ce.isArray = 1;
                    if(vtype == "pointer") ce.ispoiArr = 1;

                    ///初始化cpVarsMap
                    cpVarsMap[vname] = ce;
                    cpFnames.insert(fname);



    //                errs()<<fname<<","<<vname<<","<<vtype<<","<<elemsTotal<<"\n";
                }
            }
            file.close();
        }



        filename = FILELIB+"cpVarConn.txt";
        std::ifstream file1(filename);
        /// fname ,vname ,vvname
        if (file1.is_open()) {
            std::string line;
            while (std::getline(file1, line)) {
                std::stringstream ss(line);
                std::string token;
                std::vector<std::string> tokens;
                while (std::getline(ss, token, ',')) {
                    tokens.push_back(token);
                    //printf("%s\t", token.c_str());
                }
                if (tokens.size() == 3) {
                    std::string fname = tokens[0];
                    std::string vname = tokens[1];
                    std::string vvname = tokens[2];
                    cpVarsMap[vname].vvname = vvname;

                    cpNode ce = cpVarsMap[vname];
                    ce.fname = mainLoopFuncName;
                    ce.vname = vvname;
                    cpVarsMap[vvname] = ce;
    //                errs()<<vname<<" 1====1 "<<vvname<<"\n";
                }
            }
            file1.close();
        }


    }

    void InsertCheckpointCode::findCpVarsAlloca(Module& M) {
        const DataLayout& DL = M.getDataLayout();
        LLVMContext &Context = M.getContext();
        IRBuilder<> Builder(Context);

//        FTIDBLE = M.getGlobalVariable("FTI_DBLE");


        ///全局变量
        for (auto& G : M.getGlobalList()) {
            if (G.hasInitializer()) {
                std::string name = G.getName().str();

                ///main loop iter[index]
                if(name == iter_name){
                    cpc_Iter = &G;
                }

                ///与对应的Cp变量匹配
                if(cpVarsMap.count(name)&&cpVarsMap[name].fname == "GlobalVar"){
                    ///存在当前变量

                    ///double x;
                    cpVarsMap[name].v = &G;

                    Type *vType = G.getValueType();
                    Type *eType = getBaseElementType(vType); ///元素类型
                    cpVarsMap[name].vtype = getTypeToString(eType);
                    ///结构体
    //                errs()<<cpVarsMap[name].vtype<<"\n";
                    if(cpVarsMap[name].vtype == "struct"){
                        if (StructType* StructTy = dyn_cast<StructType>(eType)) {
                            unsigned StructSize = DL.getTypeAllocSize(StructTy);
                            cpVarsMap[name].bytes = StructSize * cpVarsMap[name].elemsTotal;
    //                        errs()<<cpVarsMap[name].bytes<<"\n";
                        }
                    }
                    if(cpVarsMap[name].elemsTotal > 1 && !cpVarsMap[name].ispoiArr){
                        ///double *x,double *y
                        cpVarsMap[name].v = Builder.CreateBitCast(&G, Type::getInt8PtrTy(Context));
                    }
    /*                if(cpVarsMap[name].vtype == "pointer"){
                        if (PointerType *ptrType = dyn_cast<PointerType>(vType)) {
                            Type *elementType = ptrType->getElementType();
                            std::string vtype = getTypeToString(elementType);
                            cpVarsMap[name].vtype = vtype;
                        }
                    }else if(cpVarsMap[name].vtype == "array"){
                        if (ArrayType* arrTy = dyn_cast<ArrayType>(vType)) {
                            Type *elementType = arrTy->getElementType();
                            std::string vtype = getTypeToString(elementType);
                            cpVarsMap[name].vtype = vtype;
                            errs()<<*elementType<<"\n";
                        }
                    }*/
                }
            }
        }

        ///局部变量
        for (auto& F : M) {
            auto Fname = F.getName().str();
            if(!cpFnames.count(Fname)) continue;
            for (auto& BB : F) {
                for (auto& I : BB) {
                    if (I.getOpcode() == Instruction::Alloca) {
                        if (auto* AI = dyn_cast<AllocaInst>(&I)) {
                            std::string Vname = AI->getName().str();
                            if(cpVarsMap.count(Vname) && cpVarsMap[Vname].fname == Fname){
                                if(cpVarsMap[Vname].fname == mainLoopFuncName){
    //                                errs()<<Vname<<"\n";
                                    ///匹配成功
                                    cpVarsMap[Vname].v = &I;
    //                            cpVarsMap[Vname].v = Builder.CreateBitCast(AI, Type::getInt8PtrTy(Context));
    //                            errs()<<*AI<<"\n";
                                    Type* vType = AI->getAllocatedType();

                                    Type *eType = getBaseElementType(vType); ///元素类型
                                    cpVarsMap[Vname].vtype = getTypeToString(eType);
                                    if(cpVarsMap[Vname].vtype == "struct"){
                                        if (StructType* StructTy = dyn_cast<StructType>(eType)) {
                                            unsigned StructSize = DL.getTypeAllocSize(StructTy);
                                            cpVarsMap[Vname].bytes = StructSize * cpVarsMap[Vname].elemsTotal;
                                            errs()<<cpVarsMap[Vname].bytes<<"\n";
                                        }
                                    }
                                    if(cpVarsMap[Vname].elemsTotal > 1 &&  !cpVarsMap[Vname].ispoiArr){
                                        ///double *x,double *y
                                        cpVarsMap[Vname].v = Builder.CreateBitCast(AI, Type::getInt8PtrTy(Context));
                                    }
                                    /*//                            if(cpVarsMap[Vname].vtype == "pointer"){
        //                                if (PointerType *ptrType = dyn_cast<PointerType>(vType)) {
        //                                    Type *elementType = ptrType->getElementType();
        //                                    std::string vtype = getTypeToString(elementType);
        //                                    cpVarsMap[Vname].vtype = vtype;
        //                                }
        //                            }else if(cpVarsMap[Vname].vtype == "array"){
        //                                if (ArrayType* arrTy = dyn_cast<ArrayType>(vType)) {
        //                                    Type *elementType = arrTy->getElementType();
        //                                    std::string vtype = getTypeToString(elementType);
        //                                    cpVarsMap[Vname].vtype = vtype;
        //                                }
        //                            }*/
                                }



                            }
                        }
                    }
                }
            }
        }
        errs()<<"output data:" << cpVarsMap.size()<<"\n";
        for(auto &var : cpVarsMap){
            cpNode &cnode = var.second;
            errs()<<cnode.vname<<","<<cnode.vtype<<","<<cnode.elemsTotal<<","<<cnode.fname<<"\n";
        }

    }

    void InsertCheckpointCode::insertCheckpointCode(Module& M){
        LLVMContext &Context = M.getContext();
        IRBuilder<> Builder(Context);
        skptStr = Builder.CreateGlobalStringPtr("vc_skpt");
        int b = 0;
        int vcp =0;
        for (auto& F : M) {
            if(F.getName().str().compare(mainLoopFuncName)) continue;
            for (auto &BB: F) {
                for (auto &I: BB) {
                    if (auto DL = I.getDebugLoc()) {
                        unsigned lineNo = DL.getLine();
                        ///在main loop前插入 read_cp
                        if(lineNo == mainloopbegin && b == 0){

                            IRBuilder<> builder(&I); /// 插入点

                            if( 0 == selectId){
                                Type *Int32PointerType = Type::getInt32PtrTy(Context);  // 指定指针类型
                                /***
                                 * 插入read_cp
                                 * 1.rank,location (cpc_Rank,cpc_Locaiton)
                                 * 2.iter,data
                                 * for（—）找iter Alloca，data从开头找Alloca -- load
                                 * 3.size,从file中获取
                                */
    //                        errs()<<F.getName().str()<<"1\n";
                                errs()<<"read_cp:\n";

                                Value *rank = builder.CreateLoad(cpc_Rank);
    //                        errs()<<*(rank->getType())<<",";

                                Value *iterValue = builder.CreateLoad(cpc_Iter);
                                Value *iter = builder.CreateIntToPtr(iterValue, Type::getInt32PtrTy(Context));

    //                        errs()<<*(iter->getType())<<",";

                                Value *locationValue = builder.CreateLoad(cpc_Loc);
                                Value *location = builder.CreateIntToPtr(locationValue, Type::getInt32PtrTy(Context));

    //                        errs()<<*(location->getType())<<",";

                                for(auto &var:cpVarsMap){
                                    if(var.second.fname != mainLoopFuncName && var.second.fname !="GlobalVar") continue;
                                    std::vector<Value*> args;
                                    errs()<<var.second.vname<<" : ";
                                    /*
                                     Value *rank = cpc_Rank;
                                     Value *location = cpc_Loc;
                                     Value *iter = cpc_Iter;
                                     Value *data = var.second.v;

                                     Value *rank = Builder.CreateBitCast(cpc_Rank, Type::getInt8PtrTy(Context));
                                     Value *location = Builder.CreateBitCast(cpc_Loc, Type::getInt8PtrTy(Context));
                                     Value *iter = Builder.CreateBitCast(cpc_Iter, Type::getInt8PtrTy(Context));
                                     Value *data = Builder.CreateBitCast(var.second.v, Type::getInt8PtrTy(Context));
                                     */


    //                            Value *cr =  builder.CreateLoad(cpc_Iter);
    //                            Value *iterValue = builder.CreateIntToPtr(cr, Int32PointerType);///i32 *


    //                            Value *cc =  builder.CreateLoad(cpc_Loc);
    //                            Value *locationValue = builder.CreateIntToPtr(cc, Int32PointerType);///i32 *
                                    Value *data = var.second.v;
    //                            errs()<<*data<<"\n";

                                    if(!var.second.isArray && !var.second.ispoiArr){
                                        llvm::Type* i8PtrType = llvm::Type::getInt8PtrTy(Context);
                                        data = builder.CreateBitCast(data, i8PtrType);
                                    }
                                    if(var.second.ispoiArr){
                                        Value *dataVal =  builder.CreateLoad(data);
    //                                errs()<<*dataVal<<"\n";
                                        llvm::Type* i8PtrType = llvm::Type::getInt8PtrTy(Context);
                                        data = builder.CreateBitCast(dataVal, i8PtrType);

    //                                llvm::Type* i8PtrType = llvm::Type::getInt8PtrTy(Context);
    //                                data = builder.CreateBitCast(data, i8PtrType);
                                    }

    /*                            if(var.second.isArray)
                                    data = var.second.v;
                                else
                                    data = builder.CreateLoad(var.second.v);
                                if (!llvm::isa<llvm::PointerType>(data->getType()) ||
                                    !data->getType()->getPointerElementType()->isIntegerTy(8)) {
                                    // 如果 data 不是 i8*，进行类型转换
    //                                llvm::Value* dataPtr = builder.CreatePointerCast(data, llvm::Type::getInt8PtrTy(Context));
    //                                errs()<<*dataPtr<<"\n";
                                    errs()<<*(data->getType())<<"\n";
                                    llvm::Type* i8PtrType = llvm::Type::getInt8PtrTy(Context);
                                    data = builder.CreateBitCast(data, i8PtrType);

                                }*/
    //                            errs()<<*data<<",\n";
    //                            errs()<<*(data->getType())<<",";

    //                            errs()<<*(var.second.v->getType())<<",";

                                    if(var.second.bytes == 0)
                                        var.second.bytes = vReByte(var.second.vtype,var.second.elemsTotal);
                                    Value *size = ConstantInt::get(Type::getInt32Ty(Context), var.second.bytes);

    //                            errs()<<var.second.bytes<<",";

    //                            errs()<<*(size->getType())<<"。\n";

                                    args.push_back(rank);
                                    args.push_back(iter);
                                    args.push_back(location);
                                    args.push_back(data);
                                    args.push_back(size);

    //                            errs()<<*data<<"\n";
    //                            errs()<<*readCpFunc<<"\n";
                                    builder.CreateCall(readCpFunc, args);
                                    errs()<<"insert success readCp\n";
                                }
                            }///RW
                            else if( 1 == selectId){
                                ///FTI
                                errs()<<"begin FTI insert !!!\n";
    //                            errs()<<*Fpath<<"\n";
//                                errs()<<I<<"\n";
    //                            errs()<<*MPICW<<"\n"; /// cw

                                ///1.FTI_Init
    //                            std::vector<Value*> initArgs;
    //                            initArgs.push_back(Fpath);
    //                            initArgs.push_back(MPICW);
    //                            builder.CreateCall(fti_init, initArgs);
    //                            errs()<<"FTI_Init\n";
                                ///2.FTI_Protect
                                int fti_p_index = 0;
//                                Value *FTI_DBLE = ConstantInt::get(Type::getInt32Ty(Context), 0);

                                for(auto &var:cpVarsMap) {
    //                                errs()<<fti_p_index<<" : \n";
                                    if(var.second.fname != mainLoopFuncName && var.second.fname !="GlobalVar") continue;
                                    Value *index = ConstantInt::get(Type::getInt32Ty(Context), fti_p_index);
                                    fti_p_index++;

                                    if(var.second.bytes == 0)
                                        var.second.bytes = vReByte(var.second.vtype,var.second.elemsTotal);
                                    Value *size = ConstantInt::get(Type::getInt64Ty(Context), var.second.bytes);
    //                                errs()<<*size<<"\n";
                                    Value *data = var.second.v;

                                    if(!var.second.isArray && !var.second.ispoiArr){
                                        llvm::Type* i8PtrType = llvm::Type::getInt8PtrTy(Context);
                                        data = builder.CreateBitCast(data, i8PtrType);
                                    }
                                    if(var.second.ispoiArr){
                                        Value *dataVal =  builder.CreateLoad(data);
                                        llvm::Type* i8PtrType = llvm::Type::getInt8PtrTy(Context);
                                        data = builder.CreateBitCast(dataVal, i8PtrType);
                                    }
    //                                errs()<<*data<<"\n";
                                    std::vector<Value*> proArgs;
                                    proArgs.push_back(index);
                                    proArgs.push_back(data);
                                    proArgs.push_back(size);

                                    Value *FTIValue;
                                    if(var.second.vtype == "double"){
                                        FTIValue = builder.CreateLoad(FTIDBLE);
                                    }else if(var.second.vtype == "int32"){
                                        FTIValue = builder.CreateLoad(FTIINTG);
                                    }else if(var.second.vtype == "float"){
                                        FTIValue = builder.CreateLoad(FTILDBE);
                                    }else if(var.second.vtype == "int64"){
                                        FTIValue = builder.CreateLoad(FTILONG);
                                    }else{
                                        if(var.second.vtype == "struct"){
                                            ////需要对里面的属性一一protect
                                            continue;
                                        }

                                    }
                                    proArgs.push_back(FTIValue);

                                    builder.CreateCall(fti_protect, proArgs);
                                    errs()<<"FTI_Protect\n";
                                }
                                ///3.FTI_Status
                                std::vector<Value*> statusArgs;
                                builder.CreateCall(fti_status, {});
                                errs()<<"FTI_Status\n";
                                ///4.FTI_Recover
                                std::vector<Value*> recoverArgs;
                                builder.CreateCall(fti_recover, {});
                                errs()<<"FTI_Recover\n";
                            }
                            else if(2 == selectId){

                                //// VELOC_Mem_protect
                                int vcindex  = 0;
                                ///main loop index
                                Value *index = ConstantInt::get(Type::getInt32Ty(Context), vcindex);
                                vcindex++;

                                Value *data = cpc_Iter;
                                llvm::Type* i8PtrType = llvm::Type::getInt8PtrTy(Context);
                                data = builder.CreateBitCast(data, i8PtrType);

                                Value *count = ConstantInt::get(Type::getInt64Ty(Context), 1);

                                Value *typesize =ConstantInt::get(Type::getInt32Ty(Context), sizeof(int));

                                std::vector<Value*> proArgs;
                                proArgs.push_back(index);
                                proArgs.push_back(data);
                                proArgs.push_back(count);
                                proArgs.push_back(typesize);

                                builder.CreateCall(VELOC_Mem_protect, proArgs);


                                ///cp variables
                                for(auto &var:cpVarsMap) {
                                    
                                    /// 1  id
                                    if(var.second.fname != mainLoopFuncName && var.second.fname !="GlobalVar") continue;
                                    if(var.second.fname =="GlobalVar" && var.second.vname == iter_name) continue;
                                    
                                    Value *index = ConstantInt::get(Type::getInt32Ty(Context), vcindex);
                                    vcindex++;

                                    /// 2  data
                                    Value *data = var.second.v;
                                    if(!var.second.isArray && !var.second.ispoiArr){
                                        data = builder.CreateBitCast(data, i8PtrType);
                                    }
                                    if(var.second.ispoiArr){
                                        Value *dataVal =  builder.CreateLoad(data);
                                        data = builder.CreateBitCast(dataVal, i8PtrType);
                                    }
                                    /// 3  count
                                    if(var.second.bytes == 0)
                                        var.second.bytes = vReByte(var.second.vtype,var.second.elemsTotal);
                                    Value *count = ConstantInt::get(Type::getInt64Ty(Context), var.second.bytes);

                                    /// 4  sizeof(type)
                                    Value *typesize =rtTypeSize (var.second.vtype,Context);

                                    ///5
                                    std::vector<Value*> proArgs;

                                    proArgs.push_back(index);
                                    proArgs.push_back(data);
                                    proArgs.push_back(count);
                                    proArgs.push_back(typesize);

                                    builder.CreateCall(VELOC_Mem_protect, proArgs);
                                }

                                
                                errs()<<"VELOC_Mem_protect\n";

                                //// VELOC_Restart_test


                                Value *restartTestArgs[] = {skptStr, ConstantInt::get(Type::getInt32Ty(Context), 0)};
                                CallInst *restartTestCall = Builder.CreateCall(VELOC_Restart_test, restartTestArgs);
                                Builder.CreateStore(restartTestCall, vrt);
                                errs()<<"VELOC_Restart_test\n";

                                //// VELOC_Restart
                                Value *cmp = Builder.CreateICmpSGT(vrt, Builder.getInt32(0));

                                // 创建 if 语句
                                BasicBlock *curBB = &BB;
                                BasicBlock *thenBB = BasicBlock::Create(Context, "then", curBB->getParent());
                                BasicBlock *contBB = BasicBlock::Create(Context, "cont", curBB->getParent());
                                Builder.CreateCondBr(cmp, thenBB, contBB);

                                // 在 thenBB 中插入 VELOC_Restart 的调用和 assert 语句
                                Builder.SetInsertPoint(thenBB);
                                Value *restartArgs[] = {skptStr, vrt};
                                CallInst *restartCall = Builder.CreateCall(M.getFunction("VELOC_Restart"), restartArgs);
                                Value *assertCond = Builder.CreateICmpEQ(restartCall, Builder.getInt32(VELOC_SUCCESS));
                                Builder.CreateCall(assertFunc, {assertCond});
                                Builder.CreateBr(contBB);

                                errs()<<"VELOC_Restart\n";

                            }
                            b++;
                        }
                        ///in
                        if(!vcp){
                            if(lineNo>=mainloopbegin && lineNo<=mainloopend && b>0){
                                if(selectId == 1){
                                    ////5.FTI_Checkpoint
                                    IRBuilder<> builder(&I);
                                    std::vector<Value*> cPArgs;
                                    //                        cPArgs.push_back(cpc_Iter);/// --- ,
                                    Value *id = ConstantInt::get(Type::getInt32Ty(Context), 1); //// id
                                    Value *level = ConstantInt::get(Type::getInt32Ty(Context), 1); //// level
                                    cPArgs.push_back(id);
                                    cPArgs.push_back(level);
                                    builder.CreateCall(fti_checkpoint, cPArgs);

                                    errs()<<"FTI_Checkpoint\n";
                                }
                                if(selectId == 2){
                                    ///VELOC_Checkpoint
                                    IRBuilder<> builder(&I);
                                    Value *cpArgs[] = {skptStr, cpc_Iter};
                                    CallInst *cpCall = Builder.CreateCall(M.getFunction("VELOC_Checkpoint"), cpArgs);
                                    Builder.CreateICmpEQ(cpCall, Builder.getInt32(VELOC_SUCCESS));
                                    errs()<<"VELOC_Checkpoint\n";
                                }
                                vcp = 1;
                            }
                        }

                        ////after
                        if(lineNo >=mainloopbegin && lineNo <=mainloopend && b>0){

                            if(auto *BI = dyn_cast<BranchInst>(&I)){
                                if (BI->isConditional()) {
    //                                errs()<<F.getName().str()<<"2\n";

    //                                BasicBlock *end = BI->getSuccessor(1);
                                    ///获取第一条非PHI指令
    //                                Instruction *firstInst = end->getFirstNonPHI();
                                    IRBuilder<> builder(&I);
    //                                errs()<<I<<"\n";

                                    if(0 == selectId){
                                        ///插入write_cp
                                        errs()<<"write_cp:\n";
                                        Value *rank = builder.CreateLoad(cpc_Rank);
                                        Value *iter = builder.CreateLoad(cpc_Iter);

                                        for(auto &var:cpVarsMap){
                                            if(var.second.fname != mainLoopFuncName && var.second.fname !="GlobalVar") continue;
                                            std::vector<Value*> args;

    //                                    Value *dataValue = builder.CreateBitCast(var.second.v, Type::getInt8PtrTy(Context));
    //                                    Value *data = builder.CreateLoad(dataValue);
                                            Value *data = var.second.v;
                                            if(!var.second.isArray && !var.second.ispoiArr){
                                                llvm::Type* i8PtrType = llvm::Type::getInt8PtrTy(Context);
                                                data = builder.CreateBitCast(data, i8PtrType);
                                            }
                                            if(var.second.ispoiArr){
                                                Value *dataVal = builder.CreateLoad(data);
    //                                        errs()<<*dataVal<<"\n";
                                                llvm::Type* i8PtrType = llvm::Type::getInt8PtrTy(Context);
                                                data = builder.CreateBitCast(dataVal, i8PtrType);

    //                                llvm::Type* i8PtrType = llvm::Type::getInt8PtrTy(Context);
    //                                data = builder.CreateBitCast(data, i8PtrType);
                                            }
    //                                    Value *data = builder.CreateBitCast(dataValue, Type::getInt8PtrTy(Context));
                                            if(var.second.bytes == 0)
                                                var.second.bytes = vReByte(var.second.vtype,var.second.elemsTotal);
                                            Value *size = ConstantInt::get(Type::getInt32Ty(Context), var.second.bytes);
    //                                    errs()<<var.second.bytes<<"\n";/

                                            args.push_back(rank);
                                            args.push_back(iter);
                                            args.push_back(data);
                                            args.push_back(size);

                                            builder.CreateCall(writeCpFunc, args);
                                            errs()<<"insert success writeCp\n";
                                        }
                                    }
                                    else if(1 == selectId){
                                        ///6.FTI_Finalize
    //                                    std::vector<Value*> finArgs;
    //                                    builder.CreateCall(fti_finalize, finArgs);
    //                                    errs()<<"FTI_Finalize\n";
                                    }else if(2 == selectId){

                                    }
                                    return;
                                }
                            }
                        }

                    }

                }
            }
        }

    }

    Type* InsertCheckpointCode::getBaseElementType(Type *Ty) {
        if (ArrayType *ArrTy = dyn_cast<ArrayType>(Ty)) {
            // 获取数组的基本元素类型
            return getBaseElementType(ArrTy->getElementType());
        } else if (PointerType *ptrType = dyn_cast<PointerType>(Ty)) {
            return getBaseElementType(ptrType->getElementType());
        }else{
            return Ty;
        }
    }

    Value* InsertCheckpointCode::rtTypeSize(std::string type,LLVMContext &Context){
        Value *typesize ;
        if(type == "int32"){

            typesize = ConstantInt::get(Type::getInt32Ty(Context), sizeof(int));
        }else if(type == "int64") {
            typesize = ConstantInt::get(Type::getInt32Ty(Context), sizeof(long long int));
        }else if(type == "float") {
            typesize = ConstantInt::get(Type::getInt32Ty(Context), sizeof(float));
        }else if(type == "double") {
            typesize = ConstantInt::get(Type::getInt32Ty(Context), sizeof(double));
        }
        return typesize;
    }
    std::string InsertCheckpointCode::getTypeToString(Type* valType) {
        std::string varty="";
        if (valType->isIntegerTy()) {
            if (valType->isIntegerTy(1)) {
                // val是布尔类型
                varty = "bool";
            }
            else if (valType->isIntegerTy(8)) {
                // val是8位整数类型
                varty = "int8";
            }
            else if (valType->isIntegerTy(16)) {
                // val是16位整数类型
                varty = "int16";
            }
            else if (valType->isIntegerTy(32)) {
                // val是32位整数类型
                varty = "int32";

            }
            else if (valType->isIntegerTy(64)) {
                // val是64位整数类型
                varty = "int64";

            }
            else {
                // 其他整数类型
                varty = "int";
            }
        }
        else if (valType->isFloatingPointTy()) {
            if (valType->isFloatTy()) {
                // val是单精度浮点数类型
                varty = "float";

            }
            else if (valType->isDoubleTy()) {
                // val是双精度浮点数类型
                varty = "double";

            }
            else {
                // 其他浮点数类型
                varty = "fd";

            }
        }
        else if (valType->isPointerTy()) {
            // val是指针类型
            varty = "pointer";

        }
        else if (valType->isVectorTy()) {
            // val是向量类型
            varty = "vector";

        }
        else if (valType->isArrayTy()) {
            // val是数组类型
            varty = "array";

        }
        else if (valType->isStructTy()) {
            // val是结构体类型
            varty = "struct";

        }
        else if (valType->isFunctionTy()) {
            // val是函数类型
            varty = "function";

        }
        else if (valType->isLabelTy()) {
            // val是标签类型
            varty = "label";

        }
        else {
            // 其他类型
            varty = "other";
        }
        return varty;
    }

    unsigned InsertCheckpointCode::vReByte(std::string vtype,unsigned elems){
        if(vtype == "int32"|| vtype == "int64") return sizeof(int) * elems;
        if(vtype == "double") return sizeof(double)*elems;
        if(vtype == "float") return sizeof (float )*elems;
        return 0;
    }

    bool InsertCheckpointCode::doInitialization(Module& M) {


        ///load 相关数据
        loadFromFileToMainLoop();
        loadFromFileToCPCode();
        loadFromFileToCpVars();

        dCPCVar(M);

       ///找到所有的Cp变量的alloca
        findCpVarsAlloca(M);

        insertCheckpointCode(M);

        return true;
    }
    bool InsertCheckpointCode::runOnFunction(Function& F) {
        return false;
    }
    char InsertCheckpointCode::ID = 0;
    static RegisterPass<InsertCheckpointCode> X("insertcheckpointcode", "hello pass", false, false);

