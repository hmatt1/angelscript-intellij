class Test
{
  int get_p() property { return 42; }
  int get_c() const property { return 42; }
  void set_s(int) property {}
}
void func()
{
  const Test @t = @Test();
  assert( t.p == 42 );
  assert( t.c == 42 );
  t.s = 42;
}
