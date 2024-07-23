!contains(BUILD_FLAGS, syslib) {
    INCLUDEPATH += $${LIB3RD_ROOT}/libsdl/include/$${PLATFORM_DIR}
}
linux-* {
    LIBS += -lSDL2
} else: win32 {
    LIBS += -lSDL2
}
