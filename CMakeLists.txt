project(QsLog)
cmake_minimum_required(VERSION 3.5.1)

include(cmake_stuff/versions.cmake           REQUIRED)
include(cmake_stuff/options.cmake            REQUIRED)
include(cmake_stuff/findDependencies.cmake   REQUIRED)
include(cmake_stuff/compilerOptions.cmake    REQUIRED)
include(cmake_stuff/generateDoc.cmake        REQUIRED)

add_subdirectory(src)

include(cmake_stuff/buildFiles.cmake         REQUIRED)
include(cmake_stuff/packageGenerator.cmake   REQUIRED)
include(cmake_stuff/printInfo.cmake          REQUIRED)
