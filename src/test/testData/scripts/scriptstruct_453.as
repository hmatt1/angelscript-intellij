class A
{
   int[] a;
};
void Test()
{
   const A a;
   // Should not compile
   a.a[0] = 23;
}
