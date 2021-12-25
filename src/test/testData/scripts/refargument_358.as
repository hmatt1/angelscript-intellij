void TestObjHandle(refclass &in ref)
{
   float r;
   test2(r);
   Assert(ref.id == int(0xdeadc0de));
   test(ref);
   test3(r);
   Assert(r == 1.0f);
}
void test(refclass &in ref)
{
   Assert(ref.id == int(0xdeadc0de));
}
void test2(float &out ref)
{
}
void test3(float &out a)
{
   a = 1.0f;
}
