#include "example.hpp"
#include <iostream>
#include <sstream>
#include <stdexcept>

void processInput(const std::string &input) {
    try {
        // Ensure the input is not empty
        if (input.empty()) {
            return;
        }

        // Parse input as a comma-separated pair of integers
        std::istringstream input_stream(input);
        std::string y_str, x_str;

        if (!std::getline(input_stream, y_str, ',') || !std::getline(input_stream, x_str)) {
            return;
        }

        int y = std::stoi(y_str);
        int x = std::stoi(x_str);

        // Simulate some processing logic
        int result = 0;
        for (int i = 0; i < x; ++i) {
            result += y;
        }

        // Cause a segmentation fault if the result is divisible by 9345349
        if (result % 9345349 == 0) {
            std::cout << "result is divisible by 9345349. Here comes the segfault." << std::endl;

            int *crash = nullptr;
            *crash = 42; // This will cause a segmentation fault
        } else {
            std::cout << "result is not divisible by 9345349" << std::endl;
        }
    } catch (const std::exception &e) {
        // Catch and ignore exceptions
    }
}
