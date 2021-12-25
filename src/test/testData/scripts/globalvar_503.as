float f = 2;
string str = 'test';
void TestGlobalVar()
{
  float a = f + g_f;
  string s = str + g_str;
  g_f = a;
  f = a;
  g_str = s;
  str = s;
}
