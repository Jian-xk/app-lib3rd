if (${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    # Windows 相关的配置和操作
elseif (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
    # Linux 相关的配置和操作
elseif (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    # macOS 相关的配置和操作
else
    # 处理其他平台或报错
endif()

# for output
set(PLATFORM_DIR_OUT ${PLATFORM_DIR})
if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(PLATFORM_DIR_OUT ${PLATFORM_DIR_OUT}d)
endif()

set(LIB3RD_ROOT ${PROJECT_SOURCE_DIR}/../app-lib3rd/lib3rd)
set(LIB3RD_DEST ${PROJECT_SOURCE_DIR}/../build/${PLATFORM_DIR_OUT}/app-lib3rd)

target_link_directories(${PROJECT_NAME} PRIVATE ${LIB3RD_DEST})