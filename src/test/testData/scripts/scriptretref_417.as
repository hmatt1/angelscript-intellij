Val @g;
class Cleanup
{
  ~Cleanup()
  {
    @g = null;
  }
}
class Val { string v; }
string &Test()
{
  Cleanup c();
  @g = Val();
  g.v = 'test';
  return g.v;
}
