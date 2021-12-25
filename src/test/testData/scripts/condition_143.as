void Test()
{
  int a = 0;
  Data *v = 0;
  Data *p;
  p = a != 0 ? v : 0;
  p = a == 0 ? 0 : v;
}
