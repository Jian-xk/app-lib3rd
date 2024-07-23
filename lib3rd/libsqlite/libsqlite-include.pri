!contains(BUILD_FLAGS, syslib) {
    INCLUDEPATH += $${LIB3RD_ROOT}/libsqlite/include
}
linux-* {
    LIBS += -lsqlite3
} else: win32 {
    LIBS += -llibsqlite
}
