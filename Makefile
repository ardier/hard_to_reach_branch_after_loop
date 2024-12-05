# Compiler and flags
CXX ?= g++
CXXFLAGS ?= -O3 -g -std=c++17

# LLVM paths
LLVM_CONFIG := /home/nfs0/ardi.madadi/llvm/installed/bin/llvm-config
INCLUDES := -I$(shell $(LLVM_CONFIG) --includedir)
LDFLAGS := -L$(shell $(LLVM_CONFIG) --libdir)

# Directories and files
SRC_DIR := src
OBJ_DIR := obj
LIB_NAME := libexample.a
TEST_BINARY := test_example

# Source and object files
SRC_FILES := $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SRC_FILES))

# Default target
all: $(LIB_NAME) $(TEST_BINARY)

# Build the static library
$(LIB_NAME): $(OBJ_FILES)
	@mkdir -p $(OBJ_DIR)
	ar rcs $@ $^

# Compile object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

# Build the test binary
$(TEST_BINARY): $(LIB_NAME) $(OBJ_DIR)/test_example.o
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $(OBJ_DIR)/test_example.o $(LIB_NAME)

# Clean generated files
clean:
	rm -rf $(OBJ_DIR) $(LIB_NAME) $(TEST_BINARY)
