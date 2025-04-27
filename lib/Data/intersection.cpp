#include <iostream>
#include <fstream>
#include <set>
#include <string>
#include <unordered_map>

// 从文件中提取变量名并存储在集合中
void extractVariables(const std::string& filename, std::set<std::string>& variables) {
    std::ifstream file(filename);
    if (!file.is_open()) {
        std::cerr << "无法打开文件: " << filename << std::endl;
        return;
    }

    std::string line;
    while (std::getline(file, line)) {
        variables.insert(line);
    }
    file.close();
}

// 过滤记录并将变量名写入新文件
void filterAndWriteVariables(const std::string& inputFilename, const std::string& outputFilename, const std::set<std::string>& variablesToFilter) {
    std::ifstream inputFile(inputFilename);
    std::ofstream outputFile(outputFilename);

    if (!inputFile.is_open()) {
        std::cerr << "无法打开文件: " << inputFilename << std::endl;
        return;
    }

    if (!outputFile.is_open()) {
        std::cerr << "无法打开文件: " << outputFilename << std::endl;
        return;
    }

    std::set<std::string> seen; // 用于记录已经处理过的变量名和函数名组合
    std::string line;
    while (std::getline(inputFile, line)) {
        std::string variableName, functionName;
        size_t commaPos = line.find(',');
        if (commaPos != std::string::npos) {
            variableName = line.substr(0, commaPos);
            functionName = line.substr(commaPos + 1);
            if (functionName == "globalVar" && variablesToFilter.find(variableName) != variablesToFilter.end()) {
                continue; // 跳过符合条件的记录
            }
            std::string key = variableName + "," + functionName;
            if (seen.find(key) == seen.end()) {
                seen.insert(key);
                outputFile << variableName << "\n";
            }
        }
    }

    inputFile.close();
    outputFile.close();
}

int main() {
    std::set<std::string> variablesToFilter;

    extractVariables("globalUser", variablesToFilter);

    filterAndWriteVariables("IO.txt", "unique_variables.txt", variablesToFilter);


    return 0;
}
