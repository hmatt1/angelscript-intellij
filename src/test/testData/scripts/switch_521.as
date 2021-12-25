void _switch()
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
    case 0x5:
      add(5);
      break;
    case 0xF:
      add(15);
      break;
    default:
      add(255);
      break;
    }
}
