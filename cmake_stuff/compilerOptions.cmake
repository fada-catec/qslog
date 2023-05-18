set(EXTRA_C_FLAGS          "")
set(EXTRA_C_FLAGS_RELEASE  "")   # Already contain "-O3 -DNDEBUG"
set(EXTRA_C_FLAGS_DEBUG    "-O0 -DDEBUG -D_DEBUG")

set(EXTRA_EXE_LINKER_FLAGS          "")
set(EXTRA_EXE_LINKER_FLAGS_RELEASE  "")
set(EXTRA_EXE_LINKER_FLAGS_DEBUG    "")

if(${MSVC})

   string(REGEX REPLACE "^  *| * $" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
   string(REGEX REPLACE "^  *| * $" "" CMAKE_CXX_FLAGS_INIT "${CMAKE_CXX_FLAGS_INIT}")

   if(CMAKE_CXX_FLAGS STREQUAL CMAKE_CXX_FLAGS_INIT)

      # Override cmake default exception handling option
      string(REPLACE "/EHsc" "/EHa" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}"
            CACHE STRING "Flags used by the compiler during all build types." FORCE)

   endif()

endif()

if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")

   ## Checking C++11
   execute_process(COMMAND ${CMAKE_CXX_COMPILER} -dumpversion OUTPUT_VARIABLE GCC_VERSION)
   if(NOT (GCC_VERSION VERSION_GREATER 4.7 OR GCC_VERSION VERSION_EQUAL 4.7))
      message(FATAL_ERROR "${PROJECT_NAME} C++11 support requires g++ 4.7 or greater.")
   endif()

   set(EXTRA_C_FLAGS       "${EXTRA_C_FLAGS} -std=c++11")

   ## Makes all your symbols hidden by default.
   ## Not valid for clang because cmake doesn't generate proper export files
   set(EXTRA_C_FLAGS       "${EXTRA_C_FLAGS} -fvisibility=hidden")

   set(EXTRA_C_FLAGS       "${EXTRA_C_FLAGS} -Wall")

   if(${WARNINGS_ANSI_ISO})
      set(EXTRA_C_FLAGS    "${EXTRA_C_FLAGS} -Wcast-align")
      set(EXTRA_C_FLAGS    "${EXTRA_C_FLAGS} -Wpedantic")
      set(EXTRA_C_FLAGS    "${EXTRA_C_FLAGS} -Wextra")
   else()
      set(EXTRA_C_FLAGS    "${EXTRA_C_FLAGS} -Wno-narrowing")
      set(EXTRA_C_FLAGS    "${EXTRA_C_FLAGS} -Wno-delete-non-virtual-dtor")
      set(EXTRA_C_FLAGS    "${EXTRA_C_FLAGS} -Wno-unnamed-type-template-args")
   endif()

   if(${WARNINGS_ARE_ERRORS})
      set(EXTRA_C_FLAGS    "${EXTRA_C_FLAGS} -Werror")
   endif()

   if(${WARNINGS_EFFCPP})
      set(EXTRA_C_FLAGS    "${EXTRA_C_FLAGS} -Weffc++")
   endif()

   if(NOT ${BUILD_SHARED_LIBS})
      set(EXTRA_C_FLAGS    "${EXTRA_C_FLAGS} -fPIC")
   endif()

   if(${ENABLE_PROFILING})
      set(EXTRA_C_FLAGS    "${EXTRA_C_FLAGS} -pg -g")
      # Turn off incompatible options
      foreach(flags CMAKE_CXX_FLAGS CMAKE_C_FLAGS
                    CMAKE_CXX_FLAGS_RELEASE
                    CMAKE_C_FLAGS_RELEASE
                    CMAKE_CXX_FLAGS_DEBUG
                    CMAKE_C_FLAGS_DEBUG
                    EXTRA_C_FLAGS_RELEASE)
         string(REPLACE "-fomit-frame-pointer" "" ${flags} "${${flags}}")
         string(REPLACE "-ffunction-sections" "" ${flags} "${${flags}}")
      endforeach()
   elseif(NOT APPLE AND NOT ANDROID)
      # Remove unreferenced functions: function level linking
      set(EXTRA_C_FLAGS    "${EXTRA_C_FLAGS} -ffunction-sections")
   endif()

elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")

      if(${COMPILE_PARALLEL})
         set(EXTRA_C_FLAGS "${EXTRA_C_FLAGS} /MP")
      endif()

      set(EXTRA_C_FLAGS    "${EXTRA_C_FLAGS} /D _CRT_SECURE_NO_DEPRECATE")
      set(EXTRA_C_FLAGS    "${EXTRA_C_FLAGS} /D _CRT_NONSTDC_NO_DEPRECATE")
      set(EXTRA_C_FLAGS    "${EXTRA_C_FLAGS} /D _SCL_SECURE_NO_WARNINGS")

     # Remove unreferenced functions: function level linking
     set(EXTRA_C_FLAGS     "${EXTRA_C_FLAGS} /Gy")
     if(NOT ${MSVC_VERSION} LESS 1400)
        set(EXTRA_C_FLAGS  "${EXTRA_C_FLAGS} /bigobj")
     endif()

     if(${WARNINGS_ARE_ERRORS})
        set(EXTRA_C_FLAGS  "${EXTRA_C_FLAGS} /WX")
     endif()

endif()

## Add user supplied extra options (optimization, etc...)
set(EXTRA_C_FLAGS                   "${EXTRA_C_FLAGS}"
   CACHE INTERNAL "Extra compiler options")
set(EXTRA_C_FLAGS_RELEASE           "${EXTRA_C_FLAGS_RELEASE}"
   CACHE INTERNAL "Extra compiler options for Release build")
set(EXTRA_C_FLAGS_DEBUG             "${EXTRA_C_FLAGS_DEBUG}"
   CACHE INTERNAL "Extra compiler options for Debug build")
set(EXTRA_EXE_LINKER_FLAGS          "${EXTRA_EXE_LINKER_FLAGS}"
   CACHE INTERNAL "Extra linker flags")
set(EXTRA_EXE_LINKER_FLAGS_RELEASE  "${EXTRA_EXE_LINKER_FLAGS_RELEASE}"
   CACHE INTERNAL "Extra linker flags for Release build")
set(EXTRA_EXE_LINKER_FLAGS_DEBUG    "${EXTRA_EXE_LINKER_FLAGS_DEBUG}"
   CACHE INTERNAL "Extra linker flags for Debug build")

## Combine all "extra" options
set(CMAKE_C_FLAGS                   "${CMAKE_C_FLAGS} ${EXTRA_C_FLAGS}")
set(CMAKE_C_FLAGS_RELEASE           "${CMAKE_C_FLAGS_RELEASE} ${EXTRA_C_FLAGS_RELEASE}")
set(CMAKE_C_FLAGS_DEBUG             "${CMAKE_C_FLAGS_DEBUG} ${EXTRA_C_FLAGS_DEBUG}")

set(CMAKE_CXX_FLAGS                 "${CMAKE_CXX_FLAGS} ${EXTRA_C_FLAGS}")
set(CMAKE_CXX_FLAGS_RELEASE         "${CMAKE_CXX_FLAGS_RELEASE} ${EXTRA_C_FLAGS_RELEASE}")
set(CMAKE_CXX_FLAGS_DEBUG           "${CMAKE_CXX_FLAGS_DEBUG} ${EXTRA_C_FLAGS_DEBUG}")

set(CMAKE_EXE_LINKER_FLAGS          "${CMAKE_EXE_LINKER_FLAGS} ${EXTRA_EXE_LINKER_FLAGS}")
set(CMAKE_EXE_LINKER_FLAGS_RELEASE  "${CMAKE_EXE_LINKER_FLAGS_RELEASE} ${EXTRA_EXE_LINKER_FLAGS_RELEASE}")
set(CMAKE_EXE_LINKER_FLAGS_DEBUG    "${CMAKE_EXE_LINKER_FLAGS_DEBUG} ${EXTRA_EXE_LINKER_FLAGS_DEBUG}")

if(${MSVC})

   # avoid warnings from MSVC about overriding the /W* option
   # we replace /W3 with /W4 only for C++ files,
   # since all the 3rd-party libraries OpenCV uses are in C,
   # and we do not care about their warnings.
   #string(REPLACE "/W3" "/W4" CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS}")
   #string(REPLACE "/W3" "/W4" CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}")
   #string(REPLACE "/W3" "/W4" CMAKE_CXX_FLAGS_DEBUG   "${CMAKE_CXX_FLAGS_DEBUG}")

   # Allow extern "C" functions throw exceptions
   foreach(flags CMAKE_C_FLAGS CMAKE_C_FLAGS_RELEASE CMAKE_C_FLAGS_RELEASE CMAKE_CXX_FLAGS
                 CMAKE_CXX_FLAGS_RELEASE CMAKE_CXX_FLAGS_DEBUG)
      string(REPLACE "/EHsc-" "/EHs" ${flags} "${${flags}}")
      string(REPLACE "/EHsc" "/EHs" ${flags} "${${flags}}")
      string(REPLACE "/Zm1000" "" ${flags} "${${flags}}")
   endforeach()

   if(NOT ${ENABLE_NOISY_WARNINGS})
      # Class 'std::XXX' needs to have dll-interface to be used by clients of YYY
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4251")
   endif()

   if(NOT ${BUILD_SHARED_LIBS} AND BUILD_WITH_STATIC_CRT)
      foreach(flag_var  CMAKE_C_FLAGS CMAKE_C_FLAGS_DEBUG CMAKE_C_FLAGS_RELEASE
                        CMAKE_C_FLAGS_MINSIZEREL CMAKE_C_FLAGS_RELWITHDEBINFO
                        CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
                        CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)
         if(${flag_var} MATCHES "/MD")
            string(REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
         endif()
         if(${flag_var} MATCHES "/MDd")
            string(REGEX REPLACE "/MDd" "/MTd" ${flag_var} "${${flag_var}}")
         endif()
      endforeach(flag_var)

      set(CMAKE_EXE_LINKER_FLAGS          "${CMAKE_EXE_LINKER_FLAGS} /NODEFAULTLIB:atlthunk.lib /NODEFAULTLIB:msvcrt.lib /NODEFAULTLIB:msvcrtd.lib")
      set(CMAKE_EXE_LINKER_FLAGS_DEBUG    "${CMAKE_EXE_LINKER_FLAGS_DEBUG} /NODEFAULTLIB:libcmt.lib")
      set(CMAKE_EXE_LINKER_FLAGS_RELEASE  "${CMAKE_EXE_LINKER_FLAGS_RELEASE} /NODEFAULTLIB:libcmtd.lib")
   else()
      foreach(flag_var  CMAKE_C_FLAGS CMAKE_C_FLAGS_DEBUG CMAKE_C_FLAGS_RELEASE
                        CMAKE_C_FLAGS_MINSIZEREL CMAKE_C_FLAGS_RELWITHDEBINFO
                        CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
                        CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)
         if(${flag_var} MATCHES "/MT")
            string(REGEX REPLACE "/MT" "/MD" ${flag_var} "${${flag_var}}")
         endif()
         if(${flag_var} MATCHES "/MTd")
            string(REGEX REPLACE "/MTd" "/MDd" ${flag_var} "${${flag_var}}")
         endif()
      endforeach(flag_var)
   endif()

   if(NOT ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION} LESS 2.8 AND NOT ${CMAKE_MINOR_VERSION}.${CMAKE_PATCH_VERSION} LESS 8.6)
      include(ProcessorCount)
      ProcessorCount(N)
      if(NOT N EQUAL 0)
         set(CMAKE_C_FLAGS    "${CMAKE_C_FLAGS}   /MP${N} ")
         set(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /MP${N} ")
      endif()
   endif()

   if(NOT BUILD_WITH_DEBUG_INFO AND NOT ${MSVC})
      string(REPLACE "/debug" "" CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG}")
      string(REPLACE "/DEBUG" "" CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG}")
      string(REPLACE "/INCREMENTAL:YES" "/INCREMENTAL:NO" CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG}")
      string(REPLACE "/INCREMENTAL " "/INCREMENTAL:NO " CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG}")

      string(REPLACE "/debug" "" CMAKE_MODULE_LINKER_FLAGS_DEBUG "${CMAKE_MODULE_LINKER_FLAGS_DEBUG}")
      string(REPLACE "/DEBUG" "" CMAKE_MODULE_LINKER_FLAGS_DEBUG "${CMAKE_MODULE_LINKER_FLAGS_DEBUG}")
      string(REPLACE "/INCREMENTAL:YES" "/INCREMENTAL:NO" CMAKE_MODULE_LINKER_FLAGS_DEBUG "${CMAKE_MODULE_LINKER_FLAGS_DEBUG}")
      string(REPLACE "/INCREMENTAL " "/INCREMENTAL:NO " CMAKE_MODULE_LINKER_FLAGS_DEBUG "${CMAKE_MODULE_LINKER_FLAGS_DEBUG}")

      string(REPLACE "/debug" "" CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS_DEBUG}")
      string(REPLACE "/DEBUG" "" CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS_DEBUG}")
      string(REPLACE "/INCREMENTAL:YES" "/INCREMENTAL:NO" CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS_DEBUG}")
      string(REPLACE "/INCREMENTAL " "/INCREMENTAL:NO " CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS_DEBUG}")

      string(REPLACE "/Zi" "" CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}")
      string(REPLACE "/Zi" "" CMAKE_CXX_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}")
   endif()

endif()
