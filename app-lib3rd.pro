TEMPLATE = subdirs

SUBDIRS += \
    aamlogger \
    lib3rd

aamlogger.depends = lib3rd

DISTFILES += \
    ./aimy-lib3rd-include.pri \
    README.md