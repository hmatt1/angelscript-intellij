class myclass
{
  myclass()
  {
    print("Default constructor");
    this.value = 1;
  }
  myclass(int a)
  {
    print("Constructor("+a+")");
    this.value = 2;
  }
  void method()
  {
    this.value = 3;
  }
  void method2()
  {
    this.method();
  }
  int value;
};
void Test()
{
  myclass c;
  Assert(c.value == 1);
  myclass d(1);
  Assert(d.value == 2);
  c = myclass(2);
  Assert(c.value == 2);
}
