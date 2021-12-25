int[] my_array(5);
int index=3;
void my_function(int arg1, int arg2=my_array[index])
{
  assert( arg2 == 42 );
}
void main()
{
  my_array[index] = 42;
  my_function(1);
}
