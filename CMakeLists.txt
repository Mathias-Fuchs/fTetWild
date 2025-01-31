
### was ich mache, um das hier zu builden:
### mpir als win64 dll builden (mit der gc OPtion im Namen)
### als library publizieren
### mpir.h statt gmp.h benutzen
### mpir.lib linken
### überall mit runtime multithreaded dll -> eintragen in den Project-Settings.
### shared ist hier eingetragen bei der Library
## download eigen 3.4.0 and place it in the libigl/external folder

## set the following variables in the cmake-gui:


set(CMAKE_BUILD_TYPE RelWithDebInfo)
set(LIBIGL_EIGEN_VERSION 3.4.0)
set(LIBIGL_SKIP_DOWNLOAD ON)
set(BUILD_TESTING OFF)
            ## we want to build a shared library
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
            ## we want to submit the solution file to source control for several (good) reasons.
            ## and we don't want cmake to fight with us about it.
set(CMAKE_SUPPRESS_REGENERATION true)
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDLL")
set(CMAKE_SKIP_INSTALL_ALL_DEPENDENCY true)            


################################################################################
cmake_minimum_required(VERSION 3.8)
project(FloatTetwild)
################################################################################

# Detects whether this is a top-level project
get_directory_property(HAS_PARENT PARENT_DIRECTORY)
if(HAS_PARENT)
	set(FLOAT_TETWILD_TOPLEVEL_PROJECT OFF)
else()
	set(FLOAT_TETWILD_TOPLEVEL_PROJECT ON)
endif()

if(INPUT_THIRD_PARTY_DIR)
	set(FLOAT_TETWILD_EXTERNAL ${CMAKE_CURRENT_SOURCE_DIR}/${INPUT_THIRD_PARTY_DIR}/)
else()
	set(FLOAT_TETWILD_EXTERNAL ${CMAKE_CURRENT_SOURCE_DIR}/3rdparty/)
endif()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# Color output
include(UseColors)

# Prepend function
include(PrependCurrentPath)

# FloatTetwild utils
include(FloatTetwildUtils)

# Extra warnings
include(Warnings)

# Sort projects inside the solution
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Generate position independent code by default
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

################################################################################

# FloatTetwild options
option(FLOAT_TETWILD_ENABLE_TBB         "Enable TBB"                    OFF)
option(FLOAT_TETWILD_USE_FLOAT          "Use floats instead of double"  OFF)
option(FLOAT_TETWILD_WITH_SANITIZERS    "Use sanitizers"                OFF)
option(FLOAT_TETWILD_WITH_EXACT_ENVELOPE    "Use exact envelope"        OFF)

# Sanitizer options
option(SANITIZE_ADDRESS   "Sanitize Address"       OFF)
option(SANITIZE_MEMORY    "Sanitize Memory"        OFF)
option(SANITIZE_THREAD    "Sanitize Thread"        OFF)
option(SANITIZE_UNDEFINED "Sanitize Undefined"     OFF)

# Options for libigl modules
option(LIBIGL_USE_STATIC_LIBRARY     "Use libigl as static library" OFF)
option(LIBIGL_WITH_COMISO            "Use CoMiso"                   OFF)
option(LIBIGL_WITH_EMBREE            "Use Embree"                   OFF)
option(LIBIGL_WITH_OPENGL            "Use OpenGL"                   OFF)
option(LIBIGL_WITH_OPENGL_GLFW       "Use GLFW"                     OFF)
option(LIBIGL_WITH_OPENGL_GLFW_IMGUI "Use ImGui"                    OFF)
option(LIBIGL_WITH_PNG               "Use PNG"                      OFF)
option(LIBIGL_WITH_TETGEN            "Use Tetgen"                   OFF)
option(LIBIGL_WITH_TRIANGLE          "Use Triangle"                 OFF)
option(LIBIGL_WITH_PREDICATES        "Use exact predicates"         ON)
option(LIBIGL_WITH_XML               "Use XML"                      OFF)

# Sanitizers
if(FLOAT_TETWILD_WITH_SANITIZERS)
	list(APPEND CMAKE_MODULE_PATH ${FLOAT_TETWILD_EXTERNAL}/sanitizers-cmake/cmake)
endif()

# Setup dependencies
include(FloatTetwildDependencies)

################################################################################
# FloatTetwild library
################################################################################

find_package(GMPfTetWild)
IF(NOT ${GMP_FOUND})
	MESSAGE(FATAL_ERROR "Cannot find mpir")
ENDIF()

# find_package(MPFR)
# IF(NOT ${MPFR_FOUND})
# 	MESSAGE(FATAL_ERROR "Cannot find MPFR")
# ENDIF()

# add_library() can only be called without any source since CMake 3.11 ...
add_library(${PROJECT_NAME} SHARED src/Logger.cpp src/external/WindingNumber.h)

# Public include directory for FloatTetwild
target_include_directories(${PROJECT_NAME} PUBLIC ${PROJECT_BINARY_DIR}/include)

# set(MESH_PATH "${CMAKE_CURRENT_SOURCE_DIR}/tests/")
# target_compile_definitions(${PROJECT_NAME} PUBLIC -DFLOAT_TETWILD_MESH_PATH=\"${MESH_PATH}\")

# Extra warnings
target_link_libraries(${PROJECT_NAME} PRIVATE warnings::all)

# Use C++11
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_11)
# if(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
# 	target_compile_options(${PROJECT_NAME} PUBLIC "/Zc:__cplusplus")
# endif()
# target_compile_definitions(${PROJECT_NAME} PUBLIC -DEIGEN_STACK_ALLOCATION_LIMIT=8388608)



################################################################################
# Required libraries
################################################################################

if(FLOAT_TETWILD_USE_FLOAT)
	target_compile_definitions(${PROJECT_NAME} PUBLIC -DFLOAT_TETWILD_USE_FLOAT)
endif()

target_include_directories(${PROJECT_NAME} SYSTEM PUBLIC ${GMP_INCLUDE_DIRS})

## TODO: which variable stores the path to the library's stub library file, in the cmake bs lingo?
target_link_directories(${PROJECT_NAME} PUBLIC "C:/Users/mathias/source/libraries/mpir/bin")
target_link_libraries(${PROJECT_NAME}
	PUBLIC
		igl::core
		igl::predicates
		geogram::geogram
		spdlog::spdlog
		Threads::Threads
		json
		${GMP_LIBRARIES}
)
if(FLOAT_TETWILD_ENABLE_TBB)
	target_link_libraries(${PROJECT_NAME} PUBLIC tbb::tbb)
	target_compile_definitions(${PROJECT_NAME} PUBLIC FLOAT_TETWILD_USE_TBB)
endif()

if(FLOAT_TETWILD_WITH_EXACT_ENVELOPE)
	target_link_libraries(${PROJECT_NAME} PUBLIC FastEnvelope)
	target_compile_definitions(${PROJECT_NAME} PUBLIC NEW_ENVELOPE)
endif()

################################################################################
# Subdirectories
################################################################################

# Other sources
add_subdirectory(src)

##########
# extremely simple test
##########
add_executable(test
	simpleTest/simpleTest.cpp
	)
target_link_libraries(test
  ${PROJECT_NAME}
  )
