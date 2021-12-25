interface ITest1 { }
interface ITest2 { }

CTest@[] Array1;

class CTest : ITest1
{
	CTest()
	{
		Index=0;
		@Field=null;
	}

	int Index;
	ITest2@ Field;
}

int GetTheIndex()
{
  return Array1[0].Index;
}

void Test()
{
  Array1.resize(1);
  CTest test();
  @Array1[0] = test;
  GetTheIndex();
}
