void test_intdiv()
{
   assert(1/2 == 1.0/2.0);

   int a = 3;
   int b = 4;
   int c = int(a / b);
   double d = a / b;

   assert(3 / 4 == 3.0 / 4.0);
   assert(c == 0);
   assert(d == double(a) / double(b));
}
