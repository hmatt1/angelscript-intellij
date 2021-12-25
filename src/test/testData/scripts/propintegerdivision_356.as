void test_intdiv()
{
   assert(1/2 == 0);

   int a = 3;
   int b = 4;
   int c = a / b;
   double d = a / b;

   assert(c == 0);
   assert(d == 0.0);
}
