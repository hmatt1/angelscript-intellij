string g;
string &Test(int s)
{
  return g;
}
string &Test2()
{
  return Test(1);
}
