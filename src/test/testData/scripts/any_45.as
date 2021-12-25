class s
{
  any a;
};
void TestAny()
{
  any a;
  a.store(@a);
  any b,c;
  b.store(@c);
  c.store(@b);
  any[] d(1);
  d[0].store(@d);
  s e;
  e.a.store(@e);
}
// Don't allow a ref to const in retrieve()
