class T
{
   ~T() {Print("array");}
}
void Test()
{
  T[] a;
  a.resize(1);
  T@[] b;
  b.resize(1);
  @b[0] = @T();
}
