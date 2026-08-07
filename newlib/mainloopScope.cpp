#include <fstream>
#include <iostream>

#include "CheckerPaths.h"

int main(int argc, char** argv) {
//    printf("Enter the range of the main loop in turn (the start line number and the end line number in the c file where the main loop is located) are separated by `,` in the middle, such as: 184,218\n");
//    scanf("%d,%d", &mainloopbegin, &mainloopend);
//    printf("Please enter the function name where the main loop is located, such as main\n");
    std::string mainloopbegin, mainloopend,funcName;
    if(argc > 3){
        mainloopbegin = argv[1];
        mainloopend = argv[2];
        funcName = argv[3];
    }
//    std::cin >> funcName;
    std::ofstream file(cher_dataDir() + "mainloopData.txt");
    if (file.is_open()) {
        file << mainloopbegin << "," << mainloopend << "\n";
        file << funcName << "\n";
        file.close();
    }
    return 0;
}

