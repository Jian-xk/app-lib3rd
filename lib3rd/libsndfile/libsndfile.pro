BUILD_PACKAGE = libsndfile
BUILD_FLAGS = install

include(../lib3rd-build.pri)
include(./libsndfile.pri)

DISTFILES += \
    ./libsndfile-include.pri
