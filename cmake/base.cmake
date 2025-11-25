
##########################################################################
#                                                                        #
# Copyright (C) 2024 Cade Weinberg                                       #
#                                                                        #
# This file is part of infinity.                                         #
#                                                                        #
# infinity is free software: you can redistribute it and/or modify       #
# it under the terms of the GNU General Public License as published by   #
# the Free Software Foundation, either version 3 of the License, or      #
# (at your option) any later version.                                    #
#                                                                        #
# infinity is distributed in the hope that it will be useful,            #
# but WITHOUT ANY WARRANTY; without even the implied warranty of         #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          #
# GNU General Public License for more details.                           #
#                                                                        #
# You should have received a copy of the GNU General Public License      #
# along with infinity.  If not, see <http://www.gnu.org/licenses/>.      #
#                                                                        #
##########################################################################

cmake_minimum_required (VERSION 4.0)

#**********************************************************************************#
#                                                                                  #
#                   Set the base warnings for the C++ compiler                     #
#                                                                                  #
#**********************************************************************************#

if (FOUNDATION_HOST_CXX_COMPILER_KNOWN)
	if (FOUNDATION_HOST_CXX_COMPILER_GNU OR FOUNDATION_HOST_CXX_COMPILER_CLANG)
		set (FOUNDATION_CXX_WARNINGS
			-Wall
			-Wdeprecated
			-Wextra
			-Wpedantic
			-Wconversion
		)
	elseif (FOUNDATION_HOST_CXX_COMPILER_MSVC) 
		set (FOUNDATION_CXX_WARNINGS 
			-/Wall
		)
	else ()
		set (FOUNDATION_CXX_WARNINGS)
		message (AUTHOR_WARNING "C++ host compiler known [${CMAKE_CXX_COMPILER_ID}] yet is unhandled when setting base warnings.")
	endif ()
else ()
	set (FOUNDATION_HOST_CXX_WARNINGS)
	message (WARNING "Unknown host C++ compiler; unable to set compilation warnings.")
endif ()

#**********************************************************************************#
#                                                                                  #
#                   Set the base warnings for the C compiler                       #
#                                                                                  #
#**********************************************************************************#

if (FOUNDATION_HOST_C_COMPILER_KNOWN)
	if (FOUNDATION_HOST_C_COMPILER_GNU OR FOUNDATION_HOST_C_COMPILER_CLANG)
		set(FOUNDATION_C_WARNINGS 
			-Wall
			-Wdeprecated
			-Wextra
			-Wpedantic
			-Wconversion
		)
	elseif (FOUNDATION_HOST_C_COMPILER_MSVC)
		set (FOUNDATION_C_WARNINGS
			-/Wall
		)
	else ()
		set (FOUNDATION_C_WARNINGS)
		message (AUTHOR_WARNING "C host compiler known [${CMAKE_C_COMPILER_ID}] yet is unhandled when setting base warnings.")
	endif ()
else ()
	set(FOUNDATION_C_WARNINGS)
	message (WARNING "Unknown host C compiler; unable to set compilation warnings.")
endif ()

#**********************************************************************************#
#                                                                                  #
#                 Extract git revision and timestamp for Foundation                #
#                                                                                  #
#**********************************************************************************#

function (infinity_foundation_extract_revision revision revision_short)
    # optional 3rd+ args: path to repo to query (defaults to CMAKE_CURRENT_SOURCE_DIR)
    set(_repo_dir "${ARGN}")
    if (NOT _repo_dir)
        set(_repo_dir "${CMAKE_CURRENT_SOURCE_DIR}")
    endif()

    if (FOUNDATION_HOST_SYSTEM_KNOWN)
        if (FOUNDATION_HOST_SYSTEM_LINUX OR FOUNDATION_HOST_SYSTEM_WINDOWS)
            execute_process(
              COMMAND git rev-parse --short HEAD
              WORKING_DIRECTORY "${_repo_dir}"
              OUTPUT_VARIABLE _found_rev_short
              RESULT_VARIABLE _git_short_result
              OUTPUT_STRIP_TRAILING_WHITESPACE
            )

            execute_process(
              COMMAND git rev-parse HEAD
              WORKING_DIRECTORY "${_repo_dir}"
              OUTPUT_VARIABLE _found_rev
              RESULT_VARIABLE _git_result
              OUTPUT_STRIP_TRAILING_WHITESPACE
            )

            if (NOT _git_short_result EQUAL 0 OR NOT _git_result EQUAL 0)
                message(AUTHOR_WARNING "git rev-parse failed (short:${_git_short_result} full:${_git_result}) in ${_repo_dir}; leaving revisions empty")
            endif()

            # Propagate into the variable names the caller supplied
            set(${revision} "${_found_rev}" PARENT_SCOPE)
            set(${revision_short} "${_found_rev_short}" PARENT_SCOPE)
        else ()
            message (AUTHOR_WARNING "Host system known, ${CMAKE_HOST_SYSTEM_NAME}, but unhandled when extracting git revision; leaving revision empty")
        endif ()
    else ()
        message (WARNING "Unable to extract build revision")
    endif ()
endfunction ()

infinity_foundation_extract_revision(FOUNDATION_BUILD_REVISION FOUNDATION_BUILD_REVISION_SHORT)
message (STATUS "Git Revision: ${FOUNDATION_BUILD_REVISION}") 

function (infinity_foundation_generate_timestamp output_name)
	string (TIMESTAMP _timestamp "%Y-%m-%d %H:%M:%S")
	set (${output_name} "${_timestamp}" PARENT_SCOPE)
endfunction ()

infinity_foundation_generate_timestamp (FOUNDATION_BUILD_TIMESTAMP)
message (STATUS "Timestamp: ${FOUNDATION_BUILD_TIMESTAMP}")


