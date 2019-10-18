#!/usr/bin/env bash
echo "CMake timsort C++ library"
mkdir -p priv/cpp-TimSort
# Run CMake to configure the project for the local system
cmake -H. -Ssrc/cpp-TimSort -Bpriv/cpp-TimSort/build -DCMAKE_BUILD_TYPE=Release
cd priv/cpp-TimSort/build
# `make` the project to build the binaries.
make
