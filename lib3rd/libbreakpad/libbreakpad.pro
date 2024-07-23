BUILD_PACKAGE = libbreakpad
BUILD_FLAGS = install

include(../lib3rd-build.pri)
include(./libbreakpad.pri)

DISTFILES += \
    ./libbreakpad-include.pri
