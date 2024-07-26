cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
project(app-lib3rd)

#set(CMAKE_INCLUDE_CURRENT_DIR ON)
#set(CMAKE_AUTOUIC ON)
#set(CMAKE_AUTOMOC ON)
#set(CMAKE_AUTORCC ON)
#set(CMAKE_CXX_STANDARD 17)
#set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_subdirectory(lib3rd)
#set(SUBDIRS lib3rd)
#set(DISTFILES "README.md")

add_custom_target(otherfile
  # excluded from all: ALL
  SOURCES README.md
)
