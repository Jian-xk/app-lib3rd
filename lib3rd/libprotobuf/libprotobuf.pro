BUILD_PACKAGE = libprotobuf
BUILD_FLAGS = install

include(../lib3rd-build.pri)
include(./libprotobuf.pri)

DISTFILES += \
    ./libprotobuf-include.pri
