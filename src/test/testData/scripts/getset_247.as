class Test
{
  uint get_p() property {return 0;}
  void set_p(float) property {}
}
void main()
{
  Test t;
  t.p;
}
