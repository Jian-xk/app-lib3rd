# cmake cross-compile

set(BUILD_GCC_ROOT "/data/qtteam/work/cross-compile/gcc-linaro-7.5.0-arm-linux-gnueabihf/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf")
set(BUILD_SYS_ROOT "/data/qtteam/work/cross-compile/sysroot-rk3288")
set(BUILD_QT5_DIR "/data/qtteam/work/cross-compile/qt-install-5.14.1-linux-arm-rk3288-dynamic")

set(ENV{PKG_CONFIG_SYSROOT_DIR} ${BUILD_SYS_ROOT})
set(ENV{PKG_CONFIG_PATH} "")
set(ENV{PKG_CONFIG_LIBDIR} ${BUILD_SYS_ROOT}/usr/lib/pkgconfig:${BUILD_SYS_ROOT}/usr/share/pkgconfig)

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_C_COMPILER "${BUILD_GCC_ROOT}/bin/arm-linux-gnueabihf-gcc")
set(CMAKE_CXX_COMPILER "${BUILD_GCC_ROOT}/bin/arm-linux-gnueabihf-g++")

set(CMAKE_SYSROOT "${BUILD_SYS_ROOT}")
set(CMAKE_FIND_ROOT_PATH "${BUILD_SYS_ROOT}")

SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(ENV{LD_LIBRARY_PATH} "${BUILD_GCC_ROOT}/lib")