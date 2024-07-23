BUILD_PACKAGE = libcurl
BUILD_FLAGS = syslib

include(../lib3rd-build.pri)
include(./libcurl.pri)

DISTFILES += \
    ./libcurl-include.pri
