void Test()
{
   int[] arr = {0};
   TestRefInt(arr[0]);
   Assert(arr[0] == 23);
   int a = 0;
   TestRefInt(a);
   Assert(a == 23);
   string[] sa = {""};
   TestRefString(sa[0]);
   Assert(sa[0] == "ref");
   string s = "";
   TestRefString(s);
   Assert(s == "ref");
}
void TestRefInt(int &ref)
{
   ref = 23;
}
void TestRefString(string &ref)
{
   ref = "ref";
}
