class Val { int opNeg() const { return -1; } }
class Test
{
  Val get_s() const property {return Val();}
}
void func()
{
  Test t;
  assert( -t.s == -1 );
}
