int b;
class myclass
{
  void func()
  {
     int a = 3;
     this.a = a;
     test();
  }
  void test()
  {
     b = a;
  }
  int a;
  int b;
}
void test()
{
   b = 9;
   myclass m;
   m.func();
   Assert(b == 9);
   Assert(m.a == 3);
   Assert(m.b == 3);
}
