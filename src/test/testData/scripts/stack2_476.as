void testoutparm()
{
  string a, b;
  complex3(complex(a));
  complex(a) = b;
  complex2() = b;
  if( complex(a) == b ) {}
  if( complex3(a) == 2 ) {}
}
