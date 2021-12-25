void main()
{
	array<int> arr(2, 42);
   assert(arr[0] == 42);
   assert(arr[1] == 42);
   array<array<int>> arr2(2, array<int>(2));
   assert(arr2[0].length() == 2);
	assert(arr2[1].length() == 2);
   array<array<int>@> arr3(2, arr);
   assert(arr3[0] is arr);
   assert(arr3[1] is arr);
}
