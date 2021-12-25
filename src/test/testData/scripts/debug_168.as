void func(string@ &out output)
{
  debugCall();
  assert( output == 'test' );
}