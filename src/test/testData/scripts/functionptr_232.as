funcdef void FUNC();
FUNC @func;
class Class
{
  void func() {}
  void method()
  {
    func();
  }
  void func2() {}
  void method2()
  {
    FUNC @func2;
    func2();
  }
}
