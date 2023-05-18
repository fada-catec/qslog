############################
## Configuring Build Type ##
############################

set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "Configs" FORCE)
if(DEFINED CMAKE_BUILD_TYPE)
   set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS ${CMAKE_CONFIGURATION_TYPES})
endif()

if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE "Debug")
endif()

if(NOT ${CMAKE_BUILD_TYPE} STREQUAL "Debug" AND
   NOT ${CMAKE_BUILD_TYPE} STREQUAL "Release")
   message(FATAL_ERROR "Only Release and Debug build types are allowed.")
endif()

#####################
## Project Options ##
#####################

## Force some variables that could be defined in the command line to be written to cache
option(WARNINGS_ARE_ERRORS "Treat warnings as errors"                                  ON)
option(WARNINGS_ANSI_ISO   "Issue all the mandatory diagnostics listed in C standard"  ON)
option(WARNINGS_EFFCPP     "Issue all the warnings listed in the book of Scot Meyers"  OFF)

option(ENABLE_PROFILING    "Enable profiling in Valgrind (Add flags: -g -fno_inline)"  OFF)

option(INSTALL_DOC         "Install documentation in system"                           OFF)
option(DOXY_COVERAGE       "Generate text file with the doxygen coverage"              OFF)
option(USE_MATHJAX         "Generate doc-formulas via mathjax instead of latex"        OFF)
option(USE_DOT             "Diagram generation with graphviz"                          ON)
option(USE_LATEX           "Build latex documentation"                                 OFF)
option(USE_CHM             "Build CHM Windows documentation"                           OFF)

option(BUILD_SHARED_LIBS   "Build shared libraries"                                    ON)

if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
option(COMPILE_PARALLEL    "Enable parallel compilation for MSVC"                      ON)
endif()

option(SEPARATE_THREAD_LOG "Messages are queued and written from a separate thread"    ON)


### Move the generated libraries and executables to common folders
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY     ${PROJECT_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY     ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY     ${PROJECT_BINARY_DIR}/lib)

### Necessary to be able to execute the installed applications
set(CMAKE_INSTALL_RPATH                ${CMAKE_INSTALL_PREFIX}/lib)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH  TRUE)
