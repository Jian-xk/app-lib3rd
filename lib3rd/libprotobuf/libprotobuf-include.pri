!contains(BUILD_FLAGS, syslib) {
    INCLUDEPATH += $${LIB3RD_ROOT}/libprotobuf/include/$${PLATFORM_DIR}
}
linux-* {
    LIBS += -lprotobuf
} else: win32 {
    LIBS += -llibprotobuf
}
