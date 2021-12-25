class CTest
{
  CTest() { arr.resize(5); }
  int get_opIndex(int i) const property { return arr[i]; }
  void set_opIndex(int i, int v) property { arr[i] = v; }
  array<int> arr;
}
class CTest2
{
  CTest2() { arr.resize(1); }
  CTest @get_opIndex(int i) const property { return arr[i]; }
  void set_opIndex(int i, CTest @v) property { @arr[i] = v; }
  array<CTest@> arr;
}
void main()
{
  CTest s;
  s[0] = 42;
  assert( s[0] == 42 );
  s[1] = 24;
  assert( s[1] == 24 );
  CTest2 t;
  @t[0] = s;
  assert( t[0] is s );
}
