set(CPACK_PACKAGE_NAME                 ${PROJECT_NAME})
set(CPACK_PACKAGE_VENDOR               "FADA-CATEC")
set(CPACK_PACKAGE_CONTACT              "Francisco Cuesta Rodríguez <fcuesta@catec.aero>")
set(CPACK_PACKAGE_MAINTAINER           ${CPACK_PACKAGE_CONTACT})
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY  "QsLog Library")

set(CPACK_PACKAGE_VERSION              ${VERSION})
set(CPACK_PACKAGE_VERSION_MAJOR        ${VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR        ${VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH        ${VERSION_PATCH})

if(${UNIX})

   set(CPACK_GENERATOR           "DEB")
   set(CPACK_SET_DESTDIR         ON)

   set(CPACK_PACKAGE_FILE_NAME   "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-${CMAKE_SYSTEM_NAME}_${CMAKE_SYSTEM_PROCESSOR}")

elseif(${WIN32})

   include(InstallRequiredSystemLibraries)

   set(CPACK_GENERATOR                             "NSIS")

   set(CPACK_PACKAGE_INSTALL_DIRECTORY             "${CPACK_PACKAGE_NAME}")

   set(CPACK_COMPONENT_APPLICATIONS_DISPLAY_NAME   "Applications")
   set(CPACK_COMPONENT_LIBRARIES_DISPLAY_NAME      "Libraries")
   set(CPACK_COMPONENT_HEADERS_DISPLAY_NAME        "C/C++ Headers")
   set(CPACK_COMPONENT_PLUGINS_DISPLAY_NAME        "Plugins")

   set(CPACK_COMPONENT_APPLICATIONS_DESCRIPTION
     "Applications that you will use in the ${CPACK_PACKAGE_NAME} project")
   set(CPACK_COMPONENT_LIBRARIES_DESCRIPTION
     "Libraries used to build programs which use ${CPACK_PACKAGE_NAME}")
   set(CPACK_COMPONENT_HEADERS_DESCRIPTION
     "C/C++ header files for use with ${CPACK_PACKAGE_NAME}")
   set(CPACK_COMPONENT_PLUGINS_DESCRIPTION
     "Plugins that you will use in the ${CPACK_PACKAGE_NAME} project")

   set(CPACK_COMPONENT_APPLICATIONS_GROUP          "Runtime")
   set(CPACK_COMPONENT_PLUGINS_GROUP               "Runtime")
   set(CPACK_COMPONENT_LIBRARIES_GROUP             "Development")
   set(CPACK_COMPONENT_HEADERS_GROUP               "Development")

   set(CPACK_COMPONENT_GROUP_RUNTIME_DESCRIPTION
      "Applications and plugins that you will use in the ${PROJECT_NAME} project")
   set(CPACK_COMPONENT_GROUP_DEVELOPMENT_DESCRIPTION
      "All of the tools you'll ever need to develop software")

   set(CPACK_NSIS_PACKAGE_NAME                     "${CPACK_PACKAGE_NAME} ${CPACK_PACKAGE_VERSION}")
   set(CPACK_NSIS_DISPLAY_NAME                     "${CPACK_PACKAGE_DESCRIPTION_SUMMARY}")
   set(CPACK_NSIS_CONTACT                          "${CPACK_PACKAGE_CONTACT}")
   set(CPACK_NSIS_MODIFY_PATH                      ON)
   set(CPACK_NSIS_COMPRESSOR                       "/SOLID lzma")

endif()

include(CPack)
