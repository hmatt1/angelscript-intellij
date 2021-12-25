interface myintf
{
   void test();
}
class myclass : myintf, intf2, appintf
{
   myclass() {this.str = "test";}
   void test() {Assert(this.str == "test");}
   int func2(const string &in i)
   {
      Assert(this.str == i);
      return 0;
   }
   string str;
}
interface intf2
{
   int func2(const string &in);
}
void test()
{
   myclass a;
   myintf@ b = a;
   intf2@ c;
   @c = a;
   a.func2("test");
   c.func2("test");
   test(a);
}
void test(appintf@i)
{
   i.test();
}
