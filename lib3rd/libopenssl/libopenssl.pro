BUILD_PACKAGE = libopenssl

linux-arm-gnueabi-g++ {
    BUILD_FLAGS = syslib
} else: linux-aarch64-gnu-g++ {
    BUILD_FLAGS = syslib
} else {
    BUILD_FLAGS = syslib
}

include(../lib3rd-build.pri)
include(./libopenssl.pri)

DISTFILES += \
    ./libopenssl-include.pri

