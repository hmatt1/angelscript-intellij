class Val { int val; }
class Test
{
  Val get_s() const property { Val v; v.val = 42; return v;}
}
void func()
{
  Test t;
  assert( t.s.val == 42 );
}
