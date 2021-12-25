class Test
{
   int a;
   bool b;
};
void TestStruct()
{
   Test a;
   a.a = 3;
   a.b = false;
   Test b;
   Test @c = @a;
   a = b;
   TestStruct2(c);
   Test[] d(1);
   d[0] = a;
   a = Test();
}
void TestStruct2(Test a)
{
}
