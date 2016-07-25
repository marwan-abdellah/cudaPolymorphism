#include "One.h"

HOST_DEVICE
One::One( int number )
{
    _number = number;
}

HOST_DEVICE
int One::getNumber( ) const
{
    return _number;
}


