class T
{
   ~T() {Print("garbage");}
   T @m;
}
void Test()
{
   T a;
}
