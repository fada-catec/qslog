include_directories(${PROJECT_BINARY_DIR}/include)
include_directories(${PROJECT_SOURCE_DIR}/include)
include_directories(SYSTEM ${Qt5Core_INCLUDE_DIRS})

file(GLOB_RECURSE INCS  "${PROJECT_SOURCE_DIR}/include/${PROJECT_NAME}/*.h*")
file(GLOB_RECURSE SRCS  "*.c*")
file(GLOB_RECURSE HDRS  "*.h*")

#######################
## Build the library ##
#######################

add_library(${PROJECT_NAME}
   ${SRCS} ${HDRS} ${INCS})

set_target_properties(${PROJECT_NAME} PROPERTIES
   VERSION              ${VERSION}
   SOVERSION            ${SOVERSION}
   CLEAN_DIRECT_OUTPUT  1
   OUTPUT_NAME          "${PROJECT_NAME}")

target_link_libraries(${PROJECT_NAME}
   Qt5::Core)

########################################################
## Mark executables and/or libraries for installation ##
########################################################

install(TARGETS ${PROJECT_NAME}
   RUNTIME  DESTINATION bin   COMPONENT bin
   LIBRARY  DESTINATION lib   COMPONENT libraries
   ARCHIVE  DESTINATION lib   COMPONENT libraries)

########################
## Copy include files ##
########################

install(DIRECTORY "${PROJECT_SOURCE_DIR}/include/${PROJECT_NAME}/"
   DESTINATION    include/${PROJECT_NAME}
   COMPONENT      dev
   FILES_MATCHING PATTERN "*.h*")
