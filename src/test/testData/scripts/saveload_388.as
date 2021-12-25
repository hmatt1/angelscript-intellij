interface IObj {};
class Hoge : IObj {};
void main(int a = 0)
{
    Hoge h;
    IObj@ objHandle = h;
    Hoge@ hogeHandle = cast< Hoge@ >( objHandle );
};
