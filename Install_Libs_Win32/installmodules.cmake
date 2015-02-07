file(GLOB MODULE_FILES "rpavlik/*")
file(COPY ${MODULE_FILES} DESTINATION "${CMAKE_ROOT}/Modules/")

file(GLOB TEMPLATE_FILES "rpavlik/launcher-templates/*")
file(COPY ${MODULE_FILES} DESTINATION "${CMAKE_ROOT}/Modules/launcher-templates/")