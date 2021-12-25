void TestArrayHandle()
{
   string[]@[]@ a;
   string[]@[] b(2);
   Assert(@a == null);
   @a = @string[]@[](2);
   Assert(@a != null);
   Assert(@a[0] == null);
   string@[] c(10);
   Assert(c.length() == 10);
   Assert(g.length() == 2);
}
string@[] g(2);
