void TestArrayHandle2()
{
   string[] s(10);
   Append(s);

   string[]@ sh = createArray();
   double d1 = atof(sh[0]);
   double d2 = atof(s[0]);
}
void Append(string[]@ s)
{
   for( uint n = 0; n < s.length(); n++ )
      s[n] += ".";
}
string[]@ createArray()
{
   return string[](2);
}
