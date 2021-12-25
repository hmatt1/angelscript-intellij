class Test
{
  int get_prop() property { return _prop; }
  void set_prop(int v) property { _prop = v; }
  int _prop;
}
void main1()
{
  Test t;
  t.set_prop(42);
  assert( t.get_prop() == 42 );
}
void main2()
{
  Test t;
  t.prop = 42;
  assert( t.prop == 42 );
}
