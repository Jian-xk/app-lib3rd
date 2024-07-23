!contains(BUILD_FLAGS, syslib) {
    INCLUDEPATH += $${LIB3RD_ROOT}/libopenssl/include/$${PLATFORM_DIR}
}
linux-* {
    LIBS += -lcrypto -lssl
} else: win32 {
    LIBS += -lcrypto -lssl
}
