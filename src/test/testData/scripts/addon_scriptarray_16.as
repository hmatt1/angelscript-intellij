array<int> f;
f.reserve(10);
for( uint n = 0; n < 10; n++ )
  f.insertAt(n, n);
Assert( f.length() == 10 );
