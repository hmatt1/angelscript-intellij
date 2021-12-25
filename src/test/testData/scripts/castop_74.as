class TestObj
{
TestObj(int a) {this.a = a;}
TestObj(TestObj2 a) {this.a = a.a;}
int a;
}
// This object must not be used to get to TestObj
class TestObj2
{
TestObj2(int a) {assert(false);}
int a;
}
void Func(TestObj obj)
{
assert(obj.a == 2);
}
void Test()
{
Func(2);
Func(2.1);
}
