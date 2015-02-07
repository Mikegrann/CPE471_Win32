set(PROJECT_NAME Program2B)

cmake_minimum_required(VERSION 2.8)
project(${PROJECT_NAME})

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/external/rpavlik-cmake-modules-1c73e35")
include(CreateLaunchers)

find_package(OpenGL)
find_package(GLEW)

set(GLFW_LIB glfw3)
set(PLATFORM_LIBS glew32 glad)

# Add dependencies (not compiled into the executable)
file(GLOB NON_SRC_FILES *.obj *.glsl *.h)
set_source_files_properties(${NON_SRC_FILES} PROPERTIES HEADER_FILE_ONLY TRUE)

file (GLOB SRC_FILES *.cc *.cpp)

add_executable(${PROJECT_NAME} ${SRC_FILES} ${NON_SRC_FILES})
target_link_libraries(${PROJECT_NAME} ${OPENGL_gl_LIBRARY} ${GLFW_LIB} ${GLEW_LIBRARY} ${PLATFORM_LIBS})

create_default_target_launcher(${PROJECT_NAME} WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/")