void test()
{
   assert(abs(-1) == 1);
   assert(sin(0) == 0);
   assert(cos(0) == 1);
   assert(tan(0) == 0);
   assert(asin(0) == 0);
   assert(acos(1) == 0);
   assert(atan(0) == 0);
   atan2(1,1);
   sinh(0);
   cosh(0);
   tanh(0);
   assert(fraction(1.1f) >= 0.000009f &&
          fraction(1.1f) <= 0.100001f);
   log(0);
   log10(0);
   pow(1,1);
   sqrt(1);
   ceil(1.1f);
   floor(1.1f);
}
