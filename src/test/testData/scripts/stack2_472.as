void testargs()
{
  t("a","b");
  string c; int d = 0;
  s(c, d);
}
void t(string, string)
{}
void s(string &out a, int &out b)
{ a = ""; b = 1; }
