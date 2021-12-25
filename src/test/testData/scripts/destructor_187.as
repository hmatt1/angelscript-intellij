class T
{
   ~T() {Print("once");@g = @this;}
}
T @g;
void Test()
{
   T a;
}
