class Test
{
  uint get_p() property {return 0;}
  void set_p(uint) property {}
  void test()
  {
    p = 0;
    int a = p;
  }
}
void func()
{
  Test @a = Test();
  a.p = 1;
  int b = a.p;
}
