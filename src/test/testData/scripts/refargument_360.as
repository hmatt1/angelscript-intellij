void Test()
{
  string b;
  Testref(b);
  Assert(b == "test");
  string[] a(1);
  Testref(a[0]);
  Assert(a[0] == "test");
}
void Testref(string &inout s)
{
  s = "test";
}
