# Compiler and flags
CXX = g++
CXXFLAGS = -g -O1 -std=c++17

# # Dynamically locate the __config_site directory
# CONFIG_SITE_DIR := $(shell find $$(llvm-config --prefix) -name "__config_site" 2>/dev/null | xargs -r dirname | head -n 1)

# # Add the __config_site directory to include paths
# CXXFLAGS += -I$(CONFIG_SITE_DIR)

# Directories
SRC_DIR = src
OBJ_DIR = obj

# Files
LIB_NAME = libexample.a
PROGRAM_NAME = test_program

# Source and object files
SRC_FILES = $(SRC_DIR)/example.cpp $(SRC_DIR)/test_example.cpp
OBJ_FILES = $(OBJ_DIR)/example.o $(OBJ_DIR)/test_example.o

# Default target
all: $(PROGRAM_NAME)

# Build the static library
$(LIB_NAME): $(OBJ_DIR)/example.o
	ar rcs $@ $<

# Compile source files into object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Build the final program
$(PROGRAM_NAME): $(LIB_NAME) $(OBJ_DIR)/test_example.o
	$(CXX) $(CXXFLAGS) $(OBJ_DIR)/test_example.o -L. -lexample -o $@

# Clean up generated files
clean:
	rm -f $(OBJ_DIR)/*.o $(LIB_NAME) $(PROGRAM_NAME)
