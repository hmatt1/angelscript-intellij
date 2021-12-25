class MyType
{
   int val;
   void TestConst() const
   {
      assert(val == 5);
   }
}
void Func(const MyType &in a)
{
   a.TestConst();
}
