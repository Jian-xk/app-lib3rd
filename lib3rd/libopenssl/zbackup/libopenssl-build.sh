#!/bin/bash

# usage
if [ ! -n "$1" ] || [ ! -n "$2" ]; then
    echo "Usage xxx-build.sh [platform] </path/to/zipfile>"
    exit 1
fi

profile_dir=$PROFILE_DIR
if [ ! -n "$profile_dir" ] ; then
    profile_dir=/data/qtteam/work/app-lib3rd/profile
fi

build_platform=$1
build_zipfile=$2
length=${#build_platform}

if [ "${build_platform: -1}" = "d" ]; then
    build_type='debug'
    build_platform=${build_platform:0:length-1}
else
    build_type='release'
fi
build_platform_env=$profile_dir/toolchain-$build_platform.sh
build_platform_cmake=$profile_dir/toolchain-$build_platform.cmake
if [ ! -f "$build_platform_env" ] || [ ! -f "$build_platform_cmake" ]; then
    echo "build platform unsupported"
    exit 1
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

build

cd $build_tmpdir

# build
source $build_platform_env
build_options="--prefix=$build_tmpdir/install no-asm --shared"
if [[ "${build_platform[@]}" =~ "linux-aarch64-rk3308" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3328" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3566" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3568" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3569" ]]; then
    if [[ "${build_platform[@]}" =~ "linux-aarch64-rk3308" ]]; then
        build_options="$build_options --cross-compile-prefix=aarch64-rockchip-linux-gnu-"
    else
        build_options="$build_options --cross-compile-prefix=aarch64-buildroot-linux-gnu-"
    fi
elif [[ "${build_platform[@]}" =~ "linux-arm" ]]; then
    build_options="$build_options --cross-compile-prefix=arm-linux-gnueabihf-"
elif [[ "${build_platform[@]}" =~ "linux-aarch64" ]]; then
    build_options="$build_options --cross-compile-prefix=aarch64-linux-gnu-"
fi

echo "../config $build_options"
../config $build_options
make
make install


# ==========NOTE==========
# ./Configurations/10-main.conf（“linux-x86_64”）
# delete -m64 for all
# 