if(PROJECT_IS_TOP_LEVEL)
  set(CMAKE_INSTALL_INCLUDEDIR include/dggssandbox CACHE PATH "")
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package dggssandbox)

install(
    TARGETS dggssandbox_exe
    EXPORT dggssandboxTargets
    RUNTIME COMPONENT dggssandbox_Runtime
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    dggssandbox_INSTALL_CMAKEDIR "${CMAKE_INSTALL_DATADIR}/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced(dggssandbox_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${dggssandbox_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT dggssandbox_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${dggssandbox_INSTALL_CMAKEDIR}"
    COMPONENT dggssandbox_Development
)

install(
    EXPORT dggssandboxTargets
    NAMESPACE dggssandbox::
    DESTINATION "${dggssandbox_INSTALL_CMAKEDIR}"
    COMPONENT dggssandbox_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
