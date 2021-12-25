interface ITest
{
}
class Test : ITest
{
	ITest@[] arr;
	void Set(ITest@ e)
	{
		arr.resize(1);
		@arr[0]=e;
	}
}
void main()
{
	Test@ t=Test();
	t.Set(t);
}
