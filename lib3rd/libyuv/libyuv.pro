BUILD_PACKAGE = libyuv
BUILD_FLAGS = syslib

include(../lib3rd-build.pri)
include(./libyuv.pri)

DISTFILES += \
    ./libyuv-include.pri
