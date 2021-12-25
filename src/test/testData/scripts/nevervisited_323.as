void TestNeverVisited3()
{
  int a = 0;
  while( a++ < 10 )
  {
    if( true ) continue;
    a--;
  }
}
