class CBar
{
 CBar(int a) {}
};
void func()
{
  CBar a;
  CBar b(1);
  CBar c = CBar(1);
  b = b;
  CBar d(CBar());
};
