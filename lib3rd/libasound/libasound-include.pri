!contains(BUILD_FLAGS, syslib) {
    INCLUDEPATH += $${LIB3RD_ROOT}/libasound/include
}
linux-* {
    LIBS += -lasound
} else: win32 {
    LIBS += -lasound
}
