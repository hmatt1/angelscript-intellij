string g_str = "test";
void TestSuspend()
{
  string str = "hello";
  while( true )
  {
    string a = str + g_str;
    Suspend();
    loopCount++;
  }
}
