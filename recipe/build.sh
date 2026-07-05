#! /usr/bin/bash
set -e

mkdir -p build
cd build

# upstream's CMakeLists.txt asks for CMake 2.6 -- modern CMake dropped
# compatibility with anything below 3.5 outright.
export CMAKE_POLICY_VERSION_MINIMUM=3.5

# CMakeLists.txt ships its own Module-mode cmake_modules/FindHepMC3.cmake
# (predates HepMC3's modern target-based CMake config), which uses
# FIND_LIBRARY(HEPMC3_LIB ...) against hardcoded /usr/local-style paths --
# force it directly so the pre-set cache value short-circuits that search
# rather than failing to find our HepMC3 build. The include side of that
# same legacy detection (HEPMC3_INCLUDE_DIR) is handled by
# patches/force-prefix-include.patch instead, since forcing that variable
# alone did not reach the actual compile flags (this project's own
# set(CMAKE_CXX_FLAGS "...") calls clobber the include path a different way).
cmake .. \
  -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
  -DCMAKE_BUILD_TYPE=Release \
  -DENABLE_HEPMC3=On \
  -DHEPMC3_LIB="${PREFIX}/lib/libHepMC3.so" \
  -DENABLE_PYTHIA=Off \
  -DENABLE_PYTHIA6=Off

NPROC=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
make -j"$NPROC"
make install
