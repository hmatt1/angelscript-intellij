int myvar = 42;
void Function(int a, int b = myvar) { assert( b == 42 ); }
void main()
{
	int myvar = 1;
	Function(1);
}
