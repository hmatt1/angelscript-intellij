array<uint> a, b = {0,1,2,3};
a.reserve(10);
a = b;
assert( a.length() == b.length() );
assert( a.length() == 4 );
for( uint n = 0; n < a.length(); n++ )
  assert( a[n] == n );
