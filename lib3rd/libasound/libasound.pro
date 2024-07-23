BUILD_PACKAGE = libasound
BUILD_FLAGS = syslib

include(../lib3rd-build.pri)
include(./libasound.pri)

DISTFILES += \
    ./libasound-include.pri

