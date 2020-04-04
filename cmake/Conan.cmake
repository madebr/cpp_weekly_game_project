function(run_conan)
cmake_parse_arguments(RC "" "ALL" "" ${ARGN})
# Download automatically, you can also just copy the conan.cmake file
if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
  message(
    STATUS
      "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
  file(DOWNLOAD "https://github.com/conan-io/cmake-conan/raw/v0.15/conan.cmake"
       "${CMAKE_BINARY_DIR}/conan.cmake")
endif()

include(${CMAKE_BINARY_DIR}/conan.cmake)

conan_add_remote(NAME bincrafters URL
                 https://api.bintray.com/conan/bincrafters/public-conan)

set(REQUIREMENTS
  docopt.cpp/0.6.2
  imgui-sfml/2.1@bincrafters/stable
)

if(RC_ALL)
  list(APPEND REQUIREMENTS
    catch2/2.11.0
    fmt/6.1.2
    spdlog/1.5.0
  )
endif()


conan_cmake_run(
  REQUIRES
    ${CONAN_EXTRA_REQUIRES}
    ${REQUIREMENTS}
  OPTIONS
    ${CONAN_EXTRA_OPTIONS}
  BASIC_SETUP
  BUILD
    missing
  GENERATORS
    cmake_find_package  # Create FindXXX.cmake cmake modules
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_BINARY_DIR}")
set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" PARENT_SCOPE)
endfunction()
