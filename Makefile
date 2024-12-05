# Dynamically determine llvm-config and clang++ paths
LLVM_CONFIG = $(shell which llvm-config)
CLANG_PATH = $(shell $(LLVM_CONFIG) --bindir)/clang++

# Compiler and flags
CXX = $(CLANG_PATH)
CXXFLAGS = -g -O1 -std=c++17

# Dynamically inferred include and library paths
INCLUDES = -I$(shell $(LLVM_CONFIG) --includedir)/c++/v1
LIBDIRS = -L$(shell $(LLVM_CONFIG) --libdir)

# Add libc++ standard library
STD_LIB = -stdlib=libc++

# Source files and targets
SRC_DIR = src
SRC_FILES = $(SRC_DIR)/example.cpp
HEADER_FILES = $(SRC_DIR)/example.hpp
OBJ_FILES = $(SRC_FILES:.cpp=.o)

LIB_NAME = libexample.a
TEST_BINARY = test_example
TEST_SOURCE = $(SRC_DIR)/test_example.cpp

# Default target
all: $(LIB_NAME) $(TEST_BINARY)

# Build the static library
$(LIB_NAME): $(OBJ_FILES)
	ar rcs $@ $^

# Compile source files into object files
%.o: %.cpp $(HEADER_FILES)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

# Build the test binary
$(TEST_BINARY): $(TEST_SOURCE) $(LIB_NAME)
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(LIBDIRS) $(STD_LIB) -o $@ $^ -L.

# Clean up generated files
clean:
	rm -f $(OBJ_FILES) $(LIB_NAME) $(TEST_BINARY)
