
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

include(FetchContent)

FetchContent_Declare (
    Boost
    GIT_REPOSITORY https://github.com/boostorg/boost.git
    GIT_TAG        1bed2b0712b2119f20d66c5053def9173c8462a5 # release 1.90.0
)

FetchContent_MakeAvailable(
    Boost
)
