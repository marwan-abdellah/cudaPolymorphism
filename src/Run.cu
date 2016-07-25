#include <Shared.hh>
#include <Number.h>
#include <One.h>
#include <Two.h>
#include <Allocator.h>

#define ARRAY_SIZE 8

__global__
void getData( Number** numbers, int* data, int N )
{
    int idx = threadIdx.x + blockDim.x * blockIdx.x;
    if( idx < N )
    {
        data[idx] = numbers[idx]->getNumber( );
    }
}

int main( )
{
    /// Validation data
    int* dataHost = new int[ARRAY_SIZE];
    int* dataDevice;
    cudaMalloc( &dataDevice, sizeof( int ) * ARRAY_SIZE );

    /// ONES
    // Allocate on the GPU to use the virtual function
    Allocator< One >* onesAllocator = new Allocator< One >( ARRAY_SIZE );
    Number** ones = ( Number** )( onesAllocator->getObjects( ));

    // Run the kernel for the ones
    getData <<< 1, ARRAY_SIZE >>> ( ones, dataDevice, ARRAY_SIZE );

    // Get the data back
    cudaMemcpy( dataHost, dataDevice, sizeof( int ) * ARRAY_SIZE,
               cudaMemcpyDeviceToHost );
    for( int i = 0; i < ARRAY_SIZE; i++ )
        std::cout << "ones: " << dataHost[i] << std::endl;

    /// TWOS
    Allocator< Two >* twosAllocator = new Allocator<Two>( ARRAY_SIZE );
    Number** twos = ( Number** )( twosAllocator->getObjects( ));

    // Run the kernel for the twos
    getData <<< 1, ARRAY_SIZE >>> ( twos, dataDevice, ARRAY_SIZE );

    // Get the data back
    cudaMemcpy( dataHost, dataDevice, sizeof( int ) * ARRAY_SIZE,
               cudaMemcpyDeviceToHost);
    for( int i = 0; i < ARRAY_SIZE; i++ )
        std::cout << "twos: " << dataHost[i] << std::endl;

    return EXIT_SUCCESS;
}
























////Two* twoHost;
//__device__ Two* twoDevice;


///// KERNELS ////////////////////////////////////////////////////////////////////
//__global__
//void __kernel__getNumber(Number* numberDevice, int* number)
//{
//    int idx = threadIdx.x+blockDim.x*blockIdx.x;
//    if(idx == 0) {
//        *number = numberDevice->getNumber();
//    }
//}

//__global__
//void __kernel__allocateTwo()
//{
//    int idx = threadIdx.x+blockDim.x*blockIdx.x;
//    if(idx == 0) {
//        twoDevice = new Two(400);
//    }
//}

///// WRAPPERS ///////////////////////////////////////////////////////////////////
//void getNumber(Number* numberDevice, int* number)
//{
//    __kernel__getNumber <<< 1, 1 >>> (numberDevice, number);
//}

///// MAIN ///////////////////////////////////////////////////////////////////////
//int main()
//{
//    // Allocate the array that will get the one
//    int* resultHost = new int();
//    int* resultDevice;
//    cudaMalloc(&resultDevice, sizeof(int));

////    /// Allocate memory for the device data
////    checkCudaErrors(cudaMallocHost((void**) &twoDevice,
////                                   sizeof(Two*), cudaHostAllocWriteCombined));


//    __kernel__allocateTwo<<< 1, 1>>>();
//    cudaDeviceSynchronize();
//    cudaError_t error = cudaGetLastError();
//    if(error!=cudaSuccess)
//    {
//        fprintf(stderr,"1ERROR: validClassKernel: %s\n", cudaGetErrorString(error) );
//    }



////    float *ah;
////        cudaMalloc((void **)&ah, sz);
////        cudaMemcpyToSymbol("a", &ah, sizeof(float *), size_t(0),cudaMemcpyHostToDevice);

//    /// Get the address of thge device variable
//    Two* address;
//    cudaMalloc((void **)&address, sizeof(Two));
//    cudaGetSymbolAddress((void **)&address, twoDevice);

//    // checkCudaErrors(cudaGetSymbolAddress((void**)&address, twoDevice));

//    /// Transfer the data to the address on the device
//    // checkCudaErrors(cudaMemcpy(address, twoDevice, sizeof(Two*),cudaMemcpyDeviceToDevice));









////    Two* devicePtr;
////    cudaGetSymbolAddress((void**)&devicePtr, twoDevice);

////    //  cudaMemcpyFromSymbol(twoHost, twoDevice, sizeof(Two*), 0, cudaMemcpyDeviceToHost);
////    cudaDeviceSynchronize();
////    error = cudaGetLastError();
////    if(error!=cudaSuccess)
////    {
////        fprintf(stderr,"2ERROR: validClassKernel: %s\n", cudaGetErrorString(error) );
////    }


//    getNumber(address, resultDevice);
//    cudaDeviceSynchronize();
//    error = cudaGetLastError();
//    if(error!=cudaSuccess)
//    {
//        fprintf(stderr,"3ERROR: validClassKernel: %s\n", cudaGetErrorString(error) );
//    }

//    // Transfer the array to the host
//    cudaMemcpy(resultHost, resultDevice, sizeof(int),cudaMemcpyDeviceToHost);

//    std::cout << "Result: " << *resultHost << std::endl;

//    return EXIT_SUCCESS;
//}

//#include <stdio.h>
//#include <cuda_runtime.h>
//#include "helper_cuda.h"


////int host_x[4] = {1, 2, 3, 4};
////__device__ int dev_x[4];

////__global__ void kernel(int *d_var) { d_var[threadIdx.x] += 10; }

////int main(void)
////{
////    /* Declarations */
////    int data_size = 4 * sizeof(int);
////    int *address;

////    /* Allocate memory for `dev_x` using `cudaMallocHost` */
////    checkCudaErrors(cudaMallocHost((void**) &dev_x, data_size, cudaHostAllocWriteCombined));

////    /* Get the address of the `__device__` variable `dev_x` */
////    checkCudaErrors(cudaGetSymbolAddress((void**)&address, dev_x));

////    /* Transfer data to `address` on the device */
////    checkCudaErrors(cudaMemcpy(address, host_x, data_size,cudaMemcpyHostToDevice));

////    /* Launch the kernel for `address` */
////    kernel<<<1,4>>>(address);

////    checkCudaErrors(cudaDeviceSynchronize());
////    getLastCudaError("wtf!");

////    checkCudaErrors(cudaMemcpyFromSymbol(host_x, dev_x, data_size, 0, cudaMemcpyDeviceToHost));

////    for (int i=0; i< 4; i++){
////        printf("%d\n", host_x[i]);
////    }
////    return 0;
////}
