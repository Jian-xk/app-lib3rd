set(BUILD_PACKAGE libbreakpad)
set(BUILD_FLAGS install)

# set(MODULE ${BUILD_PACKAGE})
include(../lib3rd-build.cmake)
include(libbreakpad.cmake)

target_sources(libbreakpad-include.cmake)
file(GLOB libbreakpad-include.cmake)
