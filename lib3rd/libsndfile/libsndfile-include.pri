!contains(BUILD_FLAGS, syslib) {
    INCLUDEPATH += $${LIB3RD_ROOT}/libsndfile/include
}
linux-* {
    LIBS += -lsndfile
} else: win32 {
    LIBS += -llibsndfile
}
