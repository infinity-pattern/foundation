
##########################################################################
#                                                                        #
# Copyright (C) 2024 Cade Weinberg                                       #
#                                                                        #
# This file is part of foundation.                                         #
#                                                                        #
# foundation is free software: you can redistribute it and/or modify       #
# it under the terms of the GNU General Public License as published by   #
# the Free Software Foundation, either version 3 of the License, or      #
# (at your option) any later version.                                    #
#                                                                        #
# foundation is distributed in the hope that it will be useful,            #
# but WITHOUT ANY WARRANTY; without even the implied warranty of         #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          #
# GNU General Public License for more details.                           #
#                                                                        #
# You should have received a copy of the GNU General Public License      #
# along with foundation.  If not, see <http://www.gnu.org/licenses/>.      #
#                                                                        #
##########################################################################

cmake_minimum_required (VERSION 4.0)

set (CMAKE_C_STANDARD 99)
set (CMAKE_CXX_STANDARD 23)
set (CMAKE_C_STANDARD_REQUIRED ON)
set (CMAKE_CXX_STANDARD_REQUIRED ON)

project (FOUNDATION
	LANGUAGES C CXX 
	VERSION 0.1.0.0
	DESCRIPTION "A Foundation library for the other Infinity projects."
)

include (${PROJECT_SOURCE_DIR}/cmake/host.cmake)
include (${PROJECT_SOURCE_DIR}/cmake/base.cmake)

set (FOUNDATION_SOURCE_DIR ${PROJECT_SOURCE_DIR}/source)
set (FOUNDATION_INCLUDE_DIR ${PROJECT_SOURCE_DIR}/include)

configure_file (
	${FOUNDATION_INCLUDE_DIR}/foundation/host.hh.in
	${FOUNDATION_INCLUDE_DIR}/foundation/host.hh
)

configure_file ( 
	${FOUNDATION_SOURCE_DIR}/foundation/version.cc.in
	${FOUNDATION_SOURCE_DIR}/foundation/version.cc 
)

set (FOUNDATION_SOURCES 
	${FOUNDATION_SOURCE_DIR}/foundation/version.cc
)

add_library (InfinityFoundation
	${FOUNDATION_SOURCES}
)
target_include_directories (InfinityFoundation PUBLIC 
	${FOUNDATION_INCLUDE_DIR}
)


