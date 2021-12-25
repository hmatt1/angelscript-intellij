const uint8	mask0=1;
const uint8	mask1=1<<1;
const uint8	mask2=1<<2;
const uint8	mask3=1<<3;
const uint8	mask4=1<<4;
const uint8	mask5=1<<5;
void BitsTest(uint8 b)
{
  Assert((b&mask4) == 0);
}
