class X1 {}
class X2
{
    const X1 @ f1 (void)
    {
        return x1_;
    }
    const X1 & f2 (void) const
    {
        return x1_;
    }
    const X1 & f3 (void)
    {
        return x1_;
    }
    const int & f4 (void)
    {
        return i1_;
    }
    int & f5 (void) const
    {
        return i1_;
    }
	 X1 & f6 (void) const
    {
        return x1_;
    }
    private X1 x1_;
    private int i1_;
}
