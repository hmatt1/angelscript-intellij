  int get_arr(int i) property { arr.resize(5); return arr[i]; }
  void set_arr(int i, int v) property { arr.resize(5); arr[i] = v; }
  array<int> arr;
void main()
{
  arr[0] = 42;
  assert( arr[0] == 42 );
  arr[1] = 24;
  assert( arr[1] == 24 );
}
