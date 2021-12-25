class Test
{
  string get_s() property {return _s;}
  void set_s(string n) property {_s = n;}
  string _s;
}
void func()
{
  Test t;
  t.s = 'hello';
  assert(t.s == 'hello');
  assert(t.s.length() == 5);
}
