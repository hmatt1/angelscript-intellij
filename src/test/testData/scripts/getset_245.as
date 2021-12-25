class Test
{
  uint get_prop() property { return 1; }
}
void main1()
{
  Test t;
  t.prop << t.prop;
  t.prop & t.prop;
  ~t.prop;
}
