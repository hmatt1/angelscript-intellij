uint8 gb;
uint16 gw;
void Test()
{
  gb = ReturnByte(1);
  Assert(gb == 1);
  gb = ReturnByte(0);
  Assert(gb == 0);
  gw = ReturnWord(1);
  Assert(gw == 1);
  gw = ReturnWord(0);
  Assert(gw == 0);
}
