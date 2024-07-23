#!/bin/bash

# usage
if [ ! -n "$1" ] || [ ! -n "$2" ]; then
    echo "Usage xxx-build.sh [platform] </path/to/zipfile>"
    exit 1
fi

# build 
# 1. 检查主机工具pkg-config
# 2. 检查aimy-lib3rd/lib3rd/libsdl/bin/sdl2-config
# 3. 拷贝编译好的sdl2文件（include) 到交叉编译的sysroot/usr/include 
# 4. 拷贝编译好的sdl2文件（libs) 到交叉编译的sysroot/usr/lib 
# 5. 拷贝编译好的sdl2文件（sdl2.pc) 到交叉编译的sysroot/usr/lib/pkgconfig 
# 6. 修复sysroot/usr/lib/pkgconfig/sdl2.pc，修改内容为(“prefix=/usr”)
# 7. 修复sysroot/usr/lib/pkgconfig/libdrm.pc，增加内容为("-I${includedir}/drm")

echo "Make ture sdl2 is builded and install to sysroot"
echo "call aimy-cicd/cross-compile/sysroot-install.sh"

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

# build
source $build_platform_env
build_options="--prefix=$build_tmpdir/install \
                --pkg-config=$(which pkg-config) \
                --enable-gpl \
                --enable-nonfree \
                --enable-postproc \
                --enable-shared \
                --disable-static \
                --disable-programs \
                --disable-doc \
                --disable-ffmpeg \
                --disable-ffplay \
                --disable-ffprobe \
                --enable-openssl \
                --enable-protocol=tls \
                --enable-protocol=https \
                --enable-sdl"

if [ "$build_type" = "debug" ]; then
    build_options="$build_options --disable-asm --enable-debug=3 --disable-optimizations --disable-stripping"
else
    if [[ "${build_platform[@]}" =~ "linux-arm" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64" ]]; then
        build_options="$build_options --disable-debug --enable-asm"
    else
        build_options="$build_options --disable-debug --enable-x86asm"
    fi
fi

if [[ "${build_platform[@]}" =~ "linux-aarch64-rk3308" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3328" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3566" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3568" ]] || [[ "${build_platform[@]}" =~ "linux-aarch64-rk3569" ]]; then
    build_options="$build_options --enable-cross-compile --enable-libdrm --sysroot=$BUILD_SYS_ROOT --target-os=linux --arch=aarch64"
    if [[ "${build_platform[@]}" =~ "linux-aarch64-rk3308" ]]; then
        build_options="$build_options --cross-prefix=aarch64-rockchip-linux-gnu-"
    else
        build_options="$build_options --cross-prefix=aarch64-buildroot-linux-gnu-"
    fi
elif [[ "${build_platform[@]}" =~ "linux-arm" ]]; then
    build_options="$build_options --enable-cross-compile --enable-libdrm --cross-prefix=arm-linux-gnueabihf- --sysroot=$BUILD_SYS_ROOT --target-os=linux --arch=arm"
elif [[ "${build_platform[@]}" =~ "linux-aarch64" ]]; then
    build_options="$build_options --enable-cross-compile --enable-libdrm --cross-prefix=aarch64-linux-gnu- --sysroot=$BUILD_SYS_ROOT --target-os=linux --arch=aarch64"
fi

cd $build_tmpdir

echo "../configure $build_options"
../configure $build_options
make
make install

# ==========NOTE==========
# build 
# 1. 检查主机工具pkg-config
# 2. 检查主机工具sdl2-config
# 3. 拷贝编译好的sdl2文件（include) 到交叉编译的sysroot/usr/include 
# 4. 拷贝编译好的sdl2文件（libs) 到交叉编译的sysroot/usr/lib 
# 5. 拷贝编译好的sdl2文件（sdl2.pc) 到交叉编译的sysroot/usr/lib/pkgconfig 
# 6. 修复sysroot/usr/lib/pkgconfig/sdl2.pc，修改内容为(“prefix=/usr”)
# 7. 修复sysroot/usr/lib/pkgconfig/libdrm.pc，增加内容为("-I${includedir}/drm")

# --enable-gpl
# --disable-programs 
# --disable-doc

# debug
# --enable-debug=3
# --disable-optimizations
# --disable-stripping //output file size
# --disable-asm

# release
# --disable-debug

# linux-x64
# sudo apt install yasm

# cross-complie
# --enable-cross-compile
# --cross-prefix=$BUILD_GCC_ROOT/bin/aarch64-linux-gnu-
# --sysroot=$BUILD_SYS_ROOT
# --target-os=linux
# --arch=x86/aarch64
# --toolchain=msvc

# lib-x264
# --enable-libx264
# --extra-cflags="-I/c/build/build-x264-debug/include/"
# --extra-cxxflags="-I/c/build/build-x264-debug/include/"
# --extra-ldflags="-L/c/build/build-x264-debug/lib/"
