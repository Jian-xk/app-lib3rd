BUILD_PACKAGE = libffmpeg
BUILD_FLAGS = install

include(../lib3rd-build.pri)
include(./libffmpeg.pri)

DISTFILES += \
    ./libffmpeg-include.pri
