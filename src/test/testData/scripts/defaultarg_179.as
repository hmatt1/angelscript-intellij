void func(uint8 a, string b = 'b')
{
  assert( a == 97 );
  assert( b == 'b' );
}
void main()
{
  uint8 a;
  func((a = 'a'[0]));
}
