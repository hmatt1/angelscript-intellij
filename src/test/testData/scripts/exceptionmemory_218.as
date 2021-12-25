class Pie
{
	void foo() {}
}
void calc()
{
    Pie@ thing = null;
    thing.foo(); // Null dereference
}
