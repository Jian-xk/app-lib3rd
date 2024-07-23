!contains(BUILD_FLAGS, syslib) {
    INCLUDEPATH += $${LIB3RD_ROOT}/librkmpp/include
}
linux-* {
    LIBS += -lrockchip_mpp
} else: win32 {
    LIBS += -llibrockchip_mpp
}
