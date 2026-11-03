# macOS only (see build.sh). eStarlight sets CMAKE_CXX_FLAGS to its own
# "-Wall -Wextra -Werror", so CXXFLAGS never reach the compiler. Compile
# options come after those flags: clang-only warnings its sources trip
# (-Warray-parameter, -Wvla-cxx-extension; GCC has neither) stay warnings.
add_compile_options(-Wno-error=array-parameter -Wno-error=vla-cxx-extension)

# The sources also use the BSD/glibc shorthand type "uint", which glibc
# headers define and macOS's do not in strict mode.
add_compile_definitions(uint=unsigned)
