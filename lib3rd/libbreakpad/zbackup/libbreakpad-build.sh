#!/bin/bash

# usage
if [ ! -n "$1" ] || [ ! -n "$2" ]; then
    echo "Usage xxx-build.sh [platform] </path/to/zipfile>"
    exit 1
fi

profile_dir=$PROFILE_DIR
if [ ! -n "$profile_dir" ] ; then
    profile_dir=$PWD
fi

build_platform=$1
build_zipfile=$2
build_platform_env=$profile_dir/toolchain-$build_platform.sh
build_platform_cmake=$profile_dir/toolchain-$build_platform.cmake

if [ ! -f "$build_platform_env" ] || [ ! -f "$build_platform_cmake" ]; then
    echo "build platform unsupported"
    exit 1
fi

if [ "${build_platform: -1}" = "d" ]; then
    build_type='debug'
else
    build_type='release'
fi

if [ "${build_zipfile: -3}" = "zip" ]; then
    unzip -o $build_zipfile
else
    tar -xvf $build_zipfile
fi

for file in `ls ./`; do
    if [ -d $file ]; then
        build_srcdir=$PWD/$file
        build_tmpdir="$PWD/$file/build-$build_platform"
        break
    fi
done

build_lss_dir=$build_srcdir/src/third_party/lss
build_lss_file="$PWD/lss/linux_syscall_support.h"
if [ ! -d $build_lss_dir ]; then
    mkdir -pv $build_lss_dir
fi
if [ -f $build_lss_file ]; then
    cp -rfv $build_lss_file $build_lss_dir
fi

if [ -d $build_tmpdir ] && [ "$build_tmpdir" != "/" ]; then
    rm -rfv $build_tmpdir
fi
mkdir -pv $build_tmpdir

source $build_platform_env

build_options="--prefix=$build_tmpdir/install"

if [ "$build_type" = "debug" ]; then
    echo "delete -g in Makefile "
else
    echo "delete -g in Makefile"
fi

if [[ "${build_platform[@]}" =~ "linux-aarch64-rk3308" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3328" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3566" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3568" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3569" ]]; then

    if [[ "${build_platform[@]}" =~ "linux-aarch64-rk3308" ]]; then
        build_options="$build_options --host=aarch64-rockchip-linux-gnu CC=$BUILD_GCC_ROOT/bin/aarch64-rockchip-linux-gnu-gcc CXX=$BUILD_GCC_ROOT/bin/aarch64-rockchip-linux-gnu-g++ AR=$BUILD_GCC_ROOT/bin/aarch64-rockchip-linux-gnu-gcc-ar RANLIB=$BUILD_GCC_ROOT/bin/aarch64-rockchip-linux-gnu-gcc-ranlib --disable-tools"
    else
        build_options="$build_options --host=aarch64-buildroot-linux-gnu CC=$BUILD_GCC_ROOT/bin/aarch64-buildroot-linux-gnu-gcc CXX=$BUILD_GCC_ROOT/bin/aarch64-buildroot-linux-gnu-g++ AR=$BUILD_GCC_ROOT/bin/aarch64-buildroot-linux-gnu-gcc-ar RANLIB=$BUILD_GCC_ROOT/bin/aarch64-buildroot-linux-gnu-gcc-ranlib --disable-tools"
    fi
elif [[ "${build_platform[@]}" =~ "linux-arm" ]]; then
    build_options="$build_options --host=arm-linux-gnueabihf CC=$BUILD_GCC_ROOT/bin/arm-linux-gnueabihf-gcc CXX=$BUILD_GCC_ROOT/bin/arm-linux-gnueabihf-g++ AR=$BUILD_GCC_ROOT/bin/arm-linux-gnueabihf-gcc-ar RANLIB=$BUILD_GCC_ROOT/bin/arm-linux-gnueabihf-gcc-ranlib --disable-tools"
elif [[ "${build_platform[@]}" =~ "linux-aarch64" ]]; then
    build_options="$build_options --host=aarch64-linux-gnu CC=$BUILD_GCC_ROOT/bin/aarch64-linux-gnu-gcc CXX=$BUILD_GCC_ROOT/bin/aarch64-linux-gnu-g++ AR=$BUILD_GCC_ROOT/bin/aarch64-linux-gnu-gcc-ar RANLIB=$BUILD_GCC_ROOT/bin/aarch64-linux-gnu-gcc-ranlib --disable-tools"
fi

cd $build_srcdir
echo "./configure $build_options"
./configure $build_options

if [ "$build_type" = "debug" ]; then
    make
    make install
else
    echo "delete -g in Makefile"
    echo "export LD_LIBRARY_PATH for linux-aarch64-*"
    echo "make & make install"
fi

# ==========NOTE==========
# ### prepare
# wget https://raw.githubusercontent.com/adelshokhy112/linux-syscall-support/master/lss/linux_syscall_support.h

# ### linux
# ./configure --prefix=$PWD/linux-64d/install

# ### linux-arm
# export BUILD_GCC_ROOT=/cross-compile/gcc-linaro-7.5.0-arm-linux-gnueabihf/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf
# ./configure --prefix=$PWD/linux-armd/install --host=arm-linux-gnueabihf CC=$BUILD_GCC_ROOT/bin/arm-linux-gnueabihf-gcc CXX=$BUILD_GCC_ROOT/bin/arm-linux-gnueabihf-g++ AR=$BUILD_GCC_ROOT/bin/arm-linux-gnueabihf-gcc-ar RANLIB=$BUILD_GCC_ROOT/bin/arm-linux-gnueabihf-gcc-ranlib --disable-tools

# ### linux-aarch64
# export BUILD_GCC_ROOT=/cross-compile/gcc-linaro-7.4.1-linux-gnu-aarch64/gcc-linaro-7.4.1-aarch64
# ./configure --prefix=$PWD/linux-aarch64d/install --host=arm-linux-gnueabihf CC=$BUILD_GCC_ROOT/bin/aarch64-linux-gnu-gcc CXX=$BUILD_GCC_ROOT/bin/aarch64-linux-gnu-g++ AR=$BUILD_GCC_ROOT/bin/aarch64-linux-gnu-gcc-ar RANLIB=$BUILD_GCC_ROOT/bin/aarch64-linux-gnu-gcc-ranlib --disable-tools

# ### windows
# 1. git clone https://gitee.com/fluolite-dev/breakpad to /path/to/breakpad
# 2. git clone https://gitee.com/fluolite-dev/gyp to /path/to/gyp
# 3. add /path/to/gpy to system's PATH
# 4. delete gtest project(targets:dependencies) in breakpad\src\client\windows\breakpad_client.gyp
# 5. vc-x86.cmd and SET GYP_MSVS_VERSION=2017
# 6. gyp.bat --no-circular-check src\client\windows\breakpad_client.gyp -Dwin_release_RuntimeLibrary=2 -Dwin_debug_RuntimeLibrary=3
# 7. gyp.bat --no-circular-check src\common\windows\common_windows.gyp -Dwin_release_RuntimeLibrary=2 -Dwin_debug_RuntimeLibrary=3
# 8. gyp.bat --no-circular-check src\tools\windows\tools_windows.gyp -Dwin_release_RuntimeLibrary=2 -Dwin_debug_RuntimeLibrary=3

# # RuntimeLibrary
# # 0：/MT
# # 1：/MTd
# # 2：/MD
# # 3：/MDd