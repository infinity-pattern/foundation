
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

cmake_minimum_required(VERSION 4.0)

#**********************************************************************************#
#                                                                                  #
#                   Detect which compiler is being used for C++                    #
#                                                                                  #
#**********************************************************************************#

if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
	set (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_KNOWN ON)
	set (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_GNU ON)
	set (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_CLANG OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_MSVC OFF)
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
	set (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_KNOWN ON)
	set (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_GNU OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_CLANG ON)
	set (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_MSVC OFF)
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
	set (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_KNOWN ON)
	set (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_GNU OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_CLANG OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_MSVC ON)
else ()
	set (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_KNOWN OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_GNU OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_CLANG OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_MSVC OFF)
	message (WARNING "Unknown Host C++ Compiler: ${CMAKE_CXX_COMPILER_ID}")
endif ()

#**********************************************************************************#
#                                                                                  #
#                   Detect which compiler is being used for C                      #
#                                                                                  #
#**********************************************************************************#

if (CMAKE_C_COMPILER_ID STREQUAL "GNU")
	set (INFINITY_PATTERN_FOUNDATION_HOST_C_COMPILER_KNOWN ON)
	set (INFINITY_PATTERN_FOUNDATION_HOST_C_COMPILER_GNU ON)
	set (INFINITY_PATTERN_FOUNDATION_HOST_C_COMPILER_CLANG OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_C_COMPILER_MSVC OFF)
elseif (CMAKE_C_COMPILER_ID STREQUAL "Clang")
	set (INFINITY_PATTERN_FOUNDATION_HOST_C_COMPILER_KNOWN ON)
	set (INFINITY_PATTERN_FOUNDATION_HOST_C_COMPILER_GNU OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_C_COMPILER_CLANG ON)
	set (INFINITY_PATTERN_FOUNDATION_HOST_C_COMPILER_MSVC OFF)
elseif (CMAKE_C_COMPILER_ID STREQUAL "MSVC")
	set (INFINITY_PATTERN_FOUNDATION_HOST_C_COMPILER_KNOWN ON)
	set (INFINITY_PATTERN_FOUNDATION_HOST_C_COMPILER_GNU OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_C_COMPILER_CLANG OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_C_COMPILER_MSVC ON)
else ()
	set (INFINITY_PATTERN_FOUNDATION_HOST_C_COMPILER_KNOWN OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_C_COMPILER_GNU OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_C_COMPILER_CLANG OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_C_COMPILER_MSVC OFF)
	message (WARNING "Unknown Host C Compiler: ${CMAKE_C_COMPILER_ID}")
endif ()


#**********************************************************************************#
#                                                                                  #
#                 Detect which operating system we are hosted on                   #
#                                                                                  #
#**********************************************************************************#

if (CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
	set (INFINITY_PATTERN_FOUNDATION_HOST_SYSTEM_KNOWN ON)
	set (INFINITY_PATTERN_FOUNDATION_HOST_SYSTEM_LINUX ON)
	set (INFINITY_PATTERN_FOUNDATION_HOST_SYSTEM_APPLE OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_SYSTEM_WINDOWS OFF)
elseif (CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin")
	set (INFINITY_PATTERN_FOUNDATION_HOST_SYSTEM_KNOWN ON)
	set (INFINITY_PATTERN_FOUNDATION_HOST_SYSTEM_LINUX OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_SYSTEM_APPLE ON)
	set (INFINITY_PATTERN_FOUNDATION_HOST_SYSTEM_WINDOWS OFF)
elseif (CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows")
	set (INFINITY_PATTERN_FOUNDATION_HOST_SYSTEM_KNOWN ON)
	set (INFINITY_PATTERN_FOUNDATION_HOST_SYSTEM_LINUX OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_SYSTEM_APPLE OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_SYSTEM_WINDOWS ON)
else ()
	set (INFINITY_PATTERN_FOUNDATION_HOST_SYSTEM_KNOWN OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_SYSTEM_LINUX OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_SYSTEM_APPLE OFF)
	set (INFINITY_PATTERN_FOUNDATION_HOST_SYSTEM_WINDOWS OFF)
	message (WARNING "Unknown Host System: ${CMAKE_HOST_SYSTEM_NAME}")
endif ()


