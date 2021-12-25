vector3 TestVector3()
{
  vector3 v;
  v.x=1;
  v.y=2;
  v.z=3;
  return v;
}
vector3 TestVector3Val(vector3 v)
{
  return v;
}
void TestVector3Ref(vector3 &out v)
{
  v.x=1;
  v.y=2;
  v.z=3;
}
