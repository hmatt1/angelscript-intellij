class Test
{
   int[] a;
};
class Test2
{
   Test2@[][] a;
};
void TestArrayInStruct()
{
   Test a;
   a.a.resize(10);
   Test2 b;
   b.a.resize(1);
   b.a[0].resize(1);
   // Circular reference
   @b.a[0][0] = b;
}
