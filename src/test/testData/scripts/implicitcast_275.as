int x = 1;
class A
{
	int val;
	A(int x)
	{
		val = x;
	}
	int opImplConv()
	{
		return val;
	}
}
A myA(5);
void main()
{
	assert(myA + (x + 1) == myA + x + 1);
}
