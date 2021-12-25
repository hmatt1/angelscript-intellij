const int a = 1;
const int8 b = 2;
void _switch2()
{
  const uint c = 3;
  for( uint8 n = 0; n <= 5; ++n )
  {
    switch( n )
    {
    case 5: Log("5"); break;
    case 4: Log("4"); break;
    case c: Log("3"); break;
    case b: Log("2"); break;
    case a: Log("1"); break;
    default: Log("d"); break;
    }
  }
  Log("\n");
  myFunc127(127);
  myFunc128(128);
}
const uint8 c127 = 127;
void myFunc127(uint8 value)
{
  if(value == c127)
    Log("It is the value we expect\n");

  switch(value)
  {
    case c127:
      Log("The switch works\n");
      break;
    default:
      Log("I didnt work\n");
      break;
  }
}
const uint8 c128 = 128;
void myFunc128(uint8 value)
{
  if(value == c128)
    Log("It is the value we expect\n");

  switch(value)
  {
    case c128:
      Log("The switch works\n");
      break;
    default:
      Log("I didnt work\n");
      break;
  }
}
