bool TestSort()
{
	array<int> A = {1, 5, 2, 4, 3};
	array<int> B = {1, 5, 2, 4, 3};
	A.sortAsc();
	B.sortDesc();
	return
		A[0] == 1 && A[1] == 2 && A[2] == 3 && A[3] == 4 && A[4] == 5 &&
		B[0] == 5 && B[1] == 4 && B[2] == 3 && B[3] == 2 && B[4] == 1;
}
bool TestReverse()
{
	array<int> A = {5, 4, 3, 2, 1};
	A.reverse();
	return A[0] == 1 && A[1] == 2 && A[2] == 3 && A[3] == 4 && A[4] == 5;
}
class cOpCmp
{
	cOpCmp()
	{
		a = 0;
		b = 0.0;
	}
	cOpCmp(int _a, float _b)
	{
		a = _a;
		b = _b;
	}
	void set(int _a, float _b)
	{
		a = _a;
		b = _b;
	}
	int opCmp(cOpCmp &in other)
	{
		return a - other.a;
	}
	int a;
	float b;
}
class cOpEquals
{
	cOpEquals()
	{
		a = 0;
		b = 0.0;
	}
	cOpEquals(int _a, float _b)
	{
		a = _a;
		b = _b;
	}
	void set(int _a, float _b)
	{
		a = _a;
		b = _b;
	}
	bool opEquals(cOpEquals &in other)
	{
		return a == other.a;
	}
	int a;
	float b;
}
bool TestFind()
{
	array<int> A = {5, 8, 3, 2, 0, 0, 2, 1};
	if (A.find(10) != -1)
		return false;
	if (A.find(0) != 4)
		return false;
	if (A.find(1, 8) != 1)
		return false;
	if (A.find(2, 8) != -1)
		return false;
	array<cOpCmp> CMP(5);
	CMP[0].set(0, 0.0);
	CMP[1].set(1, 0.0);
	CMP[2].set(2, 0.0);
	CMP[3].set(3, 0.0);
	CMP[4].set(4, 0.0);
	if (CMP.find(cOpCmp(5, 0.0)) != -1)
		return false;
	if (CMP.find(2, cOpCmp(2, 1.0)) != 2)
		return false;
	if (CMP.find(3, cOpCmp(2, 1.0)) != -1)
		return false;
	array<cOpEquals> EQ(5);
	EQ[0].set(0, 0.0);
	EQ[1].set(1, 0.0);
	EQ[2].set(2, 0.0);
	EQ[3].set(3, 0.0);
	EQ[4].set(4, 0.0);
	if (EQ.find(cOpEquals(5, 0.0)) != -1)
		return false;
	if (EQ.find(2, cOpEquals(2, 1.0)) != 2)
		return false;
	if (EQ.find(3, cOpEquals(2, 1.0)) != -1)
		return false;
	return true;
}
int main()
{
	assert( TestSort() );
	assert( TestReverse() );
	assert( TestFind() );
	return 789;
}
