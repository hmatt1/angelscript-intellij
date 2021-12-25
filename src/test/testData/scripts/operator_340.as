class Test
{
  int value;
// Define the operators
  Test opNeg() const
  {
    Test t;
    t.value = -value;
    return t;
  }
  Test opCom()
  {
    Test t;
    t.value = ~value;
    return t;
  }
  void opPostInc()
  {
    value++;
  }
  void opPreDec()
  {
    --value;
  }
}
void main()
{
  Test a;
  a.value = 1;
  assert( (-a).value == -1 );
  assert( (~a).value == int(~1) );
  a++;
  assert( a.value == 2 );
  --a;
  assert( a.value == 1 );
}
