class TestObj1
{
  TestObj1(TestObj2 a) {}
}
class TestObj2
{
  TestObj2(int a) {}
}
void Func(TestObj1 obj) {}
void Test()
{
  Func(2);
}
