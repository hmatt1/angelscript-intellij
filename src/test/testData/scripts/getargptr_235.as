int test(int a, string b, string @c, float &in d)
{
  assert(a == 3);
  assert(b == "tst");
  assert(c == "42");
  assert(d == 3.14f);
  return 107;
}
string test2()
{
  return "tst";
}
