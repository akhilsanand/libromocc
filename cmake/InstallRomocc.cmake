# This will install romocc binaries, libraries and necessary include files to the path given by CMAKE_INSTALL_PREFIX

# Install romocc library
if(WIN32)
# DLL should be in binary folder
install(TARGETS romocc
	DESTINATION libromocc/bin
)
else()
install(TARGETS romocc
	DESTINATION libromocc/lib
)
endif()

if(ROMOCC_BUILD_TESTS)
	# Install test executable
	install(TARGETS testROMOCC
			DESTINATION libromocc/bin
			)
endif()

# Examples are installed in the macro project_add_example

# Install dependency libraries
install(FILES ${PROJECT_BINARY_DIR}/romoccExport.hpp
    DESTINATION libromocc/include
)

if(WIN32)
	file(GLOB DLLs ${PROJECT_BINARY_DIR}/bin/*.dll)
	install(FILES ${DLLs}
		DESTINATION libromocc/bin
	)
	file(GLOB DLLs ${PROJECT_BINARY_DIR}/lib/*.lib)
	install(FILES ${DLLs}
		DESTINATION libromocc/lib
	)
elseif(APPLE)
	file(GLOB SOs ${PROJECT_BINARY_DIR}/lib/*.dylib)
	install(FILES ${SOs}
        DESTINATION libromocc/lib
    )
else()
	file(GLOB SOs ${PROJECT_BINARY_DIR}/lib/*.so*)
	install(FILES ${SOs}
		DESTINATION libromocc/lib
	)
endif()

# Install headers
install(DIRECTORY ${ROMOCC_SOURCE_DIR}
	DESTINATION libromocc/include/romocc/
	FILES_MATCHING PATTERN "*.hpp"
)
install(DIRECTORY ${ROMOCC_SOURCE_DIR}
	DESTINATION libromocc/include/romocc/
	FILES_MATCHING PATTERN "*.h"
)
install(DIRECTORY ${PROJECT_BINARY_DIR}/include/
    DESTINATION libromocc/include/
    FILES_MATCHING PATTERN "*.h"
)
install(DIRECTORY ${PROJECT_BINARY_DIR}/include/
    DESTINATION libromocc/include/
    FILES_MATCHING PATTERN "*.hpp"
)
install(DIRECTORY ${PROJECT_BINARY_DIR}/include/
    DESTINATION libromocc/include/
    FILES_MATCHING REGEX "/[^.]+$" # Files with no extension
)

# Install CMake files
install(FILES ${PROJECT_BINARY_DIR}/RomoccConfig.cmake ${PROJECT_BINARY_DIR}/RomoccUse.cmake
		DESTINATION libromocc/cmake
		)

# Install Romocc license file
install(FILES ${PROJECT_SOURCE_DIR}/LICENSE
		DESTINATION libromocc/licenses/romocc/
		)

# Install license files for depedencies
# Eigen
file(GLOB LICENSE_FILES ${ROMOCC_EXTERNAL_BUILD_DIR}/eigen/src/eigen/COPYING.*)
install(FILES ${LICENSE_FILES}
		DESTINATION libromocc/licenses/eigen/
		)

# Orocos
install(FILES ${ROMOCC_EXTERNAL_BUILD_DIR}/orocos/src/orocos/orocos_kdl/COPYING
		DESTINATION libromocc/licenses/orocos-kdl/
		)

# Install Python wrapper
if(ROMOCC_BUILD_PYTHON)
#	install(TARGETS _romocc
#			DESTINATION libromocc/python/romocc
#			)
#	install(FILES ${PROJECT_BINARY_DIR}/python/romocc/romocc.py
#			DESTINATION libromocc/python/romocc
#			)
#	install(FILES ${PROJECT_BINARY_DIR}/lib/romocc/setup.py
#			DESTINATION libromocc/python/romocc
#			)
endif()
