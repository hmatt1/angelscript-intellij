class Test
{
  int value;
// Define the operators
  Test opAdd(const Test &in o) const
  {
    Test t;
    t.value = value + o.value;
    return t;
  }
  Test opMul_r(int o) const
  {
    Test t;
    t.value = o * value;
    return t;
  }
  Test @opShl(int o)
  {
    value += o;
    return this;
  }
}
void main()
{
  Test c;
  c.value = 1;
  assert( (c + c).value == 2 );
  assert( c.opAdd(c).value == 2 );
  assert( (3 * c).value == 3 );
  assert( c.opMul_r(3).value == 3 );
  c << 1 << 2 << 3;
  assert( c.value == 7 );
}
