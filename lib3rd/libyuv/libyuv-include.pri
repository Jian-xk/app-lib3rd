!contains(BUILD_FLAGS, syslib) {
    INCLUDEPATH += $${LIB3RD_ROOT}/libyuv/include
}
linux-* {
    LIBS += -lyuv
} else: win32 {
    LIBS += -llibyuv
}
