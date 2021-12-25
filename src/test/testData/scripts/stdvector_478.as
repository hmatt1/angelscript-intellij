void Test()
{
   TestInt();
   TestChar();
   Test2D();
}

void TestInt()
{
   int[] A(5);
   Assert(A.size() == 5);
	A.push_back(6);
   Assert(A.size() == 6);
	int[] B(A);
   Assert(B.size() == 6);
	A.pop_back();
   Assert(B.size() == 6);
   Assert(A.size() == 5);
	A = B;
   Assert(A.size() == 6);
	A.resize(8);
   Assert(A.size() == 8);
	A[1] = 20;
	Assert(A[1] == 20);
}

void TestChar()
{
   int8[] A(5);
   Assert(A.size() == 5);
   A.push_back(6);
   Assert(A.size() == 6);
   int8[] B(A);
   Assert(B.size() == 6);
   A.pop_back();
   Assert(B.size() == 6);
   Assert(A.size() == 5);
   A = B;
   Assert(A.size() == 6);
   A.resize(8);
   Assert(A.size() == 8);
   A[1] = 20;
   Assert(A[1] == 20);
}

void Test2D()
{
   int[][] A(2);
   int[] B(2);
   A[0] = B;
   A[1] = B;

   A[0][0] = 0;
   A[0][1] = 1;
   A[1][0] = 2;
   A[1][1] = 3;

   Assert(A[0][0] == 0);
   Assert(A[0][1] == 1);
   Assert(A[1][0] == 2);
   Assert(A[1][1] == 3);
}
