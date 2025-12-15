
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

cmake_minimum_required (VERSION 3.30)

set (CMAKE_CXX_STANDARD 23)
set (CMAKE_CXX_STANDARD_REQUIRED ON)

project (FOUNDATION
	LANGUAGES CXX
	VERSION 0.1.0.1
	DESCRIPTION "A C++ Foundation library for the other Infinity Pattern projects."
)

set (INFINITY_PATTERN_CMAKE_MINIMUM_VERSION 3.30)

set (FOUNDATION_SOURCE_DIR ${PROJECT_SOURCE_DIR}/source)
set (FOUNDATION_INCLUDE_DIR ${PROJECT_SOURCE_DIR}/include)
set (FOUNDATION_TEST_DIR ${PROJECT_SOURCE_DIR}/test)
set (FOUNDATION_CMAKE_DIR ${PROJECT_SOURCE_DIR}/cmake)

include (${FOUNDATION_CMAKE_DIR}/host.cmake)
include (${FOUNDATION_CMAKE_DIR}/base.cmake)
include (${FOUNDATION_CMAKE_DIR}/dependencies.cmake)
include (${FOUNDATION_CMAKE_DIR}/discover_tests.cmake)

add_subdirectory (${FOUNDATION_SOURCE_DIR}/infinity-pattern/foundation)
add_subdirectory (${FOUNDATION_TEST_DIR}/infinity-pattern/foundation)
