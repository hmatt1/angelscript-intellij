uint16 Z1;
uint8 b1 = 2;
uint8 b2 = 2;
//Using '+'
Z1 = (b1 & 0x00FF) + ((b2 << 8) & 0xFF00);
b1 = Z1 & 0x00FF;
b2 = (Z1 >> 8) & 0x00FF;
assert( b1 == 2 && b2 == 2 );
//Using '|'
Z1 = (b1 & 0x00FF) | ((b2 << 8) & 0xFF00);
b1 = Z1 & 0x00FF;
b2 = (Z1 >> 8) & 0x00FF;
assert( b1 == 2 && b2 == 2 );
