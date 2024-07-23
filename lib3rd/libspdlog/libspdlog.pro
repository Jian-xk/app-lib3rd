BUILD_PACKAGE = libspdlog
BUILD_FLAGS = install

include(../lib3rd-build.pri)
include(./libspdlog.pri)

DISTFILES += \
    ./libspdlog-include.pri
