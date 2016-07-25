#include "Two.h"

HOST_DEVICE
Two::Two(int number )
{
    _number = number;
}

HOST_DEVICE
int Two::getNumber( ) const
{
    return _number;
}
