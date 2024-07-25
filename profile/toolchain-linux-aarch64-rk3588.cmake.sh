#!/bin/bash

export BUILD_GCC_ROOT=/data/qtteam/work/cross-compile/buildroot-rk3588
export BUILD_SYS_ROOT=/data/qtteam/work/cross-compile/buildroot-rk3588/aarch64-buildroot-linux-gnu/sysroot

# for gcc libs
export LD_LIBRARY_PATH=$BUILD_GCC_ROOT/lib:$LD_LIBRARY_PATH