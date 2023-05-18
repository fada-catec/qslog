message(STATUS)
message(STATUS "------------ General configuration for - ${PROJECT_NAME} - ${VERSION} ------------")
message(STATUS)
message(STATUS "Generator:    ${CMAKE_GENERATOR}")
message(STATUS "Compiler:     ${CMAKE_CXX_COMPILER_ID}")
if(${CMAKE_BUILD_TYPE} STREQUAL "Release")
   message(STATUS "C flags (Release):          ${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_RELEASE}")
   message(STATUS "C++ flags (Release):        ${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_RELEASE}")
   if(${WIN32})
      message(STATUS "C++ linker flags (Release): ${CMAKE_SHARED_LINKER_FLAGS} ${CMAKE_SHARED_LINKER_FLAGS_RELEASE}")
   endif()
else()
   message(STATUS "C flags (Debug):            ${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_DEBUG}")
   message(STATUS "C++ flags (Debug):          ${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_DEBUG}")
   if(${WIN32})
      message(STATUS "C++ linker flags (Debug):   ${CMAKE_SHARED_LINKER_FLAGS} ${CMAKE_SHARED_LINKER_FLAGS_DEBUG}")
   endif()
endif()
message(STATUS)
message(STATUS "------------------------------------------------------------------")
message(STATUS)
message(STATUS "CMAKE_BUILD_TYPE       = ${CMAKE_BUILD_TYPE}")
message(STATUS "CMAKE_SYSTEM_NAME      = ${CMAKE_SYSTEM_NAME}")
message(STATUS "CMAKE_SYSTEM_PROCESSOR = ${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS "CMAKE_INSTALL_PREFIX   = ${CMAKE_INSTALL_PREFIX}")
message(STATUS "CMAKE_MODULE_PATH      = ${CMAKE_MODULE_PATH}")
message(STATUS "CMAKE_PREFIX_PATH      = ${CMAKE_PREFIX_PATH}")
message(STATUS)
message(STATUS "WARNINGS_ANSI_ISO      = ${WARNINGS_ANSI_ISO}")
message(STATUS "WARNINGS_ARE_ERRORS    = ${WARNINGS_ARE_ERRORS}")
message(STATUS "WARNINGS_EFFCPP        = ${WARNINGS_EFFCPP}")
message(STATUS)
message(STATUS "ENABLE_PROFILING       = ${ENABLE_PROFILING}")
message(STATUS)
if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
   message(STATUS "COMPILE_PARALLEL       = ${COMPILE_PARALLEL}")
   message(STATUS)
endif()
message(STATUS "BUILD_SHARED_LIBS      = ${BUILD_SHARED_LIBS}")
message(STATUS "BUILD_TESTS            = ${BUILD_TESTS}")
message(STATUS)
message(STATUS "SEPARATE_THREAD_LOG    = ${SEPARATE_THREAD_LOG}")
message(STATUS)
message(STATUS "-------------------------- Dependencies --------------------------")
message(STATUS)
if(${WIN32})
   message(STATUS "WINLIBS_ROOT           = $ENV{WINLIBS_ROOT}")
endif()
message(STATUS "QTDIR                  = $ENV{QTDIR}")
message(STATUS "Qt5Core                = ${Qt5Core_VERSION} - ${Qt5Core_LIBRARIES}")
message(STATUS)
message(STATUS "-------------------------- Documentation -------------------------")
message(STATUS)
message(STATUS "INSTALL_DOC            = ${INSTALL_DOC}")
message(STATUS "DOXY_COVERAGE          = ${DOXY_COVERAGE}")
message(STATUS "USE_LATEX              = ${USE_LATEX}")
message(STATUS "USE_DOT                = ${USE_DOT}")
message(STATUS "USE_CHM                = ${USE_CHM}")
message(STATUS "USE_MATHJAX            = ${USE_MATHJAX}")
message(STATUS)
message(STATUS "Change a value with: cmake -D<Variable>=<Value>")
message(STATUS)
