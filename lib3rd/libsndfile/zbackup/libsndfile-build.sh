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

if [ -d $build_tmpdir ] && [ "$build_tmpdir" != "/" ]; then
    rm -rfv $build_tmpdir
fi
mkdir -pv $build_tmpdir

cd $build_tmpdir

# build
source $build_platform_env
build_options="--prefix=$build_tmpdir/install"
if [[ "${build_platform[@]}" =~ "linux-aarch64-rk3308" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3328" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3566" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3568" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3569" ]]; then
    if [[ "${build_platform[@]}" =~ "linux-aarch64-rk3308" ]]; then
        build_options="$build_options --host=aarch64-rockchip-linux-gnu --with-sysroot=$BUILD_SYS_ROOT"
    else
        build_options="$build_options --host=aarch64-buildroot-linux-gnu --with-sysroot=$BUILD_SYS_ROOT"
    fi
elif [[ "${build_platform[@]}" =~ "linux-arm" ]]; then
    build_options="$build_options --host=arm-linux-gnueabihf --with-sysroot=$BUILD_SYS_ROOT"
elif [[ "${build_platform[@]}" =~ "linux-aarch64" ]]; then
    build_options="$build_options --host=aarch64-linux-gnu --with-sysroot=$BUILD_SYS_ROOT"
fi

echo "../configure $build_options"
../configure $build_options

make
make install

# ==========NOTE==========
# configure delete -g for build release

# fix xxx/sysroot/usr/lib/libasound.la
# fix xxx/sysroot/usr/lib/libmp3lame.la