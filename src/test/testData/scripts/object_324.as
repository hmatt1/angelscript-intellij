void TestObject()
{
  Object a = TestReturn();
  a.Set(1);
  TestArgVal(a);
  Assert(a.Get() == 1);
  TestArgRef(a);
  Assert(a.Get() != 1);
  TestProp();
  TestSysArgs();
  TestSysReturn();
  TestGlobalProperty();
}
Object TestReturn()
{
  return Object();
}
void TestArgVal(Object a)
{
}
void TestArgRef(Object &out a)
{
  a = Object();
}
void TestProp()
{
  Object a;
  a.val = 2;
  Assert(a.Get() == a.val);
  Object2 b;
  b.obj = a;
  Assert(b.obj.val == 2);
}
void TestSysReturn()
{
  // return object
  // by val
  Object a;
  a = TestReturnObject();
  Assert(a.val == 12);
  // by ref
  a.val = 12;
  TestReturnObjectRef() = a;
  a = TestReturnObjectRef();
  Assert(a.val == 12);
}
void TestSysArgs()
{
  Object a;
  a.val = 12;
  TestSysArgRef(a);
  Assert(a.val == 2);
  a.val = 12;
  TestSysArgVal(a);
  Assert(a.val == 12);
}
void TestGlobalProperty()
{
  Object a;
  a.val = 12;
  TestReturnObjectRef() = a;
  a = obj;
  obj = a;
}
