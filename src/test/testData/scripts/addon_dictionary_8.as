enum foo { a, b, c };
void main()
{
    assert( b == 1 );
    {
        dictionary d = { {'enumVal', 1} };
        int val = int(d['enumVal']);
        assert( val == 1 );
    }
    {
        dictionary d = { {'enumVal', b} };
        int val = int(d['enumVal']);
        assert( val == 1 );
    }
    {
        dictionary d = { {'enumVal', b} };
        foo val = foo(d['enumVal']);
        assert( val == 1 );
    }
    MyAppDefinedEnum mode = MyAppDefinedEnum(10);
    assert( mode == 10 );
    {
        dictionary d = { {'mode', mode} };
        MyAppDefinedEnum m = MyAppDefinedEnum(d['mode']);
        assert( mode == 10 );
        one(d);
        two(d);
    }
    {
        dictionary d;
        d['mode'] = mode;
        MyAppDefinedEnum m = MyAppDefinedEnum(d['mode']);
        assert( mode == 10 );
        one(d);
        two(d);
    }
}
void one(dictionary@ d)
{
    MyAppDefinedEnum m = MyAppDefinedEnum(d['mode']);
    assert( m == 10 );
}
void two(dictionary@ d)
{
    int m = int(d['mode']);
    assert( m == 10 );
}
