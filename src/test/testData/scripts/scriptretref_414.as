string g;
string &Test()
{
  return g;
}
string &Test2()
{
  return Test();
}
