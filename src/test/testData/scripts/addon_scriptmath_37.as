complex TestComplex()
{
  complex v;
  v.r=1;
  v.i=2;
  return v;
}
complex TestComplexVal(complex v)
{
  return v;
}
void TestComplexRef(complex &out v)
{
  v.r=1;
  v.i=2;
}
