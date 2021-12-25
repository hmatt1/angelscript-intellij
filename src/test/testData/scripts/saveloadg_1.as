import void Test() from 'DynamicModule';
OBJ g_obj;
array<A@> g_a = {A(),A()};
array<string> g_s = {'a','b','c'};
A @gHandle;
funcdef void func_t(OBJ, float, A @);
void func(OBJ o, float f, A @a) {}
enum ETest {}
void main()
{
  Test();
  TestStruct();
  TestArray();
  GlobalCharArray.resize(1);
  string s = ARRAYTOHEX(GlobalCharArray);
  func_t @f = func;
  f(OBJ(), 1, A());
}
void TestObj(OBJ &out obj)
{
}
void TestStruct()
{
  A a;
  a.a = 2;
  A@ b = @a;
}
void TestArray()
{
  A[] c(3);
  int[] d(2);
  A[]@[] e(1);
  @e[0] = @c;
}
class A
{
  int a;
  ETest e;
};
void TestHandle(A @a)
{
}
interface MyIntf
{
  void test();
}
class MyClass : MyIntf
{
  array<int> arr = {1000,200,40,1};
  int sum = arr[0] + arr[1] + arr[2] + arr[3];
  void test() {number = sum;}
}