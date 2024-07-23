#!/bin/bash

# usage
if [ ! -n "$1" ] || [ ! -n "$2" ] || [ ! -n "$3" ]; then
    echo "Usage xxx-build.sh [platform] [libtype] </path/to/zipfile>"
    exit 1
fi

profile_dir=$PROFILE_DIR
if [ ! -n "$profile_dir" ] ; then
    profile_dir=$PWD
fi

build_platform=$1
build_libtype=$2
build_zipfile=$3
build_platform_env=$profile_dir/toolchain-$build_platform.sh
build_platform_cmake=$profile_dir/toolchain-$build_platform.cmake
build_platform_cmake_env=$profile_dir/toolchain-$build_platform.cmake.sh

if [ ! -f "$build_platform_env" ] || [ ! -f "$build_platform_cmake" ]; then
    echo "build platform unsupported"
    exit 1
fi

if [ ! -n "$build_libtype" ] ; then
    build_libtype='shared'
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

# build
build_options="-DCMAKE_INSTALL_PREFIX=$build_tmpdir/install"
if [ "$build_libtype" = "shared" ]; then
    build_options="$build_options -DSPDLOG_BUILD_SHARED=ON"
else
    build_options="$build_options -DSPDLOG_BUILD_SHARED=OFF"
fi

if [ "$build_type" = "debug" ]; then 
    build_options="$build_options -DCMAKE_BUILD_TYPE=Debug"
else
    build_options="$build_options -DCMAKE_BUILD_TYPE=Release"
fi

build_options="$build_options -DCMAKE_TOOLCHAIN_FILE=$build_platform_cmake"

if [[ "${build_platform[@]}" =~ "linux-aarch64-rk3308" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3328" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3566" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3568" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3569" ]]; then
    source $build_platform_cmake_env

fi

cd $build_tmpdir
echo "cmake .. $build_options"
cmake .. $build_options
make
make install


# ==========NOTE==========
# set_target_properties(spdlog PROPERTIES DEBUG_POSTFIX d)