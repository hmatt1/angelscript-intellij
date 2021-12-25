class Test
{
  int[] get_s() const property { int[] a(1); a[0] = 42; return a; }
}
void func()
{
  Test t;
  assert( t.s[0] == 42 );
}
