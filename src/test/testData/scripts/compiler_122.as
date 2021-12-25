class Obj {};
class Hoge
{
    const Obj obj()const { return Obj(); }
}
class Foo
{
    Foo()
    {
        Hoge h;
        Obj tmpObj = h.obj();
        mObj = h.obj();
    }
    Obj mObj;
}
