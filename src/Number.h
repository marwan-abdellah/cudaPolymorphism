#ifndef NUMBER_H
#define NUMBER_H

#include <Shared.hh>

class Number
{
public:
    HOST_DEVICE
    Number( );

public:
    HOST_DEVICE
    virtual int getNumber( ) const = 0;
};

#endif // NUMBER_H
