class Test
{
  void set_prop(int v) property { _prop = v; }
  int _prop;
}
void main1()
{
  Test t;
  t.prop += 42;
}
