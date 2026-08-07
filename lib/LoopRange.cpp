#include "llvm/Pass.h"

#include "llvm/IR/Value.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/DebugLoc.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Analysis/LoopInfo.h"

#include "llvm/Support/Debug.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"

#include <map>
#include <vector>
#include <stack>
#include <string>
#include <utility>
#include <fstream>



using namespace llvm;

#include "CheckerPaths.h"

#define FILELIB (cher_dataDir() + "loopRangeData.txt")


namespace {
    struct LoopRange : public FunctionPass {
        static char ID;
        LoopRange() : FunctionPass(ID) {}

        void getAnalysisUsage(AnalysisUsage& AU) const override {
            AU.setPreservesAll();
            AU.addRequired<LoopInfoWrapperPass>();
        }

        //存储循环的范围列表(带函数名前缀)
        std::map<std::string, std::vector<std::pair<unsigned, unsigned>>>loopRangeList;
        void loopsRange(Function& F) {
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
                PII.second = endLine;
                range.push_back(PII);
                //errs() << endLine << "\n";

            }
            loopRangeList[Fname] = range;

        }

        void loopRangeImportToFile() {
            // 打开文件并将数据写入
            std::ofstream file(FILELIB);
            if (file.is_open()) {
                for (auto& range : loopRangeList) {
                    file << range.first << "\n";
                    for (auto& loop : range.second) {
                        file << loop.first << "," << loop.second << "\n";
                    }
                    file << "\n";
                }
                file.close();
            }
        }

        void printAllIns(Function& F) {
            errs() << F.getName() << "\n";
            for (auto& BB : F) {
                errs() << BB.getName() << "\n";
            }
            errs() << "\n";
        }

        bool runOnFunction(Function& F) override {
            loopsRange(F);
            loopRangeImportToFile();
            return false;
        }
    };

}

char LoopRange::ID = 0;
static RegisterPass<LoopRange> X("looprange", "Loop Range Pass", false, false);



