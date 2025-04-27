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
    #include<unordered_map>


    #define READFILELIB "/workspace/LLVM-Checker/lib/Data/"
    #define WRITERFILELIB "/workspace/LLVM-Checker/lib/Data/"

    char dataFiles[10][30]={"dataMap.txt","varsMap.txt","arrVarsMap.txt",
                            "varNameData.txt","tmpLinkVarList.txt","funcNameData.txt",
                            "loopRangeData.txt","mainloopData.txt"};

    using namespace llvm;

    extern "C" {
        void* malloc(size_t);
    }

    namespace {
        struct LinkChecker : public FunctionPass {
            static char ID;

            //new method
            struct varNode {
                uint64_t addr;
                std::string vname;
                int bbnum=-1;
                std::string fname;
                int vlocate=-1;
                std::string user;
                std::string vartype;//变量类型
                unsigned varsize;//变量空间大小 (仅为类型大小)
            };

            ///仅存储数组
            struct arrNode{
                uint64_t addr;
                std::string vname;
                int bbnum=-1;
                std::string fname;
                int vlocate=-1;
                std::string user;
                std::string vartype;//变量类型
                unsigned dim;///数组维度
                unsigned dimElems[10];///默认数组维度不超过10
            };

//            ///仅存储指针数组(malloc,new etc)
//            struct poiNode{
//                uint64_t addr;
//            };
            std::map<int, std::vector<std::vector<varNode>>>ddgNodeMap;


            //存储所有的变量 ---
            std::map<uint64_t, varNode > varsMap;

            ///存储所有的数组变量
            std::map<uint64_t,arrNode> arrVarsMap;

            ///存储所有的非临时变量 tmp.addr || .compoundliteral
            std::set<uint64_t> NoTmpVarsMap;


            //函数名列表
            std::set<std::string>funcNameList;
            //变量列表(因为可能出现不同函数同一变量名,所以采用函数名+变量名)
            std::set<std::pair<std::string,std::string>>varNameList;

            //存储循环的范围列表(带函数名前缀)
            std::map<std::string, std::vector<std::pair<unsigned, unsigned>>>loopRangeList;

            //对传替的参数映射原数组
            //原数组
            std::map<std::uint64_t, varNode>arrRoot;

            //临时变量与原变量(llvm.memcpy)
            std::map<uint64_t , uint64_t>tmpLinkVar;

            //获取变量名
            std::pair < std::string, std::string> vfname;
            //获取CALLBBNUM函数
            Function* func;


            ///全局变量
            std::unordered_map<std::string,uint64_t> globalVars;

            //main loop 的范围(需手动输入)
            int mainloopbegin = 0;
            int mainloopend = 0;

            //main loop所在的文件名
            std::string mainLoopFuncName;

//            Module &aModule;
            uint64_t find_Vars(uint64_t addr) ;

            bool checkedFuncName(std::string funcName);
            void initConnPoinArr(Module& M);

            void initDDGData(Module& M);

            void getGlobalVarNodeMessage(Module& M);

            void getLocalVarNodeMessage(Module& M);

            void getDDGMapMessage(Module& M);

            void getStoreAllVariable(Instruction* I,int BBNum);

            void getVariable(Instruction* I, std::vector<varNode>& varnodes,int BBNum);

            std::string getGlobalVariableName(const llvm::Value* V);

            std::string getGlobalVarNameFromString(Value* Operand);

            void ddgMapImportToFile();
            //导入变量名到文件中
            void varNameListImportToFile();
            //导入函数名到文件中
            void FuncNameListImportToFile();
            //llvm.memcpy 将临时变量与原变量对应起来

            void tmpLinkVarListImportToFile();
            //获取循环的覆盖范围(以行号方式)
            void loopsRange(Function& F);

            //判断变量定义是在循环内还是循环外
            bool isLoopRange(std::string fname, unsigned line);

            void loadFromFileToLoopRange();
            void funcNameInsertUsedFucName(std::set<std::string> &f);
            std::string stringtofilename(std::string name,bool state);
            //判断函数名
            bool judgeFuncName(std::string fname);

            //创建函数在每个块中插入用于计算块号
            Function* createFuncNumber(Module& M);
            //给每个基本块附上编号
            void bbIsNum(BasicBlock& BB, int count, Function* func, LLVMContext& context);

            int getbbNum(BasicBlock& BB);


            //返回数据类型
            std::string getTypeToString(Type* vartype);

            unsigned getVarSize(Value* var);

            int getMemSize(Type *T) ;

            void varsMapImportToFile();
            //string --- vector<node>
            LinkChecker() : FunctionPass(ID) {}
            void getAnalysisUsage(AnalysisUsage& AU) const override {
                AU.setPreservesAll();
                AU.addRequired<LoopInfoWrapperPass>();
            }
            void loadFromFileToMainLoop();
            void insertFlag(Module& M);
            bool runOnFunction(Function& F);
            bool doInitialization(Module& M);//初始化
        };

    }
    bool LinkChecker::checkedFuncName(std::string funcName){
        if(funcName == "printf" ||  funcName == "scanf" ||funcName == "getchar" ||
                funcName == "putchar" ||  funcName == "fgets" ||funcName == "fputs" ||
                funcName == "strcpy" ||  funcName == "strncpy" ||funcName == "strlen" ||
                funcName == "strcmp" ||  funcName == "strncmp" ||funcName == "strcat" ||
                funcName == "strncat" ||  funcName == "strchr" ||funcName == "strstr" ||
                funcName == "sprintf" ||  funcName == "sscanf" ||funcName == "sqrt" ||
                funcName == "fabs" ||  funcName == "sin" ||funcName == "cos" ||
                funcName == "tan" ||  funcName == "exp" ||funcName == "log" ||
                funcName == "pow" ||  funcName == "fopen" ||funcName == "fclose" ||
                funcName == "fread" ||  funcName == "fwrite" ||funcName == "fseek" ||
                funcName == "ftell" ||  funcName == "fprintf" ||funcName == "fscanf" ||
                funcName == "time" ||  funcName == "localtime" ||funcName == "strftime" ||funcName == "atoi"||
            funcName == "memcpy" ||  funcName == "_Znam" ||funcName == "_Znaj" ||funcName == "calloc"||
                funcName == "realloc" ||  funcName == "free" ||funcName == "_Z7mytimerv" ||funcName == "calloc" ||
                funcName == "malloc" || funcName == "vfprintf" || funcName == "vprintf" ||funcName == "vsprintf"

                ) return true;
        if (funcName.find("llvm.") != std::string::npos ||
                funcName == "CALLBBNUM"  ) return true;
        return false;
    }

    void LinkChecker::funcNameInsertUsedFucName(std::set<std::string> &funcNameList){
//        funcNameList.insert("GlobalVar");//全局变量的函数名为"GlobalVar"
//        funcNameList.insert("free");
    }

    std::string LinkChecker::stringtofilename(std::string name,bool state){//read 0,write 1
        std::string filename;
        if(state) filename=WRITERFILELIB;
        else filename = READFILELIB;
        filename+=name;
    //    errs()<<filename<<"\n";
        return filename;
    }
    //new
    void LinkChecker::getGlobalVarNodeMessage(Module& M) {
        varNode node;
        for (auto& G : M.getGlobalList()) {
            if (G.hasInitializer()) {
                Value* addr = &G;
                std::string name = G.getName().str();
                if (name=="cher_flag"||name.find(".str")!=std::string::npos) continue;//flag 为自定义全局变量
                auto* GV = dyn_cast<GlobalVariable>(&G);

                //存储节点
                node.addr = reinterpret_cast<uint64_t>(addr);
                node.vname = name;
                node.fname = "GlobalVar";//函数名为空是全局变量
                node.bbnum = -1;
                node.user = "out";//代表是循环外定义

                //存储变量名
                vfname.first = name;
                vfname.second = node.fname;


                varNameList.insert(vfname);

                //变量类型
                Type* varType = GV->getValueType();
                node.vartype = getTypeToString(varType);
                //变量空间
                node.varsize = 0;
                if (node.vartype == "array") {
                    arrNode anode;///数组结点
                    anode.addr = node.addr;
                    anode.vname = name;
                    anode.fname = "GlobalVar";
                    anode.bbnum=-1;
                    anode.user = "out";
                    anode.vartype = "array";
                    anode.vlocate=-1; ///7
                    int dimi = 0;///维度


//                    errs()<<name<<" : \n";
                    while(ArrayType* arrTy = dyn_cast<ArrayType>(varType)){
//                        unsigned arrsize = arrTy->getNumElements();
                        unsigned arrsize = arrTy->getArrayNumElements();
                        varType = arrTy->getArrayElementType();
//                        errs() << arrsize << " , ";
                        node.varsize = arrsize;

                        ///数组结点
                        anode.dimElems[dimi] = arrsize; /// 8
                        dimi++;

                    }
                    anode.dim = dimi; /// 9

//                    errs()<<dimi<<"\n";

                    //映射: 原数组
                    arrRoot[node.addr] = node;


                    arrVarsMap[node.addr] = anode;///insert
                }
                ///变量空间 大小
                if(node.varsize < getMemSize(varType))
                    node.varsize = getMemSize(varType);

                //errs() << name << " - " << node.vartype << " - " << node.varsize << "\n";
                if(name.size()>0){
                    varsMap[node.addr] = node;
                    ///将全局变量存入
                    globalVars[node.vname] = node.addr;
                }



            }
        }

        for (auto& F : M) {
            if (F.getName().str() == "CALLBBNUM") {
                func = &F;
                return;
            }
        }
    }

    void LinkChecker::getLocalVarNodeMessage(Module& M) {
        LLVMContext& context = M.getContext();
        funcNameInsertUsedFucName(funcNameList);

        varNode node;
        int BBNum = 0;
        for (auto& F : M) {
            auto Fname = F.getName().str();

            if(checkedFuncName(Fname) && !F.isDeclaration()) continue;

            //将函数参数变量存入varsMap
            for (auto arg_it = F.arg_begin(); arg_it != F.arg_end(); ++arg_it) {
                ///恢复  node
                // 获取参数的名称和类型
                Argument *arg = &(*arg_it);
                auto varname = arg->getName().str();
                Type *varType = arg->getType();
                node.addr = reinterpret_cast<uint64_t>(arg);
                node.fname = Fname;
                node.vname=varname;
                node.bbnum=-2;
                node.user="out";
                node.vartype=getTypeToString(varType);
                node.varsize=0;
                node.vlocate = -2; // 代表是函数参数
                if(varname.size()>0)
                    varsMap[node.addr] = node;
//                errs()<<node.vname<<",";
            }
//            errs()<<"\n";

            //存入函数名
            funcNameList.insert(Fname);
            std::map<std::string, uint64_t>ntd;

            for (auto& BB : F) {
                auto BBname = BB.getName().str();
                if (BBname.find("invoke") != std::string::npos ||
                        BBname.find("lpad") != std::string::npos ||
                        BBname.find("ehcleanup") != std::string::npos) continue;
                int t = 0;
                for (auto& I : BB) {

                    //存入变量名
                    if (I.getOpcode() == Instruction::Alloca) {
                        vfname.second = Fname;
                        if (auto* AI = dyn_cast<AllocaInst>(&I)) {

                            auto varname = AI->getName().str();

                            vfname.first = varname;
                            varNameList.insert(vfname);

                            node.addr = reinterpret_cast<uint64_t>(AI);
                            node.fname = Fname;

                            node.vname = varname;

                            node.bbnum = BBNum;

                            node.user="out";

                            ntd[varname] = node.addr;

                            Type* varType = AI->getAllocatedType();

//                            int newVarSize = getMemSize(varType);
                            //unsigned sizeInBits = varType->getPrimitiveSizeInBits();
                            //// 将比特数转换为字节
                            //unsigned sizeInBytes = (sizeInBits + 7) / 8;
                            //errs() << sizeInBytes << " : 0 ,";
                            //变量类型
                            //Type* varType = AI->getType()->getElementType();
                            node.vartype = getTypeToString(varType);

                            //变量空间
                            node.varsize = getMemSize(varType);


                            ///数组结点
                            if(node.vartype == "array"){
                                arrNode anode;///数组结点
                                anode.addr = node.addr;
                                anode.vname = node.vname;
                                anode.fname = node.fname;
                                anode.bbnum=BBNum;
                                anode.user = "out";
                                anode.vartype = "array";
                                anode.vlocate=-1; ///7
                                int dimi = 0;

//                                errs()<<node.vname<<" : \n";
                                while(ArrayType* arrTy = dyn_cast<ArrayType>(varType)){
                                    unsigned arrsize = arrTy->getArrayNumElements();
                                    varType = arrTy->getArrayElementType();
//                                    errs() << arrsize << " , ";
                                    node.varsize = arrsize;
                                    ///数组结点
                                    anode.dimElems[dimi] = arrsize; /// 8
                                    dimi++;
                                }

                                anode.dim = dimi; /// 9
//                                errs()<<dimi<<"\n";

                                arrVarsMap[node.addr] = anode;///insert
                            }

                            if(varname.size()>0){
    //                            errs()<<varname.size()<<" ,"<<varname<<"\n";
                                varsMap[node.addr] = node;
                            }
                            node.vlocate = -1;
                        }
                    }

                    if (I.getOpcode() == Instruction::Call) {
                        varNode v;
                        int getname = 0, getline = 0;
                        //获取节点(根据变量名)
                        if (auto* dbgDeclare = dyn_cast<DbgDeclareInst>(&I)) {
                            // 获取调试元数据
                            auto* varMD = dbgDeclare->getVariable();

                            // 获取变量名称
                            if (auto* localVar = dyn_cast<DILocalVariable>(varMD)) {
                                auto varName = localVar->getName().str();
//                                errs() << "Variable name: " << varName << "\n";
                                v= varsMap[ntd[varName]];
                                getname = 1;
                            }
                        }
                        if(v.user == "out"){
                            //获取行号
                            unsigned lineNo = -1;
                            auto* dbgNode = dyn_cast<DbgInfoIntrinsic>(&I);
                            if (dbgNode && dbgNode->getMetadata("dbg")) {
                                auto* dbg = dyn_cast<DILocation>(dbgNode->getMetadata("dbg"));
                                if (dbg) {
                                    lineNo = dbg->getLine();
                                    //errs() << "Line number: " << lineNo << "\n";
                                    getline = 1;
                                }
                            }
                            //进行判断
                            if (getname && getline) {
                                if (isLoopRange(Fname, lineNo)) v.user = "in";
                                //修改后放回
                                varsMap[v.addr] = v;
                                //errs() << v.addr << " :2 " << v.vname << "\n";
                            }
                        }
                    }

                    if (I.getOpcode() == Instruction::Store) {
                        t++;
                    }
                    if(I.getOpcode() == Instruction::Load){
                        t++;
                    }
                    //llvm.memcpy.  类似 =
                    if(I.getOpcode() == Instruction::Call){
                        if (auto *callInst = dyn_cast<CallInst>(&I)) {
                            if (auto *CI = callInst->getCalledFunction()) {
                                auto ciName = CI->getName().str();
                                if(ciName.find("llvm.memcpy.")!=std::string::npos){
                                    t++;
                                }

                            }
                        }
                    }
                }
                if (t) {
                    //errs() << BBNum << ": " << BB.getName()<<"\n";
                    bbIsNum(BB, BBNum, func, context);
                }
                BBNum++;

            }

        }
    }

    int LinkChecker::getbbNum(BasicBlock& BB) {
        int bbnum = -1;
        for (auto& I : BB) {
            if (I.getOpcode() == Instruction::Call) {
                if (auto* CI = dyn_cast<CallInst>(&I)) {
                    if (auto* CF = CI->getCalledFunction()) {
                        if (CF->getName().str() == "CALLBBNUM" && CI->getNumArgOperands() > 0) {
                            Value* Arg = CI->getArgOperand(0);
                            std::vector<Value*> args;
                            if (auto* ArgConst = dyn_cast<ConstantInt>(Arg)) {
                                int ArgVal = ArgConst->getSExtValue();
                                bbnum = ArgVal;
                                //errs() << ArgVal << "\n";
                            }
                        }
                    }

                }
            }

        }

        return bbnum;
    }

    void LinkChecker::getDDGMapMessage(Module& M) {
        int BBNum = 0;
        for (auto& F : M) {
            auto Fname = F.getName().str();
//            errs()<<Fname<<": \n";
            if(checkedFuncName(Fname) && !F.isDeclaration()) continue;

            for (auto& BB : F) {
                auto BBname = BB.getName().str();
                //c++
                if (BBname.find("invoke") != std::string::npos ||
                    BBname.find("lpad") != std::string::npos ||
                    BBname.find("ehcleanup") != std::string::npos) continue;
                for (auto& I : BB) {
                    //store
                    if (I.getOpcode() == Instruction::Store) {
//                        errs()<<I<<"\n";
                        getStoreAllVariable(&I,BBNum);
                    }
                    //llvm.memcpy.  类似 =
                    if(I.getOpcode() == Instruction::Call){
                        if (auto *callInst = dyn_cast<CallInst>(&I)) {
                            if (auto *CI = callInst->getCalledFunction()) {
                                auto ciName = CI->getName().str();
                                if(ciName.find("llvm.memcpy.")!=std::string::npos){
                                   getStoreAllVariable(&I,BBNum);
                                }

                            }
                        }
                    }
                }
                BBNum++;
            }
        }
    }

    void LinkChecker::getStoreAllVariable(Instruction* I,int BBNum) {
        std::vector<varNode> varnodes;

        getVariable(I, varnodes, BBNum);
        //排除返回值
        int  cnt = varnodes[0].vname == "retval"?1:0;
        if(varnodes.size() == 2){
            auto n1 = varnodes[0].vname;
            auto n2 = varnodes[1].vname;
            if(n1 == n2+".addr") cnt =1;
        }

        if(!cnt && varnodes.size()>0)
            ddgNodeMap[BBNum].push_back(varnodes);
    }

    void LinkChecker::getVariable(Instruction* I, std::vector<varNode>& varnodes,int BBNum) {
        std::vector<Value*> operands;
        std::string variableName;
        varNode node;
        unsigned  numoperands = I->getNumOperands();
        if(numoperands > 0)
        switch (I->getOpcode()) {
            case Instruction::Store:
                if (I->getOperand(1) && I->getOperand(0)) {
                    operands.push_back(I->getOperand(1));
                    operands.push_back(I->getOperand(0));
//                    errs()<<*(I->getOperand(1))<<","<<*(I->getOperand(0))<<"\n";
                }
                break;
            case Instruction::Alloca:
                variableName = I->getName().str();
                //获取节点信息
                uint64_t address;
                if (auto* op = dyn_cast<AllocaInst>(I)) {
                    address = reinterpret_cast<uint64_t>(op);
                    node = varsMap[address];

                    //修改一部分
                    //node.vname = variableName;
                    node.bbnum = BBNum;

                    if (auto *inst = dyn_cast<AllocaInst>(I)) {
                        if (auto *ainst = dyn_cast<Instruction>(inst->getOperand(0))) {
//                        /// 出现   %vla = alloca i32, i64 %1, align 16, !dbg !720:   %1 = zext i32 %0 to i64, !dbg !720
//                        /// && 为varnodes[0]
//                            errs()<<*inst<<"  ===== ";
//                            errs()<<*ainst<<"\n";
                            if (varnodes.empty()) {
                                node.addr = 0;
                            }
                        }
                    }
                    varnodes.push_back(node);
                }

                break;
            case Instruction::Call:
                if (auto callInst = dyn_cast<CallInst>(I)) {

                    if (auto* cf = callInst->getCalledFunction()) {
                        //need modify
                        auto ciName = cf->getName().str();

//                        if(ciName == "malloc"){
//                            errs()<<*I<<"\n";
//                        }
                        if(ciName.find("llvm.memcpy.")!=std::string::npos){
//                            errs()<<"1"<<ciName<<"\n";
                            for (unsigned int i = 0; i < callInst->getNumArgOperands() - 2; ++i) {
                                auto* op = callInst->getArgOperand(i);
    //                            errs()<<i<<" : "<<*op<<"\n";
                                operands.push_back(op);
                            }

                        }
                        else if(funcNameList.count(ciName)){//是自定义的函数
//                            errs()<<"2"<<ciName<<"\n";
                            if(ciName == "ma_malloc"){
                                if (varnodes[0].vartype == "pointer") {
                                    if (varnodes[0].vname.find(".addr") == std::string::npos) {
                                        varsMap[varnodes[0].addr].vlocate = -3;
                                        varnodes[0].vlocate = -3;///代表是指针数组
                                    }
                                }
                            }
                            for (unsigned int i = 0; i < callInst->getNumArgOperands(); ++i) {
                                auto* op = callInst->getArgOperand(i);
    //                            errs()<<i<<" : "<<*op<<"\n";
                                operands.push_back(op);
                            }

                        }else{
                            ////指针变量 new || malloc ||realloc etc
                            ///(1) double * Ap = new double [nrow];
                            ///_Znam , _Znaj
                            if(ciName == "_Znam" || ciName == "_Znaj") {
                                if (varnodes.size() > 0 && varnodes[0].vartype == "pointer") {
                                    if (varnodes[0].vname.find(".addr") == std::string::npos) {
                                        varsMap[varnodes[0].addr].vlocate = -3;
                                        varnodes[0].vlocate = -3;///代表是指针数组
                                    }
                                }

                            }

                        }

                    }
                }

                break;
            case Instruction::Add:
            case Instruction::FAdd:
            case Instruction::Mul:
            case Instruction::FMul:
            case Instruction::UDiv:
            case Instruction::SDiv:
            case Instruction::FDiv:
            case Instruction::Sub:
            case Instruction::FSub:
                if (I->getOperand(1) && I->getOperand(0)) {
                    operands.push_back(I->getOperand(1));
                    operands.push_back(I->getOperand(0));
                }
                break;
            case Instruction::Load:
                if (I->getOperand(0)) {
                    operands.push_back(I->getOperand(0));

                    /// ==
                    auto name = getGlobalVarNameFromString(I);
                    if (name.find("CAlloc") != std::string::npos) {
                        errs()<<*I<<"\n";
                    }

                }
                break;
            default: //bitcast ,extractvalue ,select
                if (I->getOperand(0)) {
                    operands.push_back(I->getOperand(0));
                }
                break;
        }

        for (auto operand : operands) {

            if (auto* inst = dyn_cast<Instruction>(operand)) {
                getVariable(inst, varnodes,BBNum);//递归
            }
            else {

                variableName = getGlobalVariableName(operand);
                if (variableName == "")
                    variableName = getGlobalVarNameFromString(operand);
    //            if (variableName == "") variableName = "CONSTANTVALUE";
                auto address = reinterpret_cast<uint64_t>(operand);
                if(variableName!=""){
                    ///代表是全局变量,
                    ///store i32 0, i32* getelementptr inbounds ([512 x i32], [512 x i32]* @bucket_ptrs, i64 0, i64 0), align 16, !dbg !184
                    ///当出现这种情况时,全局变量的地址是不同的
                    ///查找它的真实地址
                    address = globalVars[variableName];
//                    errs()<<variableName<<","<<address<<"\n";
                }

                if(varsMap.count(address)){
                    node = varsMap[address];
                    //errs() << variableName << "\n";
                    node.bbnum = BBNum;
                    //errs() << node.user << "1\n";
                }else{
//                    errs()<<address<<"\n";
                    node.addr = address;
                    node.vname = variableName;
                    node.varsize = 0;
                    node.bbnum = BBNum;
                    node.user="in";
                    node.vartype="constant";
                }
                varnodes.push_back(node);
            }
        }

    }


    std::string LinkChecker::getGlobalVariableName(const llvm::Value* V) {
        if (auto* G = llvm::dyn_cast<llvm::GlobalVariable>(V)) {
            return G->getName().str();
        }
        return "";
    }

    std::string LinkChecker::getGlobalVarNameFromString(Value* Operand) {
        std::string str;
        llvm::raw_string_ostream destPtrStream(str);
        Operand->print(destPtrStream);
        size_t pos = str.find("getelementptr");
        if (pos != std::string::npos) {
            pos = str.find("@");
            if (pos != std::string::npos) {
                size_t endPos = str.find(",", pos);
                return str.substr(pos + 1, endPos - pos - 1);
            }
        }
        return "";
    }


    void LinkChecker::ddgMapImportToFile() {
        // 打开文件并将数据写入
        std::string filename = stringtofilename(dataFiles[0],1);//"dataMap.txt"
        std::ofstream file(filename);
        if (file.is_open()) {
            for (const auto& [key, value] : ddgNodeMap) {
                file << key << '\n';
                for (const auto& v : value) {
                    file << "=\n";
                    for (const auto& n : v) {
                        file << n.addr << ',' << n.vname << ',' << n.bbnum << ',' << n.fname << ',' << n.vlocate << ',' << n.user
                            <<','<<n.vartype << ',' << n.varsize <<'\n';
                    }
                    file << "\n";
                }
            }
            file.close();
        }
    }

    void LinkChecker::varsMapImportToFile() { // 所有的变量信息
        // 打开文件并将数据写入
        std::string filename = stringtofilename(dataFiles[1], 1);//"varsMap.txt"
        std::ofstream file(filename);
        if (file.is_open()) {
            for (const auto &[key, value]: varsMap) {
                file << key << ',';//变量地址
                file << value.vname << ',' << value.bbnum << ',' << value.fname << ',' << value.vlocate << ','
                     << value.user << ',' << value.vartype << ',' << value.varsize << '\n';
            }
            file.close();
        }

        ///数组

        filename = stringtofilename(dataFiles[2], 1);//"arrVarsMap.txt"
        std::ofstream file1(filename);
        if (file1.is_open()) {
            for (const auto &[key, value]: arrVarsMap) {
                file1 << key << ',';//变量地址
                file1 << value.vname << ',' << value.bbnum << ',' << value.fname << ',' << value.vlocate << ','
                     << value.user << ',' << value.vartype << ',' << value.dim << ',';
                for(int i =0 ;i<value.dim - 1;++i){
                    file1<<value.dimElems[i]<<",";
                }
                file1<<value.dimElems[value.dim - 1]<<'\n';
            }
            file1.close();
        }
    }

    void LinkChecker::varNameListImportToFile() {
        std::string filename =stringtofilename(dataFiles[3],1);//"varNameData.txt"
        std::ofstream file(filename);
        if (file.is_open()) {
            for (const auto& name : varNameList) {
                file << name.first << "," << name.second << "\n";
            }
            file.close();
        }
    }

    uint64_t LinkChecker::find_Vars(uint64_t addr) {
        //函数参数与传入变量链接
        if (!tmpLinkVar.count(addr) || tmpLinkVar[addr] == addr ||
          tmpLinkVar[addr] ==0) return addr; //本身是数组
          errs()<<tmpLinkVar[addr] <<" === "<<addr<<"\n";
        return find_Vars(tmpLinkVar[addr]);
    }

    void LinkChecker::tmpLinkVarListImportToFile() {

        for(auto addr :tmpLinkVar){
            //当这个变量也是一个临时变量时
//            errs()<<tmpLinkVar[addr.first] <<" === "<<addr.first<<"\n";
            tmpLinkVar[addr.first] = find_Vars(addr.first);
        }

        std::string filename =stringtofilename(dataFiles[4],1);//"tmpLinkVarList.txt"
        std::ofstream file(filename);
        if (file.is_open()) {
            for (const auto& addr : tmpLinkVar) {
                file << addr.first << "," << addr.second << "\n";
            }
            file.close();
        }
        errs()<<"tmLinkVar======================================\n";
        for(auto addr :tmpLinkVar){
            //当这个变量也是一个临时变量时
            errs()<<addr.first<<","<<addr.second<<"\n";
            errs()<<varsMap[addr.first].vname<<" : "<<
            varsMap[addr.second].vname<<"\n";
        }

    }


    void LinkChecker::FuncNameListImportToFile() {
        std::string filename = stringtofilename(dataFiles[5],1);//"funcNameData.txt"
        std::ofstream file(filename);
        if (file.is_open()) {
            for (const auto& name : funcNameList) {
                file << name << "\n";
            }
            file.close();
        }
    }

    void LinkChecker::loopsRange(Function& F) {

        //loopRangeList,DL->getFilename().str()
        auto Fname = F.getName().str();
        LoopInfo& LI = getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
        //loopRangeList[Fname];
        unsigned loopI = 1;
        std::vector<std::pair<unsigned, unsigned>>range;
        for (Loop* L : LI.getLoopsInPreorder()) {
            std::pair<unsigned, unsigned> PII;
            const DebugLoc& StartLoc = L->getStartLoc();
            unsigned startLine = 0, endLine = 0;
            auto* Latch = L->getLoopLatch();
            if (StartLoc) {
                startLine = StartLoc->getLine();
                PII.first = startLine;
            }
            //errs() << "The " << loopI++ << " Loop  : " << startLine << "-";

            if (!Latch) {
                auto* headerBB = L->getHeader();
                auto& Inst = headerBB->back();
                if (auto* Br = dyn_cast<BranchInst>(&Inst)) {
                    auto loopName = Br->getSuccessor(1)->getName();
                    if (loopName.find("end") != std::string::npos) {
                        auto* nextBB = Br->getSuccessor(1);
                        //get nextBB first Inst
                        auto& lastInst = nextBB->back();
                        if (auto DL = lastInst.getDebugLoc()) {
                            if (endLine < DL.getLine()) endLine = DL.getLine() - 1;
                        }
                    }
                }
                PII.second = endLine;
                range.push_back(PII);
                //errs() << endLine << "\n";// << " and is followed by line " << nextLine << "\n";
                continue;
            }
            const DebugLoc& EndLoc = Latch->getTerminator()->getDebugLoc();
            if (EndLoc) {
                endLine = EndLoc->getLine();
            }
            BasicBlock* lastBB = L->getBlocks().back(); // To keep track of the last BB in the loop
            for (BasicBlock* BB : L->getBlocks()) {
                for (auto I = BB->begin(); I != BB->end(); ++I) {
                    //errs() << *I << " \n";
                    const DebugLoc& Loc = I->getDebugLoc();
                    if (!Loc) {
                        continue;
                    }
                    unsigned line = Loc.getLine();
                    if (endLine < line) endLine = line;

                }
            }
            unsigned nextLine = startLine;
            while (lastBB->getNextNode() && nextLine <= endLine) {
                Instruction& firstInst = *(lastBB->getNextNode()->begin());
                const DebugLoc& firstLoc = firstInst.getDebugLoc();
                if (firstLoc) {
                    nextLine = firstLoc.getLine();
                }
                lastBB = lastBB->getNextNode();
            }
            if (nextLine > endLine) endLine = nextLine - 1;
            range.push_back(PII);
            PII.second = endLine;
            //errs() << endLine << "\n";

        }
        loopRangeList[Fname] = range;

        //DL->getFilename().str();


    }

    bool LinkChecker::isLoopRange(std::string fname, unsigned line) {
        if (loopRangeList.count(fname)) {
            auto range = loopRangeList[fname];
            for (auto& loop : range) {
                if (line >= loop.first && line <= loop.second)
                    return true;
            }
        }
        return false;
    }

    void LinkChecker::loadFromFileToLoopRange() {
        //获取LoopRange中数据
        std::string filename = stringtofilename(dataFiles[6],0);//"loopRangeData.txt"
        std::ifstream file(filename);

        if (file.is_open()) {
            std::string line;
            std::string key="";
            while (std::getline(file, line)) {
                if (line.empty()) {
                    continue;
                }
                if (line.find(",") == std::string::npos) {
                    key = line;
                    loopRangeList[key];
                }else if (line.find(",") != std::string::npos) {
                    std::vector<std::pair<unsigned, unsigned>>range;
                    std::pair<unsigned, unsigned> PII;
                    //从这开始加入
                    std::string str = "";
                    for (int i = 0; i < line.size(); ++i) {
                        if (line[i] != ',') {
                            str += line[i];
                        }
                        else {
                            PII.first = std::stoi(str);
                            str = "";
                        }
                    }
                    PII.second = std::stoi(str);
                    //errs() << PII.first << "," << PII.second << "\n";
                    range.push_back(PII);
                    while (std::getline(file, line) && line.find(",") != std::string::npos) {
                        str = "";
                        for (int i = 0; i < line.size(); ++i) {
                            if (line[i] != ',') {
                                str += line[i];
                            }
                            else {
                                PII.first = std::stoi(str);
                                str = "";
                            }
                        }
                        PII.second = std::stoi(str);
                        range.push_back(PII);
                    }
                    loopRangeList[key] = range;
                }
            }
            file.close();
        }
    }


    std::string LinkChecker::getTypeToString(Type* valType) {
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

    int LinkChecker::getMemSize(Type *T) {
        int size = 0;
        if (T->isPointerTy())
            return 8 * 8;
        else if (T->isFunctionTy())
            size = 0;
        else if (T->isLabelTy())
            size = 0;
        else if (T->isStructTy()) {
            StructType *S = dyn_cast<StructType>(T);
            for (unsigned i = 0; i != S->getNumElements(); i++) {
                Type *t = S->getElementType(i);
                size += getMemSize(t);
            }
        } else if (T->isFloatingPointTy()) {
            switch (T->getTypeID()) {
                case llvm::Type::HalfTyID: ///<  1: 16-bit floating point typ
                    size = 16;
                    break;
                case llvm::Type::FloatTyID: ///<  2: 32-bit floating point type
                    size = 4 * 8;
                    break;
                case llvm::Type::DoubleTyID: ///<  3: 64-bit floating point type
                    size = 8 * 8;
                    break;
                case llvm::Type::X86_FP80TyID: ///<  4: 80-bit floating point type (X87)
                    size = 10 * 8;
                    break;
                case llvm::Type::FP128TyID:
                    ///<  5: 128-bit floating point type (112-bit mantissa)
                    size = 16 * 8;
                    break;
                case llvm::Type::PPC_FP128TyID:
                    ///<  6: 128-bit floating point type (two 64-bits, PowerPC)
                    size = 16 * 8;
                    break;
                default:
                    errs() << "[ERROR]: Unknown floating point type " << *T << "\n";
                    assert(false);
            }
        } else if (T->isIntegerTy()) {
            size = cast<IntegerType>(T)->getBitWidth();
        } else if (T->isVectorTy()) {
//            size = cast<VectorType>(T)->getBitWidth();
            if (auto *vectorType = llvm::dyn_cast<llvm::VectorType>(T)) {
                llvm::ElementCount elementCount = vectorType->getElementCount();
                unsigned scalarSize = vectorType->getScalarSizeInBits();
                unsigned bitWidth = scalarSize * elementCount.getKnownMinValue();
                size = bitWidth;
            }
        } else if (T->isArrayTy()) {
            ArrayType *A = dyn_cast<ArrayType>(T);
            size = (int)A->getNumElements() *
                   A->getElementType()->getPrimitiveSizeInBits();
        } else {
            errs() << "[ERROR]: Unknown data type " << *T << "\n";
            assert(false);
        }

        return size;
    }

    unsigned LinkChecker::getVarSize(Value* var) {
        unsigned varsize = 0;
        if (var->getType()->isArrayTy()) {
            // 变量是数组
            ArrayType* arrType = dyn_cast<ArrayType>(var->getType());
            //// 访问数组元素类型和元素数量
            //Type* elemType = arrType->getElementType();
            varsize  = arrType->getNumElements();
        }
        return varsize;
    }


    //before
    void LinkChecker::loadFromFileToMainLoop() {
        std::string filename = stringtofilename(dataFiles[7],0);//"mainloopData.txt"
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

            file.close();
        }
        errs() << mainLoopFuncName << "\n";
        //errs() << mainloopbegin << " " << mainloopend << "\n";
    }

    void LinkChecker::insertFlag(Module& M) {
        int b = 1;
        unsigned eline = 429496729;
        Instruction* inst = nullptr;
//        errs()<<"insertFlag!!!!\n";
        GlobalVariable* cherflag = M.getGlobalVariable("cher_flag");
        for (auto& F : M) {
            for (auto& BB : F) {
                for (auto& I : BB) {
                    if (auto DL = I.getDebugLoc()) {
                        //errs() << DL->getFilename() << "\n";
                        if (!F.getName().str().compare(mainLoopFuncName)) {
                            unsigned LineNo = DL.getLine();
//                            errs() << LineNo << "lineno\n";
//                            errs()<<"mainloopFuncName : " << mainLoopFuncName<<"\n";
                            if (LineNo == mainloopbegin && b) {
                                IRBuilder<> builder(&I);
                                Value* flagValue = builder.CreateLoad(cherflag, "cher_flag");
                                Value* cmpValue = builder.CreateICmpEQ(flagValue, ConstantInt::get(Type::getInt32Ty(M.getContext()), 0), "cmp");
                                if (cmpValue) {
                                    b = 0;
//                                    errs() << LineNo << " " << I << " begin!\n";
//                                    errs()<<"flagName() : " <<F.getName()<<"\n";
                                    errs()<<"insert flag == 1 success!!!\n";
                                    //在这条指令的前面插入flag=1
                                    builder.SetInsertPoint(&I);
                                    builder.CreateStore(ConstantInt::get(Type::getInt32Ty(M.getContext()), 1), cherflag);
                                }
                            }
                            if (LineNo > mainloopend) {
                                if (eline > LineNo) {
                                    eline = LineNo;
                                    inst = &I;
                                }
                            }
                        }
                    }
                }
            }
        }
        if (inst) {
            IRBuilder<> builder(inst);
            Value* flagValue = builder.CreateLoad(cherflag, "cher_flag");
            Value* cmpValue = builder.CreateICmpEQ(flagValue, ConstantInt::get(Type::getInt32Ty(M.getContext()), 1), "cmp");
            if (cmpValue) {
                errs()<<"insert flag == 2 success!!!\n";
//                errs() << mainloopbegin << " begin <====> end " << mainloopend << "\n";
//                errs() << eline << " " << *inst << " end!\n";
                //在这条指令的前面插入flag=2
                builder.SetInsertPoint(inst);
                builder.CreateStore(ConstantInt::get(Type::getInt32Ty(M.getContext()), 2), cherflag);
            }
        }
    }

    bool LinkChecker::judgeFuncName(std::string fname) {
        for (auto& name : funcNameList) {
            if (fname == name) return true;
        }
        return false;

    }

    Function* LinkChecker::createFuncNumber(Module& M)
    {
        LLVMContext& context = M.getContext();
        IntegerType* intTy = Type::getInt32Ty(context);

        // Create function signature
        FunctionType* funcTy = FunctionType::get(intTy, { intTy }, false);
        Function* func = Function::Create(funcTy, GlobalValue::LinkageTypes::ExternalLinkage, "CALLBBNUM", M);

        return func;
    }

    void LinkChecker::bbIsNum(BasicBlock& BB, int count, Function* func, LLVMContext& context) {
        //获取BB块的第一条指令
        Instruction* firstInst = &*(BB.begin());

        if (firstInst->getOpcode() == Instruction::PHI) {
            firstInst = &BB.back();

            if (firstInst->getOpcode() != Instruction::Br ||
                firstInst->getOpcode() != Instruction::Ret) {
                if (firstInst->getPrevNode()) {
                    firstInst = firstInst->getPrevNode();
                }
            }
        }
        // 在当前基本块的头部创建一个 IRBuilder
        IRBuilder<> builder(firstInst);

        builder.SetInsertPoint(firstInst);
        // 创建一个整数类型的常量值
        Value* constInt = ConstantInt::get(Type::getInt32Ty(context), count);

        // 创建一个函数参数列表，将 count 添加到参数列表中
        std::vector<Value*> args;
        args.push_back(constInt);

        // 创建一个 call 指令，调用 func 函数，并将参数列表传递进去
        builder.CreateCall(func, args);
    }

    void LinkChecker::initDDGData(Module& M) {
        getGlobalVarNodeMessage(M);
        getLocalVarNodeMessage(M);
        getDDGMapMessage(M);
        ddgMapImportToFile();
        varNameListImportToFile();
        FuncNameListImportToFile();
        varsMapImportToFile();
//        tmpLinkVarListImportToFile();
    }



    bool LinkChecker::doInitialization(Module& M) {

        //func = createFuncNumber(M);
        loadFromFileToLoopRange();
//        aModule = M;
        //new(没有改变IR)
        initDDGData(M);

        //before
        loadFromFileToMainLoop();
        insertFlag(M);
        return true;
    }

    bool LinkChecker::runOnFunction(Function& F) {
        return false;
    }

    char LinkChecker::ID = 0;
    static RegisterPass<LinkChecker> X("linkchecker", "hello pass", false, false);



