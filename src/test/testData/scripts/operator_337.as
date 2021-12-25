class Test
{
  int value;
// Define the operators ==, !=, <, <=, >, >=
  int opCmp(const Test &in o) const
  {
    return value - o.value;
  }
// The operator can be overloaded for different types
  int opCmp(int o)
  {
    return value - o;
  }
// opCmp that don't return int are ignored
  bool opCmp(float o)
  {
    return false;
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
  assert( a.opCmp(b) == 0 );
  assert( a == 0 );
  assert( 0 == a );
  assert( a == 0.1f );
  assert( a != c );
  assert( a != 1 );
  assert( 1 != a );
  assert( a.opCmp(c) != 0 );
  assert( a == func() );
  assert( a == funcH() );
  assert( func() == a );
  assert( funcH() == a );
  assert( a < 10 );
  assert( 10 > a );
  assert( c > 0 );
  assert( 0 < c );
}
