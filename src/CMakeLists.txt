#####################################################################
### Copyright © 2015 - 2016
### Marwan Abdellah <abdellah.marwan@gmail.com>
#####################################################################

### Adding the source files to the CMake source tree
set( CPP_SOURCE_FILES )

### Adding the header files to the CMake source tree
set( CPP_HEADER_FILES )

### Adding the source files to the CMake source tree
set( CUDA_SOURCE_FILES
    Number.cu
    One.cu
    Two.cu
    Allocator.cu
)

### Adding the header files to the CMake source tree
set( CUDA_HEADER_FILES
    Number.h
    One.h
    Two.h
    Allocator.h
)

### Adding the kernels to the CMake source tree
set( CUDA_KERNEL_FILES )

### Include the directories to the CMake source tree
include_directories( ${CMAKE_CURRENT_SOURCE_DIR} )

### Generate the executable
cuda_add_executable( run Run.cu
    ${CPP_SOURCE_FILES}
    ${CPP_HEADER_FILES}
    ${CUDA_SOURCE_FILES}
    ${CUDA_HEADER_FILES}
    ${CUDA_KERNEL_FILES}
)

