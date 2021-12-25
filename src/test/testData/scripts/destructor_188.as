class T
{
   ~T() {Print("member");}
}
class M
{
   T m;
}
void Test()
{
   M a;
}
