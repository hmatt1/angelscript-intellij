interface intf
{
    void test();
}
class myclass : intf, intf
{
}
interface nointf {}
void test(intf &i)
{
   intf a;
   intf@ b, c;
   b = c;
   myclass d;
   nointf@ e = d;
   myclass@f = b;
}
