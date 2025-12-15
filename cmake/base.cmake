
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

#**********************************************************************************#
#                                                                                  #
#            Basic utility functions for use throughout cmake projects             #
#                                                                                  #
#**********************************************************************************#

function (debug_message)
    if (DEFINED INFINITY_PATTERN_CMAKE_DEBUG)
        message (DEBUG "${ARGV0}")
    endif ()
endfunction ()


#**********************************************************************************#
#                                                                                  #
#                   Set the base warnings for the C++ compiler                     #
#                                                                                  #
#**********************************************************************************#

if (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_KNOWN)
	if (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_GNU OR INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_CLANG)
		set (INFINITY_PATTERN_FOUNDATION_CXX_WARNINGS
			-Wall
			-Wdeprecated
			-Wextra
			-Wpedantic
			-Wconversion
		)
	elseif (INFINITY_PATTERN_FOUNDATION_HOST_CXX_COMPILER_MSVC) 
		set (INFINITY_PATTERN_FOUNDATION_CXX_WARNINGS 
			-/Wall
		)
	else ()
		set (INFINITY_PATTERN_FOUNDATION_CXX_WARNINGS)
		message (AUTHOR_WARNING "C++ host compiler known [${CMAKE_CXX_COMPILER_ID}] yet is unhandled when setting base warnings.")
	endif ()
else ()
	set (INFINITY_PATTERN_FOUNDATION_HOST_CXX_WARNINGS)
	message (WARNING "Unknown host C++ compiler; unable to set compilation warnings.")
endif ()

#**********************************************************************************#
#                                                                                  #
#                 Extract git revision and timestamp for Foundation                #
#                                                                                  #
#**********************************************************************************#


# Function to extract the git revision and describe of the current project
#
# This function uses git to report the current build revision for automated tooling,
# and the current git describe for human read output.
#
# Arguments:
#   revision: the name of the variable to be set with the contents of git rev-parse
#   describe: the name of the variable to set with the contents of git describe
#     [path]: [optional] the working directory for the git commands. defaults to CMAKE_CURRENT_SOURCE_DIR
#
function (infinity_pattern_extract_revision revision describe)
    # optional 3rd argument: path to repo to query (defaults to CMAKE_CURRENT_SOURCE_DIR)
    set(_repo_dir "${ARGN}")
    if (NOT _repo_dir)
        set(_repo_dir "${CMAKE_CURRENT_SOURCE_DIR}")
    endif()

    # Linux, Windows and Darwin OS should all support the following commands.
    if (INFINITY_PATTERN_FOUNDATION_HOST_SYSTEM_KNOWN)
        execute_process(
            COMMAND git describe --dirty
            WORKING_DIRECTORY "${_repo_dir}"
            OUTPUT_VARIABLE _found_describe
            RESULT_VARIABLE _git_describe_result
            OUTPUT_STRIP_TRAILING_WHITESPACE
        )

        execute_process(
            COMMAND git rev-parse HEAD
            WORKING_DIRECTORY "${_repo_dir}"
            OUTPUT_VARIABLE _found_rev
            RESULT_VARIABLE _git_rev_result
            OUTPUT_STRIP_TRAILING_WHITESPACE
        )

        if (NOT _git_describe_result EQUAL 0)
            message (AUTHOR_WARNING "git describe failed (result:${_git_describe_result}) in ${_repo_dir}; leaving describe empty")
        endif ()

        if (NOT _git_rev_result EQUAL 0)
            message(AUTHOR_WARNING "git rev-parse failed (result: ${_git_result}) in ${_repo_dir}; leaving revision empty")
        endif()

        # Propagate into the variable names the caller supplied
        set(${revision} "${_found_rev}" PARENT_SCOPE)
        set(${describe} "${_found_describe}" PARENT_SCOPE)
    else ()
        message (WARNING "Unable to extract build revision")
    endif ()
endfunction ()

infinity_pattern_extract_revision(FOUNDATION_BUILD_REVISION FOUNDATION_BUILD_DESCRIBE)
message (STATUS "Foundation: git revision: ${FOUNDATION_BUILD_REVISION}")
message (STATUS "Foundation: git describe: ${FOUNDATION_BUILD_DESCRIBE}")

#
# A Function to generate a timestamp of the build. For embedding into the resulting executable
#
# Arguments:
#   timestamp: the name of the variable to be set with the timestamp
#
function (infinity_pattern_generate_timestamp timestamp)
	string (TIMESTAMP _timestamp "%Y-%m-%d %H:%M:%S")
	set (${timestamp} "${_timestamp}" PARENT_SCOPE)
endfunction ()

infinity_pattern_generate_timestamp (FOUNDATION_BUILD_TIMESTAMP)
message (STATUS "Foundation: build timestamp: ${FOUNDATION_BUILD_TIMESTAMP}")


