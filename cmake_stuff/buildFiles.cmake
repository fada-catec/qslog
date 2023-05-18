# ----------------------------------------------------------------------------
#   Uninstall target, for "make uninstall"
# ----------------------------------------------------------------------------

configure_file("${PROJECT_SOURCE_DIR}/cmake_stuff/cmake_uninstall.cmake.in"
   "${PROJECT_BINARY_DIR}/cmake_uninstall.cmake" IMMEDIATE @ONLY)

add_custom_target(uninstall "${CMAKE_COMMAND}"
   -P "${PROJECT_BINARY_DIR}/cmake_uninstall.cmake")

# ----------------------------------------------------------------------------
#   Create config.h file
# ----------------------------------------------------------------------------

configure_file("${PROJECT_SOURCE_DIR}/cmake_stuff/config.h.in"
   "${PROJECT_BINARY_DIR}/include/${PROJECT_NAME}/config.h" @ONLY)

install(FILES "${PROJECT_BINARY_DIR}/include/${PROJECT_NAME}/config.h"
   DESTINATION include/${PROJECT_NAME} COMPONENT dev)

# ----------------------------------------------------------------------------
#   Create Find${PROJECT_NAME}.cmake file
# ----------------------------------------------------------------------------

## For the install tree
SET(CMAKE_INC_DIRS_CONFIGCMAKE   "${CMAKE_INSTALL_PREFIX}/include")
SET(CMAKE_LIB_DIRS_CONFIGCMAKE   "${CMAKE_INSTALL_PREFIX}/lib")
configure_file("${PROJECT_SOURCE_DIR}/cmake_stuff/config.cmake.in"
   "${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/Find${PROJECT_NAME}.cmake" @ONLY)

install(FILES "${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/Find${PROJECT_NAME}.cmake"
   DESTINATION lib/cmake COMPONENT dev)
