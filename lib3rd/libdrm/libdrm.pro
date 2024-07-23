BUILD_PACKAGE = libdrm
BUILD_FLAGS = syslib

include(../lib3rd-build.pri)
include(./libdrm.pri)

DISTFILES += \
    ./libdrm-include.pri
