#ifndef ALLOCATOR_H
#define ALLOCATOR_H

#include <Shared.hh>
#include <Number.h>
#include <One.h>
#include <Two.h>

template < class T >
class Allocator
{
public:
    HOST
    Allocator( const u_int64_t N );

    HOST
    T** getObjects( ) const;

private:
    T** _objects;
};

#endif // ALLOCATOR_H
