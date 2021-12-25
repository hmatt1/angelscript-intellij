class Test
{
  uint get_g() property {return 0;}
  void set_s(float) property {}
}
void main()
{
  Test t;
  t.g = 0;
  t.s + 1;
}
