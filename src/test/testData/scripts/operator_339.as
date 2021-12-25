class Test
{
  int value;
// Define the operators
  Test@ opAssign(const Test &in o)
  {
    value = o.value;
    return this;
  }
  Test@ opMulAssign(int o)
  {
    value *= o;
    return this;
  }
}
void main()
{
  Test a,c;
  a.value = 0;
  c.value = 1;
  a = c;
  assert( a.value == 1 );
  a.value = 2;
  a *= 2;
  assert( a.value == 4 );
}
