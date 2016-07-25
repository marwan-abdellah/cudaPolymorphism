#####################################################################
# Copyright © 2011-2014,
# Marwan Abdellah: <abdellah.marwan@gmail.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation.

# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.

# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA.
#####################################################################

# CUDA SDK root directory
MARK_AS_ADVANCED(CUDA_SDK_ROOT)

SET(CUDA_SDK_ROOT "/usr/local/cuda/samples")

# SDK include directory
SET(CUDA_SDK_INC_DIR "${CUDA_SDK_ROOT}/common/inc")

# Add the include directories to the system tree
INCLUDE_DIRECTORIES(${CUDA_SDK_INC_DIR})


IF(CUDA_SDK_INC_DIR)
    MESSAGE(STATUS "Found CUDA-SDK in
        ${CUDA_SDK_ROOT}
        ${CUDA_SDK_INC_DIR}")
ELSE(CUDA_SDK_INC_DIR)
    MESSAGE(FATAL_ERROR "CUDA SDK NOT Found")
ENDIF(CUDA_SDK_INC_DIR)
