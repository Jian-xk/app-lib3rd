# cmake cross-compile

set(BUILD_GCC_ROOT "/data/qtteam/work/cross-compile/buildroot-rk3568")
set(BUILD_SYS_ROOT "/data/qtteam/work/cross-compile/buildroot-rk3568/aarch64-buildroot-linux-gnu/sysroot")
set(BUILD_QT5_DIR "/data/qtteam/work/cross-compile/qt-install-5.14.1-linux-aarch64-rk3568-dynamic")

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

# specify the cross compiler
set(CMAKE_C_COMPILER "${BUILD_GCC_ROOT}/bin/aarch64-buildroot-linux-gnu-gcc")
set(CMAKE_CXX_COMPILER "${BUILD_GCC_ROOT}/bin/aarch64-buildroot-linux-gnu-g++")

# where is the target environment
set(CMAKE_FIND_ROOT_PATH "${BUILD_SYS_ROOT}")
set(CMAKE_SYSROOT "${BUILD_SYS_ROOT}")

set(ENV{PKG_CONFIG_PATH} "")
set(ENV{PKG_CONFIG_LIBDIR} ${CMAKE_SYSROOT}/usr/lib/pkgconfig:${CMAKE_SYSROOT}/usr/share/pkgconfig)
set(ENV{PKG_CONFIG_SYSROOT_DIR} ${CMAKE_SYSROOT})

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(ENV{LD_LIBRARY_PATH} "${BUILD_GCC_ROOT}/lib")