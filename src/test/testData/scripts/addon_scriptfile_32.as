file f;
int r = f.open("scripts/TestExecuteScript.as", "r");
if( r >= 0 ) {
  assert( f.getSize() > 0 );
  string s1 = f.readString(10000);
  assert( s1.length() == uint(f.getSize()) );
  f.close();
  f.open('scripts/TestExecuteScript.as', 'r');
  string s2;
  while( !f.isEndOfFile() )
  {
    string s3 = f.readLine();
    s2 += s3;
  }
  assert( s1 == s2 );
  f.close();
}
