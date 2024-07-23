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

LIB3RD_ROOT = $$PWD/../aimy-lib3rd/lib3rd
LIB3RD_DEST = $$PWD/../build/$${PLATFORM_DIR_OUT}/aimy-lib3rd

LIBS += -L$${LIB3RD_DEST}
