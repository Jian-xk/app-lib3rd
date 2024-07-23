!contains(BUILD_FLAGS, syslib) {
    INCLUDEPATH += $${LIB3RD_ROOT}/libffmpeg/include/$${PLATFORM_DIR}
}
linux-* {
    LIBS += -lavdevice -lavformat -lavcodec -lavfilter -lswscale -lswresample -lpostproc -lavutil
} else: win32 {
    LIBS += -lavdevice -lavformat -lavcodec -lavfilter -lswscale -lswresample -lpostproc -lavutil
}
