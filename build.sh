#!/bin/bash
#
# SdtElectronics 2021
#
# Modified based on https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=cling
# and https://github.com/Axel-Naumann/cling-all-in-one/blob/master/clone.sh
#
# arguments:
#   [cores]  number of cores to use, optional
#            default: all detected cores

git clone -b cling-patches http://root.cern.ch/git/llvm.git --depth=1
git clone -b cling-patches http://root.cern.ch/git/clang.git --depth=1
git clone http://root.cern/git/cling.git --depth=1 

cores=${1:-$nproc}
 
srcdir=`pwd`
 
python=`which python`
if type python2 > /dev/null 2>&1; then
    python=`which python2`
fi
if type python3 > /dev/null 2>&1; then
    python=`which python3`
fi

prepare() {
    if [ ! -h "$srcdir/llvm/tools/clang" ]; then
        ln -s "$srcdir/clang" "$srcdir/llvm/tools/clang"
    fi

    if [ ! -h "$srcdir/llvm/tools/cling" ]; then
        ln -s "$srcdir/cling" "$srcdir/llvm/tools/cling"
    fi
}

build() {
    mkdir -p "$srcdir/release"
    mkdir -p "$srcdir/build"
    cd "$srcdir/build"

    INSTDIR="$srcdir/release"
    
    cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_CXX_STANDARD=17 \
        -DCMAKE_CXX_FLAGS="-std=c++17" \
        -DCMAKE_INSTALL_PREFIX=$INSTDIR \
        -DLLVM_TARGETS_TO_BUILD="host;NVPTX" \
        -DLLVM_BUILD_LLVM_DYLIB=OFF \
        -DLLVM_ENABLE_RTTI=ON \
        -DLLVM_ENABLE_FFI=ON \
        -DLLVM_BUILD_DOCS=OFF \
        -DLLVM_BUILD_TOOLS=OFF \
        -DPYTHON_EXECUTABLE=$python \
        -DLLVM_ENABLE_SPHINX=OFF \
        -DLLVM_ENABLE_DOXYGEN=OFF \
        -DFFI_INCLUDE_DIR=$(pkg-config --cflags-only-I libffi | cut -c3-) \
        "$srcdir/llvm"

    make -j$cores -C tools/clang
    make -j$cores -C tools/cling
    make -j$cores install
}

prepare

build
