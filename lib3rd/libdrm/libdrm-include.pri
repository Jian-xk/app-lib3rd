INCLUDEPATH += $$[QT_SYSROOT]/usr/include/libdrm

linux-* {
    LIBS += -ldrm
} else: win32 {
    LIBS += -llibdrm
}
