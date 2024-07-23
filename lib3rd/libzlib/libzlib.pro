BUILD_PACKAGE = libzlib
BUILD_FLAGS = syslib

include(../lib3rd-build.pri)
include(./libzlib.pri)

DISTFILES += \
    ./libzlib-include.pri
