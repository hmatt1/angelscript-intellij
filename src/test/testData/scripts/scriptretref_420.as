string g;
string &Test(const string &in s)
{
  return g;
}
string &Test2()
{
  string s;
  return Test(s);
}
