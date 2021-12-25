void main()
{
  AppVal a,b,c;
  a.value = 0;
  b.value = 0;
  c.value = 1;
  assert( a == b );
  assert( a.opEquals(b) );
  assert( a != c );
  assert( !a.opEquals(c) );
  assert( a == GetAppValRef(b) );
  assert( b == c );
  b.value = 0;
  assert( GetAppValRef(b) == a );
  assert( c == b );
  assert( AppVal() == a );
}
