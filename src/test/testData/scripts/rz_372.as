
MyGame @global;
class MyGame
{
}
any@ CreateInstance()
{
  any res;
  MyGame obj;
  @global = @obj;
  res.store(@obj);
  return res;
}
