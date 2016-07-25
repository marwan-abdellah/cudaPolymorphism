#ifndef TWO_H
#define TWO_H

#include <Number.h>

class Two : public Number
{
public:
    HOST_DEVICE
    Two( int number = 2 );

public:
    HOST_DEVICE
    int getNumber( ) const;

private:
    int _number;
};

#endif // TWO_H
