
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

set (FOUNDATION_TEST_SOURCES
    ${FOUNDATION_TEST_DIR}/infinity-pattern/foundation/project/version.cpp

    ${FOUNDATION_TEST_DIR}/infinity-pattern/foundation/utility/error.cpp
)

add_executable (infinity-pattern-foundation-test
    ${FOUNDATION_TEST_DIR}/infinity-pattern/foundation/main.cpp
    ${FOUNDATION_TEST_SOURCES}
)

target_include_directories(infinity-pattern-foundation-test PUBLIC
    ${FOUNDATION_INCLUDE_DIR}
)

target_link_libraries (infinity-pattern-foundation-test PUBLIC
    infinity-pattern-foundation
    stdc++exp
    Boost::unit_test_framework
)

include (CTest)

#add_test (NAME "Test All" COMMAND infinity-pattern-foundation-test)
infinity_pattern_discover_tests(infinity-pattern-foundation-test)


