int g;
void TestArgRef()
{
  int a = 0;
  int[] b;
  Obj o;
  TestArgRef1(a);
  TestArgRef1(g);
  TestArgRef1(b[0]);
  TestArgRef1(o.v);
  string s;
  TestArgRef2(s);
}
void TestArgRef1(int &in arg)
{
}
void TestArgRef2(string &in str)
{
}
