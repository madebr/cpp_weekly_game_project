
# Generic test that uses conan libs
add_executable(game main.cpp)
target_link_libraries(
  game PRIVATE project_options project_warnings docopt.cpp::docopt.cpp
  fmt::fmt spdlog::spdlog ImGui-SFML::ImGui-SFML)
