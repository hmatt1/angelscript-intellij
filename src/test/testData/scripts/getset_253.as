class Test
{
  string@ get_s() property {return _s;}
  void set_s(string @n) property {@_s = @n;}
  string@ _s;
}
void func()
{
  Test t;
  string s = 'hello';
  @t.s = @s;
  assert(t.s is s);
  t.s = 'other';
  assert(s == 'other');
}
