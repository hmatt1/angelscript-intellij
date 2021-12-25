class SomeClassA
{
	int A;

	~SomeClassA()
	{
		print('destruct');
	}
}
class SomeClassB
{
	SomeClassA@ nullptr;
	SomeClassB(SomeClassA@ aPtr)
	{
		this.nullptr.A=100; // Null pointer access. After this class a is destroyed.
	}
}
void test()
{
	SomeClassA a;
	SomeClassB(a);
}
