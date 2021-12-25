class Test
{
  float get_prop() property { return 1.0f; }
}
void main1()
{
  Test t;
  float f = t.prop * 1;
  f = (t.prop) + 1;
  10 / t.prop;
  -t.prop;
}
