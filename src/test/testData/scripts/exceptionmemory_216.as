void Test1()
{
  Object a;
  RaiseException();
}
void Test2()
{
  RaiseException();
  Object a;
}
void Test3()
{
  int a;
  Func(Object());
}
void Func(Object a)
{
  Object b;
  RaiseException();
}
void Test4()
{
  Object a = SuspendObj();
}
void Test5()
{
  Object a = ExceptionObj();
}
void Test6()
{
  Object a(1);
}
