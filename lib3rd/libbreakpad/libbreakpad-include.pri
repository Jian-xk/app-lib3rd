!contains(BUILD_FLAGS, syslib) {
    INCLUDEPATH += $${LIB3RD_ROOT}/libbreakpad/include/breakpad
}
linux-* {
    LIBS += -lcrypto -lbreakpad -lbreakpad_client
} else: win32 {
    LIBS += -lcommon -lexception_handler -lcrash_generation_client
}
