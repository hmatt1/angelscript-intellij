int Main()
{
    // Call test
    foo();
    cfunction();
    Int64 var;
    bar( var );
    // Some value we'll know when we return
    return 31337;
}
void foo( )
{
    Int64 var;
    bar( var );
}
void bar( Int64 )
{
    cfunction();
}
