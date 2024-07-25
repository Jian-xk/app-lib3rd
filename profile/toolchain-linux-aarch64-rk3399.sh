#!/bin/bash

export BUILD_GCC_ROOT=/data/qtteam/work/cross-compile/gcc-linaro-7.4.1-linux-gnu-aarch64/gcc-linaro-7.4.1-aarch64
export BUILD_SYS_ROOT=/data/qtteam/work/cross-compile/sysroot-rk3399
export BUILD_QT_ROOT=/data/qtteam/work/cross-compile/qt-install-5.14.1-linux-aarch64-rk3399-dynamic
export BUILD_QT_SPEC=linux-aarch64-gnu-g++
export QTDIR=$BUILD_QT_ROOT
export PATH=$BUILD_GCC_ROOT/bin:$PATH
export PKG_CONFIG_SYSROOT_DIR=$BUILD_SYS_ROOT
export PKG_CONFIG_PATH=$BUILD_SYS_ROOT/usr/lib/pkgconfig:$BUILD_SYS_ROOT/lib/pkgconfig
