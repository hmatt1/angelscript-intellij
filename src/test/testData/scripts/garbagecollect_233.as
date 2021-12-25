const int number_of_instances=50;
int destroyed_instances=0;
class dummy
{
  dummy@ other_dummy;
  dummy()
  {
    @other_dummy=this;
  }
  ~dummy()
  {
    destroyed_instances+=1;
    if(destroyed_instances==number_of_instances)
    {
      print('Destroying last class' + 'The last class instance is now being destroyed after having existed for ' + 0.0f + ' milliseconds.');
      exit();
    }
  }
}
void main()
{
  generate_garbage();
  while( destroyed_instances < number_of_instances )
  {
    yield();
  }
}
void generate_garbage()
{
  dummy[] dummy_list(number_of_instances);
}
