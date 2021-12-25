class Test
{
  int value;
// Define the operator ==
  bool opEquals(const Test &in o) const
  {
    return value == o.value;
  }
// The operator can be overloaded for different types
  bool opEquals(int o)
  {
    return value == o;
  }
// opEquals that don't return bool are ignored
  int opEquals(float o)
  {
    return 0;
  }
}
Test func()
{
  Test a;
  a.value = 0;
  return a;
}
Test @funcH()
{
  Test a;
  a.value = 0;
  return @a;
}
void main()
{
  Test a,b,c;
  a.value = 0;
  b.value = 0;
  c.value = 1;
  assert( a == b );
  assert( a.opEquals(b) );
  assert( a == 0 );
  assert( 0 == a );
  assert( a == 0.1f );
  assert( a != c );
  assert( a != 1 );
  assert( 1 != a );
  assert( !a.opEquals(c) );
  assert( a == func() );
  assert( a == funcH() );
  assert( func() == a );
  assert( funcH() == a );
}
