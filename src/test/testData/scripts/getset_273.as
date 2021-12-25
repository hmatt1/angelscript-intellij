class CTest
{
  CTest() { _arr.resize(5); }
  int get_arr(int i) property { return _arr[i]; }
  void set_arr(int i, int v) property { _arr[i] = v; }
  private array<int> _arr;
  void test()
  {
    arr[0] = 42;
    assert( arr[0] == 42 );
    arr[1] = 24;
    assert( arr[1] == 24 );
  }
}
void main()
{
  CTest s;
  s.arr[0] = 42;
  assert( s.arr[0] == 42 );
  s.arr[1] = 24;
  assert( s.arr[1] == 24 );
  s.test();
}
