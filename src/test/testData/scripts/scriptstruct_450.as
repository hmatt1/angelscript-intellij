class A
{
  A@ next;
};
class B
{
  D@ next;
};
class C
{
  B b;
};
class D
{
  C c;
};
void TestHandleInStruct2()
{
// Simple circular reference
  A a;
  @a.next = a;
// More complex circular reference
  D d1;
  D d2;
  @d1.c.b.next = d2;
  @d2.c.b.next = d1;
}
