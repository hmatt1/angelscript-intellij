MyGame @global;
class MyGame
{
// Cause GC to keep a reference (for testing purposes)
  MyGame@ ref;
  MyGame@[] array;
}
any@ CreateInstance()
{
  any res;
  MyGame obj;
  @global = @obj;
  res.store(@obj);
  return res;
}
