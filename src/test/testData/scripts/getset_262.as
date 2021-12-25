class Test
{
  int get_c() property { return 41; }
  int get_c() const property { return 42; }
  void set_c(int v) property { assert( v == 41 ); }
  void set_c(int v) const property { assert( v == 42 ); }
}
void func()
{
  Test @s = @Test();
  const Test @t = @s;
  assert( s.c == 41 );
  assert( t.c == 42 );
  s.c = 41;
  t.c = 42;
}
