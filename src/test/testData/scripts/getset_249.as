class Test
{
  uint get_p() property {return 0;}
  void set_p(uint) property {}
}
void main()
{
  Test t;
  t.p++;
  --t.p;
}
