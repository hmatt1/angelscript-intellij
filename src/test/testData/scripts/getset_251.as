class Test
{
  uint get_p() property {return 0;}
  void set_p(uint) property {}
}
void func()
{
  Test a();
  byVal(a.p);
  inArg(a.p);
  outArg(a.p);
}
void byVal(int v) {}
void inArg(int &in v) {}
void outArg(int &out v) {}
