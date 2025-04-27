#include "findcv.h"
#include <llvm/IR/IRBuilder.h>
char findcv::ID = 0;
static llvm::RegisterPass<findcv> X("findcv", "hello pass", false, false);

void findcv::getGlobalVarNodeMessage(llvm::Module &M) {
    for (auto &G : M.globals()) {
        if (G.hasInitializer()) {
            void *addr = &G;
            std::string name = G.getName().str();
            if (name == "cher_flag" || name.find(".str") != std::string::npos) {
                continue; // flag 为自定义全局变量
            }

            llvm::GlobalVariable *GV = llvm::dyn_cast<llvm::GlobalVariable>(&G);
            uint64_t g_addr = reinterpret_cast<uint64_t>(addr);

            m_vnode = {g_addr, name, "globalVar", 1};
            varsGlobalData.insert(std::make_pair(g_addr, m_vnode));
        }
    }
    llvm::errs()<<"global variables : "<<varsGlobalData.size()<<"\n";

    for(auto &gnode:varsGlobalData){
        llvm::errs()<<gnode.first<<": "<<gnode.second.vname<<","<<gnode.second.fname<<"\n";
    }
}

void findcv::getLocalVarNodeMessage(llvm::Module &M) {
    for (auto &F : M) {
        auto Fname = F.getName().str();
        if (checkedFuncName(Fname) || F.isDeclaration()) continue;
        funcsData[Fname] = &F;
        for (auto &BB : F) {
            auto BBname = BB.getName().str();
            if (BBname.find("invoke") != std::string::npos ||
                BBname.find("lpad") != std::string::npos ||
                BBname.find("ehcleanup") != std::string::npos)
                continue;

            for (auto &I : BB) {
                if (I.getOpcode() == llvm::Instruction::Alloca) {
                    if (auto *AI = llvm::dyn_cast<llvm::AllocaInst>(&I)) {
                        auto varname = AI->getName().str();
                        if(varname.find(".addr")!=std::string::npos) continue;
                        uint64_t addr = reinterpret_cast<uint64_t>(AI);
                        m_vnode = {addr, varname, Fname, 1};
                        varsTmpData.insert(std::make_pair(addr, m_vnode));
                    }
                }
            }
        }
    }
    llvm::errs()<<"temp variables " << varsTmpData.size() <<"\n";

    for(auto &tnode:varsTmpData){
        llvm::errs()<<tnode.first<<": "<<tnode.second.vname<<","<<tnode.second.fname<<"\n";
    }
}


void findcv::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
    AU.setPreservesAll();
    AU.addRequired<llvm::LoopInfoWrapperPass>();
}

void findcv::checkVariableInLoop(const llvm::Function &F, const llvm::LoopInfo &LI) {
    for (const auto &BB : F) { // 遍历每个基本块
        auto BBname = BB.getName().str();
        if (BBname.find("invoke") != std::string::npos ||
            BBname.find("lpad") != std::string::npos ||
            BBname.find("ehcleanup") != std::string::npos)
            continue;

        for (const auto &I : BB) { // 遍历每个指令
            if (const auto *AI = llvm::dyn_cast<llvm::AllocaInst>(&I)) {
                uint64_t addr = reinterpret_cast<uint64_t>(AI);
                auto varname = AI->getName().str();
                // 检查该指令是否在循环中
                const auto *ParentBB = AI->getParent();
                const auto *L = LI.getLoopFor(ParentBB);
                if (L) {
                    auto it = varsTmpData.find(addr);
                    if (it != varsTmpData.end()) {
                        varNode vnode = it->second;
                        vnode.m_user = 0; // 0 表示在循环中
                        varsTmpData[addr] = vnode;
                    }
                }
            }
        }
    }
}

void findcv::writeResultsToFile() {
    std::ofstream outFile("temp_variables.txt");
    if (!outFile.is_open()) {
        llvm::errs() << "Failed to open output file.\n";
        return;
    }
    // 输出局部变量
    int k = 0;
    outFile << varsTmpData.size()<<"\n";
    for (const auto &entry : varsTmpData) {
        outFile << "Address: " << entry.first << ", Name: " << entry.second.vname << ", user: "<<entry.second.m_user<<"\n";
        if(entry.second.m_user == 1) k++;
    }
    outFile<< k<<"\n";
    outFile.close();
}

bool findcv::checkedFuncName(std::string funcName) {
    if (funcName == "printf" || funcName == "scanf" || funcName == "getchar" ||
        funcName == "putchar" || funcName == "fgets" || funcName == "fputs" ||
        funcName == "strcpy" || funcName == "strncpy" || funcName == "strlen" ||
        funcName == "strcmp" || funcName == "strncmp" || funcName == "strcat" ||
        funcName == "strncat" || funcName == "strchr" || funcName == "strstr" ||
        funcName == "sprintf" || funcName == "sscanf" || funcName == "sqrt" ||
        funcName == "fabs" || funcName == "sin" || funcName == "cos" ||
        funcName == "tan" || funcName == "exp" || funcName == "log" ||
        funcName == "pow" || funcName == "fopen" || funcName == "fclose" ||
        funcName == "fread" || funcName == "fwrite" || funcName == "fseek" ||
        funcName == "ftell" || funcName == "fprintf" || funcName == "fscanf" ||
        funcName == "time" || funcName == "localtime" || funcName == "strftime" || funcName == "atoi" ||
        funcName == "memcpy" || funcName == "_Znam" || funcName == "_Znaj" || funcName == "calloc" ||
        funcName == "realloc" || funcName == "free" || funcName == "_Z7mytimerv" || funcName == "calloc" ||
        funcName == "malloc" || funcName == "vfprintf" || funcName == "vprintf" || funcName == "vsprintf"


            ) return true;
    if (funcName.find("llvm.") != std::string::npos || funcName.find("__iso") != std::string::npos ||
        funcName == "CALLBBNUM") return true;
    return false;
}

bool findcv::insertFlag(llvm::Module& M) {
    int b = 1;
    unsigned eline = 4196729;
    llvm::Instruction* inst = nullptr;
    llvm::GlobalVariable* cherflag = M.getGlobalVariable("cher_flag");
    if(cherflag == nullptr) return false;
    for (auto& F : M) {
        for (auto& BB : F) {
            for (auto& I : BB) {
                if (auto DL = I.getDebugLoc()) {

                    if (!F.getName().str().compare(mainLoopFuncName)) {
                        unsigned LineNo = DL.getLine();

                        if (LineNo == mainloopbegin && b) {
                            llvm::IRBuilder<> builder(&I);
                            llvm::Value* flagValue = builder.CreateLoad(cherflag, "cher_flag");
                            llvm::Value* cmpValue = builder.CreateICmpEQ(flagValue, llvm::ConstantInt::get(llvm::Type::getInt32Ty(M.getContext()), 0), "cmp");
                            if (cmpValue) {
                                b = 0;
                                llvm::errs() << "flagName() : " << F.getName() << "\n";
                                llvm::errs() << "insert flag == 1 success!!!\n";
                                //在这条指令的前面插入flag=1
                                builder.SetInsertPoint(&I);
                                builder.CreateStore(llvm::ConstantInt::get(llvm::Type::getInt32Ty(M.getContext()), 1), cherflag);
                            }
                        }
                        if (LineNo > mainloopend) {
                            if (eline > LineNo) {
                                eline = LineNo;
                                inst = &I;
                            }
                        }

                        if (auto *Call = llvm::dyn_cast<llvm::CallInst>(&I)) {
                            std::string cfname = Call->getName().str();
                            if (visited_funcs.find(cfname) == visited_funcs.end()) {
                                BFS(cfname);
                            }
                        }

                    }
                }
            }
        }
    }
    if (inst) {
        llvm::IRBuilder<> builder(inst);
        llvm::Value* flagValue = builder.CreateLoad(cherflag, "cher_flag");
        llvm::Value* cmpValue = builder.CreateICmpEQ(flagValue, llvm::ConstantInt::get(llvm::Type::getInt32Ty(M.getContext()), 1), "cmp");
        if (cmpValue) {
            llvm::errs() << "insert flag == 2 success!!!\n";
            builder.SetInsertPoint(inst);
            builder.CreateStore(llvm::ConstantInt::get(llvm::Type::getInt32Ty(M.getContext()), 2), cherflag);
        }
    }
    return true;
}

bool findcv::initData(llvm::Module& M){
    std::ofstream outFile("global_variables.txt");
    if (!outFile.is_open()) {
        llvm::errs() << "Failed to open output file.\n";
        return false;
    }
    outFile << varsGlobalData.size()<<"\n";
    for (const auto &entry : varsGlobalData) {
        outFile << "Address: " << entry.first << ", Name: " << entry.second.vname << ", user: "<<entry.second.m_user<<"\n";
    }
    outFile.close();
  //  loadCgData();
//    insertFlag(M);
    //for(const auto &name : visited_funcs){
     //   llvm::errs()<<"main loop functions name : " << name <<" , ";
   // }
    //llvm::errs()<<"\n";
}

void findcv::loadCgData() {
    std::string filename = "config.data";
    std::ifstream file(filename);
    if (!file.is_open()) {
//        std::cerr << "Error opening config.data" << std::endl;
        return;
    }
    std::string line;
    if (std::getline(file, line)) {
        std::stringstream ss(line); // 使用字符串流处理读取的行
        /// 使用','作为分隔符读取整数和字符串 ---- 获取main loop range
        if (ss >> mainloopbegin && ss.ignore() && ss >> mainloopend && ss.ignore() && std::getline(ss, mainLoopFuncName)) {
            llvm::errs() << mainloopbegin << "," << mainloopend << "," << mainLoopFuncName << "\n";
        }
    }
    file.close();
}
void findcv::BFS(std::string funcName){
    std::queue<std::string> funcsQueue;
    std::unordered_set<std::string> call_funcs;

    funcsQueue.push(funcName);
    visited_funcs.insert(funcName);
    call_funcs.insert(funcName);

    while (!funcsQueue.empty()) {
        auto current_fname = funcsQueue.front();
        funcsQueue.pop();

        auto it = funcsData.find(current_fname);
        if (it != funcsData.end()) {
            llvm::Function &F = *it->second;
            for (auto &BB : F) {  // 遍历每个基本块
                for (auto &I : BB) {  // 遍历每个指令
                    if (auto *Call = llvm::dyn_cast<llvm::CallInst>(&I)) {
                        if (auto *callee = Call->getCalledFunction()) {
                            std::string cfname = callee->getName().str();
                            if (visited_funcs.find(cfname) == visited_funcs.end()) {
                                funcsQueue.push(cfname);
                                visited_funcs.insert(cfname);
                                call_funcs.insert(cfname);
                            }
                        }
                    }
                }
            }
        }
    }

    // 在这里可以根据call_funcs集合来进一步处理找到的被调函数相关信息，比如输出等
    for (const auto &cfname : call_funcs) {
        if(visited_funcs.find(cfname) == visited_funcs.end())
            BFS(cfname);
    }

}
bool findcv::doInitialization(llvm::Module &M) {
    getGlobalVarNodeMessage(M);
    getLocalVarNodeMessage(M);
//    writeResultsToFile();
    //创建全局变量
    llvm::Type *intType = llvm::Type::getInt32Ty(M.getContext());
    cher_flag = new llvm::GlobalVariable(M, intType, false, llvm::GlobalValue::ExternalLinkage, llvm::ConstantInt::get(intType, 0), "cher_flag");
    initData(M);
    return true;
}

bool findcv::runOnFunction(llvm::Function &F) {
    auto Fname = F.getName().str();
    if (checkedFuncName(Fname) || F.isDeclaration()) {
        return false;
    } else {
        llvm::LoopInfo &LI = getAnalysis<llvm::LoopInfoWrapperPass>().getLoopInfo();
        checkVariableInLoop(F, LI);
    }
    functionIter++;
    writeResultsToFile();
    llvm::errs()<<"functionIter : "<<functionIter<<"\n";
    return true; // 返回true表示修改了IR
}
