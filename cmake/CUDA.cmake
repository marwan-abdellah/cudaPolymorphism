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

# Find CUDA package

FIND_PACKAGE(CUDA 7.0 REQUIRED)

IF(CUDA_FOUND)
    MESSAGE(STATUS "CUDA Found")
    INCLUDE_DIRECTORIES(${CUDA_INCLUDE_DIRS})
    LINK_LIBRARIES(${CUDA_LIBRARIES})

    # Compilation flags for NVCC
    SET(CUDA_SEPARABLE_COMPILATION ON)
    SET(CUDA_VERBOSE_BUILD OFF)

    IF(${CUDA_SEPARABLE_COMPILATION})
        SET(_CUDA_ARCH_STR "-arch=sm_20")
    ELSEIF(${CUDA_SEPARABLE_COMPILATION})
        # Set the CUDA GPU architectures to compile for:
        # - with CUDA >v4.2 compute capability 2.0, 2.1 is, but 3.0 is not supported:
        #     => compile sm_20, sm_21 cubin, and compute_20 PTX
        # - with CUDA >=4.2 compute capability <=3.0 is supported:
        #     => compile sm_20, sm_21, sm_30 cubin, and compute_30 PTX
        # - with CUDA 5.0 and later compute capability 3.5 is supported
        #     => compile sm_20, sm_21, sm_30, sm_35 cubin, and compute_35 PTX
        IF(CUDA_VERSION VERSION_LESS "4.2")
            SET(_CUDA_ARCH_STR "-gencode;arch=compute_20,code=sm_20;
                                -gencode;arch=compute_20,code=sm_21;
                                -gencode;arch=compute_20,code=compute_20")
        ELSEIF(CUDA_VERSION VERSION_LESS "5.0")
            SET(_CUDA_ARCH_STR "-gencode;arch=compute_20,code=sm_20;
                                -gencode;arch=compute_20,code=sm_21;
                                -gencode;arch=compute_30,code=sm_30;
                                -gencode;arch=compute_30,code=compute_30")
        ELSE()
            SET(_CUDA_ARCH_STR "-gencode;arch=compute_20,code=sm_20;
                                -gencode;arch=compute_20,code=sm_21;
                                -gencode;arch=compute_30,code=sm_30;
                                -gencode;arch=compute_35,code=sm_35;
                                -gencode;arch=compute_35,code=compute_35")
        ENDIF()

        LIST(APPEND NVCC_FLAGS_LIST ${_CUDA_ARCH_STR})
        LIST(APPEND NVCC_FLAGS_LIST ${_HOST_COMPILER_OPTION_STRING})
        LIST(APPEND NVCC_FLAGS_LIST ${CUDA_HOST_COMPILER_OPTIONS})

    ENDIF(${CUDA_SEPARABLE_COMPILATION})

    # Finally set the right flags
    SET(CUDA_NVCC_FLAGS "${NVCC_FLAGS_LIST};-rdc=true"
        CACHE STRING "Compiler flags for nvcc." FORCE)

ELSE(CUDA_FOUND)
    MESSAGE(FATAL_ERROR "CUDA NOT Found")
ENDIF(CUDA_FOUND)
