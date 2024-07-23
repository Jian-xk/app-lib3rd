!contains(BUILD_FLAGS, syslib) {
    INCLUDEPATH += $${LIB3RD_ROOT}/libzlib/include
}
linux-* {
    LIBS += -lz
} else: win32 {
    LIBS += -lzlib
}
