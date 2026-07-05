#! /usr/bin/bash
set -e

mkdir -p build
cd build

# upstream's CMakeLists.txt asks for CMake 2.6 -- modern CMake dropped
# compatibility with anything below 3.5 outright.
export CMAKE_POLICY_VERSION_MINIMUM=3.5

# CMakeLists.txt's own HepMC3 detection predates HepMC3's modern CMake
# targets: it reads plain HEPMC3_INCLUDE_DIR/HEPMC3_LIB variables that
# HepMC3Config.cmake (3.x, target-based) never sets, so find_package()
# alone leaves them empty and the compile fails on missing headers.
# Force the values directly instead of trusting find_package to fill them.
cmake .. \
  -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
  -DCMAKE_BUILD_TYPE=Release \
  -DENABLE_HEPMC3=On \
  -DHepMC3_DIR="${PREFIX}/share/HepMC3/cmake" \
  -DHEPMC3_INCLUDE_DIR="${PREFIX}/include" \
  -DHEPMC3_LIB="${PREFIX}/lib/libHepMC3.so" \
  -DENABLE_PYTHIA=Off \
  -DENABLE_PYTHIA6=Off

NPROC=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
make VERBOSE=1 -j"$NPROC"
make install
