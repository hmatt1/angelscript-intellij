void TestScript()
{
  double a = 1.2345;
  TestSFloat(a);
  float b = 1.2345f;
  TestSDouble(b);
}
void TestSFloat(float a)
{
  Assert(a == 1.2345f);
}
void TestSDouble(double a)
{
  Assert(a == double(1.2345f));
}
