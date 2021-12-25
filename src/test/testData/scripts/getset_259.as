int direction;
void set_direction(int val) property { direction = val; }
void test_set()
{
  direction = 9;
}
void test_get()
{
  assert( direction == 9 );
}
