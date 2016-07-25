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
