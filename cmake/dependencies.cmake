
##########################################################################
#                                                                        #
# Copyright (C) 2024 Cade Weinberg                                       #
#                                                                        #
# This file is part of foundation.                                       #
#                                                                        #
# foundation is free software: you can redistribute it and/or modify     #
# it under the terms of the GNU General Public License as published by   #
# the Free Software Foundation, either version 3 of the License, or      #
# (at your option) any later version.                                    #
#                                                                        #
# foundation is distributed in the hope that it will be useful,          #
# but WITHOUT ANY WARRANTY; without even the implied warranty of         #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          #
# GNU General Public License for more details.                           #
#                                                                        #
# You should have received a copy of the GNU General Public License      #
# along with foundation.  If not, see <http://www.gnu.org/licenses/>.    #
#                                                                        #
##########################################################################

cmake_minimum_required (VERSION ${INFINITY_PATTERN_CMAKE_MINIMUM_VERSION})

include (ExternalProject)

# I think we need to install the dependencies, and the project itself in a
# location which can be specified by the consuming project.

set_directory_properties (PROPERTIES EP_PREFIX ${FOUNDATION_BINARY_DIR}/_deps)

ExternalProject_Add (
    Boost
    GIT_REPOSITORY https://github.com/boostorg/boost.git
    GIT_TAG        1bed2b0712b2119f20d66c5053def9173c8462a5 # release 1.90.0
    INSTALL_COMMAND
        ${CMAKE_COMMAND}
            --install ${FOUNDATION_BINARY_DIR}/_deps/src/Boost
            --prefix ${FOUNDATION_BINARY_DIR}
)

ExternalProject_Add (
    infinity-pattern-foundation
    DEPENDS
        Boost
    SOURCE_DIR  ${FOUNDATION_BASE_DIR}
    BINARY_DIR  ${FOUNDATION_BINARY_DIR}
    INSTALL_DIR ${FOUNDATION_BINARY_DIR}
    CMAKE_ARGS
        -DCMAKE_PREFIX_PATH:STRING=${FOUNDATION_BINARY_DIR}
        -DBUILD_DEPENDENCIES=OFF
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
        -DCMAKE_INSTALL_PREFIX:STRING=${FOUNDATION_BINARY_DIR}
)
