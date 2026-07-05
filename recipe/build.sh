#! /usr/bin/bash
set -e

mkdir -p build
cd build

# upstream's CMakeLists.txt asks for CMake 2.6 -- modern CMake dropped
# compatibility with anything below 3.5 outright.
export CMAKE_POLICY_VERSION_MINIMUM=3.5

cmake .. \
  -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
  -DCMAKE_BUILD_TYPE=Release \
  -DENABLE_HEPMC3=On \
  -DHepMC3_DIR="${PREFIX}/share/HepMC3/cmake" \
  -DENABLE_PYTHIA=Off \
  -DENABLE_PYTHIA6=Off

NPROC=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
make -j"$NPROC"
make install
