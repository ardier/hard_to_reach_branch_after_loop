
# Directories
SRC_DIR = src
OBJ_DIR = obj

# Files
LIB_NAME = libexample.a
PROGRAM_NAME = test_program

# Source and object files
SRC_FILES = $(SRC_DIR)/example.cpp $(SRC_DIR)/test_example.cpp
OBJ_FILES = $(addprefix $(OBJ_DIR)/, $(notdir $(SRC_FILES:.cpp=.o)))

# Default target
all: $(LIB_NAME)

# Build the static library
$(LIB_NAME): $(OBJ_DIR)/example.o
	ar rcs $@ $<

# Compile source files into object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean up generated files
clean:
	rm -rf $(OBJ_DIR) $(LIB_NAME) $(PROGRAM_NAME)
