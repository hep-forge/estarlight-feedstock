# macOS only (see build.sh). eStarlight sets CMAKE_CXX_FLAGS to its own
# "-Wall -Wextra -Werror", so CXXFLAGS never reach the compiler. Compile
# options come after those flags: clang's -Warray-parameter (GCC has no such
# warning) stays a warning.
add_compile_options(-Wno-error=array-parameter)
