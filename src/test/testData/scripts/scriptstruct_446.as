class B
{
   A a;
   string b;
   int c;
};
void Test()
{
  B a, b;
  b.a.a = 5;
  b.b = "Test";
  b.c = 6;
  a = b;
  b.a.a = 6;
  b.b = "1";
  b.c = 2;
  Assert(a.a.a == 5);
  Assert(a.b == "Test");
  Assert(a.c == 6);
}
class A
{
   uint a;
};
