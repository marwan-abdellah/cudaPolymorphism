#include <Allocator.h>

template < class T >
__global__
void __kernel__allocateT( T** objects, const int N )
{
    int idx = threadIdx.x + blockDim.x * blockIdx.x;
    if( idx < N )
    {
        objects[idx] = new T( );
    }
}

template < class T >
Allocator< T >::Allocator( const u_int64_t N )
{
    cudaMalloc(( void** ) &_objects, sizeof( T* ) * N );
    __kernel__allocateT <<< 1, N >>> (_objects, N );
}

template < class T >
T** Allocator< T >::getObjects( ) const
{
    return _objects;
}

template class Allocator< One >;
template class Allocator< Two >;

