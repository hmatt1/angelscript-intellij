interface intf1
{
  void Test1();
}
interface intf2
{
  void Test2();
}
interface intf3
{
  void Test3();
}
class clss : intf1, intf2
{
  void Test1() {}
  void Test2() {}
}