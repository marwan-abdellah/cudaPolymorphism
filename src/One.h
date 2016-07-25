#ifndef ONE_H
#define ONE_H

#include <Number.h>

class One : public Number
{
public:
    HOST_DEVICE
    One( int number = 1 );

public:
    HOST_DEVICE
    int getNumber( ) const;

private:
    int _number;
};

#endif // ONE_H
