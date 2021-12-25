class Test
{
  string @get_s() property { return 'test'; }
  void set_s(const string &in) property {}
}
void func()
{
  Test t;
  string s = t.s;
  t.s = s;
}
