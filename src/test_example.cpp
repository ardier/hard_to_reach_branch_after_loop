#include "example.hpp"
#include <iostream>
#include <string>

int main() {
    std::cout << "Enter input (comma-separated integers, e.g., '3,5'): ";
    std::string input;
    std::getline(std::cin, input);

    // Call the core processing logic
    processInput(input);

    return 0;
}
