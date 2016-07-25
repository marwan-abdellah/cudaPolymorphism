#####################################################################
### Copyright © 2015 - 2016
### Marwan Abdellah <abdellah.marwan@gmail.com>
#####################################################################

cmake_minimum_required( VERSION 3.0 )

project( cudaVirtualClasses )

### cmake modules
list( APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake )

### C++ 11 support
set( CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS} -g -ftest-coverage -fprofile-arcs" )


#########################################################
#! Find packages
#########################################################
INCLUDE( CUDA )
INCLUDE( CUDA_SDK )

add_subdirectory( src )

