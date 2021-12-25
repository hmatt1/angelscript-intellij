class A
{
  string@ s;
};
void TestHandleInStruct()
{
  A a;
  Assert(@a.s == null);
  a = a;
  @a.s = 'Test';
  Assert(a.s == 'Test');
}
