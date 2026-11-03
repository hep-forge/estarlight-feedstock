# macOS only (see build.sh). eStarlight sets CMAKE_CXX_FLAGS to its own
# "-Wall -Wextra -Werror", so CXXFLAGS never reach the compiler. Compile
# options come after those flags. Clang warns about more than GCC
# (-Warray-parameter, -Wvla-cxx-extension, -Wunused-but-set-variable that
# the project only exempts for GCC...): on macOS warnings stay warnings.
add_compile_options(-Wno-error)

# The sources also use the BSD/glibc shorthand type "uint", which glibc
# headers define and macOS's do not in strict mode.
add_compile_definitions(uint=unsigned)
