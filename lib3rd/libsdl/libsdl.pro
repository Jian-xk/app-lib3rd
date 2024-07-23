BUILD_PACKAGE = libsdl
BUILD_FLAGS = install

include(../lib3rd-build.pri)
include(./libsdl.pri)

DISTFILES += \
    ./libsdl-include.pri
