if (BUILD_FLAGS == syslib)
    target_include_directories(${LIB3RD_ROOT}/libbreakpad/include/breakpad)
endif()

if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
    add_library(libbreakpad libbreakpad_client)
else()

endif()

