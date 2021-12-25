  int a = 1;
  bool correct = false;
  if( a )
    correct = true;
  assert( correct );
  correct = false;
  if( bool(a) )
    correct = true;
  assert( correct );
  correct = false;
  if( a && true )
    correct = true;
  assert( correct );
  correct = false;
  if( !a == false )
    correct = true;
  assert( correct );
