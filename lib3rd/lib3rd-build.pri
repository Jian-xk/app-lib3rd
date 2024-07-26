# for define
linux-arm-gnueabi-g++ {
    PLATFORM = linux-arm-rk3288
} else: linux-aarch64-gnu-g++ {
    PLATFORM = linux-aarch64-rk3399
} else: linux-aarch64-rk3308 {
    PLATFORM = linux-aarch64-rk3308
} else: linux-aarch64-rk3328 {
    PLATFORM = linux-aarch64-rk3328
} else: linux-aarch64-rk3566 {
    PLATFORM = linux-aarch64-rk3566
} else: linux-aarch64-rk3568 {
    PLATFORM = linux-aarch64-rk3568
} else: linux-aarch64-rk3569 {
    PLATFORM = linux-aarch64-rk3569
} else: linux-g++ {
    PLATFORM = linux-x64
} else: win32 {
    PLATFORM = win32
}
# for compatibility
PLATFORM_DIR = $${PLATFORM}
linux-arm-gnueabi-g++ {
    PLATFORM_DIR = linux-arm
} else: linux-aarch64-gnu-g++ {
    PLATFORM_DIR = linux-aarch64
}
# for output
PLATFORM_DIR_OUT = $${PLATFORM_DIR}
CONFIG(debug, debug|release) {
    PLATFORM_DIR_OUT = $${PLATFORM_DIR_OUT}d
}

!defined(BUILD_PROJECT, var) {
    BUILD_PROJECT = $${BUILD_PACKAGE}
}
BUILD_ROOT = $$PWD/../../build
BUILD_DIR = $${BUILD_ROOT}/$${PLATFORM_DIR_OUT}/app-lib3rd

# for build
contains(BUILD_FLAGS, build) {
    TEMPLATE = lib
} else {
    TEMPLATE = aux
}

QT -= gui
CONFIG += c++11
CONFIG += staticlib
CONFIG += resources_big
DEFINES += QT_DEPRECATED_WARNINGS

win32 {
    DEFINES -= UNICODE _UNICODE
    QMAKE_CFLAGS += /utf-8
    QMAKE_CXXFLAGS += /utf-8
}
unix {
    QMAKE_CFLAGS += -Werror=return-type
    QMAKE_CXXFLAGS += -fpermissive -Werror=return-type
}

DESTDIR = $$BUILD_DIR
win32 {
    TARGET = $${BUILD_PACKAGE}
} else {
    TARGET = $$str_member($${BUILD_PACKAGE}, 3, -1)
}

# for install
contains(BUILD_FLAGS, install) {
    cmd_mkdir.target = cmd_mkdir
    cmd_mkdir.commands = -$(MKDIR) $$system_path($${BUILD_DIR})
    win32 {
        COPY_OPT =
    } else {
        COPY_OPT = -r
    }
    COPY_LIB = $$system_path($${PWD}/$${BUILD_PROJECT}/lib/$${PLATFORM_DIR}/*)
    cmd_cplib.target = cmd_cplib
    cmd_cplib.commands = -$(COPY) $$COPY_OPT $$COPY_LIB $$system_path($${BUILD_DIR})
    cmd_cplib.depends = cmd_mkdir

    QMAKE_EXTRA_TARGETS += cmd_mkdir cmd_cplib
    PRE_TARGETDEPS += cmd_cplib
}

