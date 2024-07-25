#!/bin/bash

export BUILD_GCC_ROOT=/data/qtteam/work/cross-compile/gcc-linaro-7.5.0-arm-linux-gnueabihf/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf
export BUILD_SYS_ROOT=/data/qtteam/work/cross-compile/sysroot-rk3288
export BUILD_QT_ROOT=/data/qtteam/work/cross-compile/qt-install-5.14.1-linux-arm-rk3288-dynamic
export BUILD_QT_SPEC=linux-arm-gnueabi-g++
export QTDIR=$BUILD_QT_ROOT
export PATH=$BUILD_GCC_ROOT/bin:$PATH
export PKG_CONFIG_SYSROOT_DIR=$BUILD_SYS_ROOT
export PKG_CONFIG_PATH=$BUILD_SYS_ROOT/usr/lib/pkgconfig:$BUILD_SYS_ROOT/lib/pkgconfig