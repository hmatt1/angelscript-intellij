class testclass
{
	testclass()
	{
		myCompare(1,3);
	}
}
void main()
{
	testclass test;
}
bool myCompare(int a, int b)
{
	testclass @testc = @testclass();
	return a < b;
}
