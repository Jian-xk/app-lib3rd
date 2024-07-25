#!/bin/bash

export BUILD_GCC_ROOT=/data/qtteam/work/cross-compile/buildroot-rk3568
export BUILD_SYS_ROOT=/data/qtteam/work/cross-compile/buildroot-rk3568/aarch64-buildroot-linux-gnu/sysroot
export BUILD_QT_ROOT=/data/qtteam/work/cross-compile/qt-install-5.14.1-linux-aarch64-rk3568-dynamic
export BUILD_QT_SPEC=linux-aarch64-rk3568
export QTDIR=$BUILD_QT_ROOT
export PATH=$BUILD_GCC_ROOT/bin:$PATH
export PKG_CONFIG_SYSROOT_DIR=$BUILD_SYS_ROOT
export PKG_CONFIG_PATH=$BUILD_SYS_ROOT/usr/lib/pkgconfig:$BUILD_SYS_ROOT/lib/pkgconfig

# for gcc libs
export LD_LIBRARY_PATH=$BUILD_GCC_ROOT/lib:$LD_LIBRARY_PATH