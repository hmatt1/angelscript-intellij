void Test()
{
   TestInt();
   Test2D();
}

void TestInt()
{
   int[] A(5);
   Assert(A.size() == 5);
	A.push_back(6);
   Assert(A.size() == 6);
	A.pop_back();
   Assert(A.size() == 5);
	A[1] = 20;
	Assert(A[1] == 20);
   char[] B(5);
   Assert(B.size() == 5);
// TODO: Add support for initialization list for value types as well
//"   int[] c = {2,3};
//"   Assert(c.size() == 2);
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
