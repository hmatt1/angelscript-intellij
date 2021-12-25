class Test
{
  uint get_p() property {return 0;}
  float get_p() property {return 0;}
  void set_s(float) property {}
  void set_s(uint) property {}
}
void main()
{
  Test t;
  t.p;
  t.s = 0;
}
