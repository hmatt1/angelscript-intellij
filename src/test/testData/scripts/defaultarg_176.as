void func(int b, const string &in a = 'default')
{
  if( b == 0 )
    assert( a == 'default' );
  else
    assert( a == 'test' );
}
void main()
{
  func(0);
  func(0, 'default');
  func(1, 'test');
}
