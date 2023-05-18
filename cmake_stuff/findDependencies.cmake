## Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_INSTALL_PREFIX}/lib/cmake)

if(MSVC)
   add_definitions("/D _USE_MATH_DEFINES")
endif()

#######################
## Configuring QsLog ##
#######################

if(${SEPARATE_THREAD_LOG})
   add_definitions(-DQS_LOG_SEPARATE_THREAD)
endif()

add_definitions(-DQSLOG_IS_SHARED_LIBRARY)

#####################
## Configuring Qt5 ##
#####################

if(DEFINED ENV{QTDIR})
   set(CMAKE_PREFIX_PATH   ${CMAKE_PREFIX_PATH} $ENV{QTDIR})
endif()

set(CMAKE_AUTOMOC ON)

find_package(Qt5Core 5.2.1 REQUIRED)

if(${BUILD_SHARED_LIBS})
   add_definitions(-DQT_SHARED)
else()
   add_definitions(-DQT_STATIC)
endif()

if(${CMAKE_BUILD_TYPE} STREQUAL "Release")
   add_definitions(-DQT_NO_DEBUG_OUTPUT)
   add_definitions(-DQT_NO_WARNING_OUTPUT)
endif()
