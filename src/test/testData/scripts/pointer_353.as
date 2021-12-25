void Test()
{
  ObjectInstance*[] c(5);
  ObjectType *tbase = CreateObjectType("base");
  uint i;
  for( i = 0; i < 5; ++i )
  {
    c[i] = CreateObjectInstance(tbase);
    c[i]->function();
    c[i]->val = 0;
  }
  ObjectInstance *obj = c[0];
  FunctionOnObject(c[0]);
}
