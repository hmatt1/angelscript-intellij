class T
{
   ~T() {Print("destruct");}
}
T glob;
void Test()
{
  T local;
}
