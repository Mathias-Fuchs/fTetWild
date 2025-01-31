# Try to find the GMP librairies
# GMP_FOUND - system has GMP lib
# GMP_INCLUDE_DIRS - the GMP include directory
# GMP_LIBRARIES - Libraries needed to use GMP
if (WIN32)

	set(GMP_INC "C:/Users/mathias/libraries/mpir/include")
	set(GMP_LIB "C:/Users/mathias/source/libraries/mpir/bin")

  MESSAGE(STATUS "GMP environment variables: " $ENV{GMP_INC} " " $ENV{GMP_LIB} )
  find_path(GMP_INCLUDE_DIRS NAMES mpir.h PATHS $ENV{GMP_INC} ${GMP_WINDOWS_PATH})
  find_library(GMP_LIBRARIES NAMES mpir PATHS $ENV{GMP_LIB} ${GMP_WINDOWS_PATH})
  MESSAGE(STATUS "GMP libs: " ${GMP_LIBRARIES} " " ${GMPXX_LIBRARIES} )
  include(FindPackageHandleStandardArgs)
  FIND_PACKAGE_HANDLE_STANDARD_ARGS(GMP DEFAULT_MSG GMP_INCLUDE_DIRS GMP_LIBRARIES)
  mark_as_advanced(GMP_INCLUDE_DIRS GMP_LIBRARIES)
  MESSAGE(STATUS "GMP libs: " ${GMP_LIBRARIES} )
  MESSAGE(STATUS "GMP include dirs: " ${GMP_INCLUDE_DIRS})
  ## MESSAGE(STATUS "GMP library dirs: " ${GMP_LIBRARY_DIRS})
else()
  if (GMP_INCLUDE_DIRS AND GMP_LIBRARIES)
    # Already in cache, be silent
    set(GMP_FIND_QUIETLY TRUE)
  endif (GMP_INCLUDE_DIRS AND GMP_LIBRARIES)
  find_path(GMP_INCLUDE_DIRS NAMES gmp.h PATHS $ENV{GMP_INC} ${GMP_WINDOWS_PATH})
  find_library(GMP_LIBRARIES NAMES gmp libgmp PATHS $ENV{GMP_LIB} ${GMP_WINDOWS_PATH})
  find_library(GMPXX_LIBRARIES NAMES gmpxx libgmpxx PATHS $ENV{GMP_LIB} ${GMP_WINDOWS_PATH})
  #MESSAGE(STATUS "GMP libs: " ${GMP_LIBRARIES} " " ${GMPXX_LIBRARIES} )

  include(FindPackageHandleStandardArgs)
  FIND_PACKAGE_HANDLE_STANDARD_ARGS(GMP DEFAULT_MSG GMP_INCLUDE_DIRS GMP_LIBRARIES)

  mark_as_advanced(GMP_INCLUDE_DIRS GMP_LIBRARIES)
  MESSAGE(STATUS "GMP libs: " ${GMP_LIBRARIES} " " ${GMP_INCLUDE_DIRS} )
endif()

