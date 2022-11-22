cmake_minimum_required(VERSION 3.20)

include(cmake/prelude.cmake)

project(
	cuddly-rotary-phone
	VERSION 0.1.0
    DESCRIPTION "Demonstration of a cmake bug"
	HOMEPAGE_URL "https://github.com/lakinwecker/cuddly-rotary-phone"
	LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

#-------------------------------------------------------------------------------
# include directories from git submodules
#-------------------------------------------------------------------------------
include_directories(SYSTEM thirdparty/vivid/dependencies/glm)
include_directories(SYSTEM thirdparty/vivid/include)

#-------------------------------------------------------------------------------
# New Style conan dependencies
find_package(nlohmann_json REQUIRED)

set(LIBRARIES nlohmann_json::nlohmann_json)

# vivid library
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
	set(VIVID_COMPILE_OPTIONS ${VIVID_COMPILE_OPTIONS} -Wno-everything)
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
	set(VIVID_COMPILE_OPTIONS ${VIVID_COMPILE_OPTIONS} -w) # Turn off all warnings for vivid
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
	set(VIVID_COMPILE_OPTIONS ${VIVID_COMPILE_OPTIONS} /W0) # Turn off all warnings for vivid
endif()
file(GLOB VIVID_SOURCES thirdparty/vivid/src/*)
add_library(vivid ${VIVID_SOURCES})
target_compile_features(vivid PUBLIC cxx_std_17)
target_include_directories(vivid PRIVATE ${INCLUDES})
target_compile_options(vivid PRIVATE ${VIVID_COMPILE_OPTIONS})
target_link_libraries(vivid nlohmann_json::nlohmann_json) # Allegedly this will add in the appropriate include directories, no?

set(LIBRARIES ${LIBRARIES} vivid)


file(GLOB SOURCES src/main.cpp)
set(INCLUDES ${INCLUDES} src)

add_executable(cuddly-rotary-phone ${SOURCES})
target_include_directories(
	cuddly-rotary-phone ${warning_guard}
	PUBLIC
	${INCLUDES}
	"$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/src>"
)
target_link_libraries(cuddly-rotary-phone PRIVATE ${LIBRARIES})
target_compile_features(cuddly-rotary-phone PUBLIC cxx_std_17)
target_compile_definitions(cuddly-rotary-phone PRIVATE ${DEFINITIONS})
target_compile_options(cuddly-rotary-phone PRIVATE ${DGGS_CMAKE_CXX_FLAGS})
set(LIBRARIES ${LIBRARIES} cuddly-rotary-phone)
