class s
{
  string @a;
};
void TestAny()
{
  const s a;
  any c;
  c.retrieve(@a.a);
}
