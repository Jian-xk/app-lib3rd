!contains(BUILD_FLAGS, syslib) {
    INCLUDEPATH += $${LIB3RD_ROOT}/libcurl/include/$${PLATFORM_DIR}
}
linux-* {
    LIBS += -lcurl
} else: win32 {
    LIBS += -llibcurl
}
