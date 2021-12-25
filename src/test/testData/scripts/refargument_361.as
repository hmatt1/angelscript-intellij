void Test()
{
  int a = 0;
  float b = 0.0f;
  int c = 45;
  float d = 4.0f;
  TestNativeRefArgOut(a,b,c,d);
  Assert(a == 10);
  Assert(b > 3.13f && b < 3.15f);
}
