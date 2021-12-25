class myclass
{
	double opPow(int x)
	{
		return val ** x;
	}
	double opPow(double x)
	{
		return val ** x;
	}
	double opPow_r(double x)
	{
		return x ** val;
	}
	myclass& opPowAssign(double x)
	{
		val **= x;
       return this;
	}
	double val;
};

void test_pow()
{
	assert(3 ** 2 == 9);
   assert(9.0 ** 0.5 == 3.0);
   assert(9 ** 0.5 == 3.0);
   assert(2.5 ** 2 == 6.25);

   double  a = 2.5;
   int     b = 2;
   uint    c = 3;
   float   d = 0.5;
   int64   e = 4;

   assert(c ** b == 9);
   assert(c ** 2 == 9);
   assert(e ** d == 2.0);
   assert(a ** c == 15.625);
   assert(a ** b == 6.25);
   assert(e ** 30 == 1152921504606846976);

	int z = 0;
   int o = 1;

   assert(z ** o == z);
   assert(o ** z == 1);
   assert(a ** 0 == 1.0);
   assert(a ** 1 == a);
   assert(b ** c * b == b ** (c + 1));
   assert(c ** -o == 0);
   assert(double(e) ** -2 >= 0.062499 &&
          double(e) ** -2 <= 0.062501);

   b **= c;
   assert(b == 8);
   myclass obj;
   obj.val = 4.0;
   assert(obj ** 3 == 64.0);
   assert(obj ** 3.0 == 64.0);
   assert(3.0 ** obj == 81.0);
   obj **= 3;
   assert(obj.val == 64.0);
}

void test_overflow1()
{
   double x = 1.0e100;
   x = x ** 6;
}

void test_overflow2()
{
   int x = 3;
   x = x ** 21;
}

void test_overflow3()
{
   double x = 1.0e100;
   x = x ** 6.0;
}
