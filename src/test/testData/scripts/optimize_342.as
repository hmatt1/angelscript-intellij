void add(int) {}
void func()
{
  for( int n = -1; n < 2; ++n )
    switch( n )
    {
    case 0:
      add(0);
      break;
    case -1:
      add(-1);
      break;
    default:
      add(255);
      break;
    }
}
