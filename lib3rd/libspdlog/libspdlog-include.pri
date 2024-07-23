!contains(BUILD_FLAGS, syslib) {
    INCLUDEPATH += $${LIB3RD_ROOT}/libspdlog/include
}
linux-* {
    LIBS += -lspdlog
} else: win32 {
    LIBS += -llibspdlog
}
