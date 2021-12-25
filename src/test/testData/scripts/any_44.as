string g_str = "test";
any g_any(@g_str);
void TestAny()
{
  any a, b;
  string str = "test";
  b.store(@str);
  a = b;
  string @s;
  a.retrieve(@s);
  Assert(s == str);
  Assert(@s == @str);
  int[]@ c;
  a.retrieve(@c);
  Assert(@c == null);
  a = any(@str);
  a.retrieve(@s);
  Assert(s == str);
  any d(@str);
  d.retrieve(@s);
  Assert(s == str);
  g_any.retrieve(@s);
  Assert(@s == @g_str);
// If the container holds a handle to a const object, it must not copy this to a handle to a non-const object
  const string @cs = str;
  a.store(@cs);
  a.retrieve(@s);
  Assert(@s == null);
  @cs = null;
  a.retrieve(@cs);
  Assert(@cs == @str);
// If the container holds a handle to a non-const object, it should be able to copy it to a handle to a const object
  @s = str;
  a.store(@s);
  a.retrieve(@cs);
  Assert(@cs == @str);
}
// Test circular references with any
