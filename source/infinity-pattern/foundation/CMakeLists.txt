
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

configure_file (
	${FOUNDATION_SOURCE_DIR}/infinity-pattern/foundation/project/version.cpp.in
	${FOUNDATION_SOURCE_DIR}/infinity-pattern/foundation/project/version.cpp
)

set (FOUNDATION_SOURCES
	${FOUNDATION_SOURCE_DIR}/infinity-pattern/foundation/project/version.cpp
)

add_library (infinity-pattern-foundation
	${FOUNDATION_SOURCES}
)

target_include_directories (infinity-pattern-foundation PUBLIC
	${FOUNDATION_INCLUDE_DIR}
)

target_link_libraries(infinity-pattern-foundation PUBLIC

)
