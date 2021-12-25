class C1
{
    C1 ()
    {
//"        write('C1\n');
    }
    int m1 ()
    {
//"        write('m1\n');
        return 2;
	}
}
class C2
{
    C2 (int )
    {
//"        write('C2 int\n');
    }
    C2 (const C1 &in c1)
    {
//"        write('C2 C1\n');
    }
}
void main ()
{
    C1 c1;
    C2 c2_4(c1.m1);
}
