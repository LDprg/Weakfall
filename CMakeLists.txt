cmake_minimum_required(VERSION 3.23)
project(Weakfall VERSION 1.0)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED true)

find_package(SFML COMPONENTS window graphics system)

file(GLOB SRC "src/*.cpp" "src/*.hpp")

add_executable(Weakfall ${SRC})

target_link_libraries(Weakfall sfml-audio sfml-graphics sfml-network sfml-system sfml-window)


add_custom_command(TARGET Weakfall PRE_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_SOURCE_DIR}/blender/world/out $<TARGET_FILE_DIR:Weakfall>/assets/img)