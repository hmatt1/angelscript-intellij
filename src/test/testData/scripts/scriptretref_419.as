string g;
string &Test(int &out s)
{
  return g;
}
string &Test2()
{
  int s;
  return Test(s);
}
