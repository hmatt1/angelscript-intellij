class T
{
  T(int a, int b = 25)
  {
    assert(a == 10);
    assert(b == 25);
  }
}
T g(10);
void main()
{
  T(10);
  T l(10);
}
