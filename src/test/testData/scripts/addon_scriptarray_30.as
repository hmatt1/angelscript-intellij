class A
{
	int x;
}
int sum(const array<A>& a)
{
	int s = 0;
	for (uint i=0; i<a.length(); i++)
		s+=a[i].x;
	return s;
}
