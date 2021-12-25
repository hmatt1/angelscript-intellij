bool baseDestructorCalled = false;
bool baseConstructorCalled = false;
bool baseFloatConstructorCalled = false;
class Base : Intf
{
  int a;
  void f1() { a = 1; }
  void f2() { a = 0; }
  void f3() { a = 3; }
  Base() { baseConstructorCalled = true; }
  Base(float) { baseFloatConstructorCalled = true; }
  ~Base() { baseDestructorCalled = true; }
}
bool derivedDestructorCalled = false;
bool derivedConstructorCalled = false;
class Derived : Base
{
// overload f2()
  void f2() { a = 2; }
// overload f3()
  void f3() { a = 2; }
  void func()
  {
// call Base::f1()
    f1();
    assert(a == 1);
// call Derived::f2()
    f2();
    assert(a == 2);
// call Base::f3()
    Base::f3();
    assert(a == 3);
  }
  Derived() {}
  Derived(int) { derivedConstructorCalled = true; }
  ~Derived() { derivedDestructorCalled = true; }
}
void foo( Base &in a )
{
  assert( cast<Derived>(a) is null );
}
// Must be possible to call the default constructor, even if not declared
class DerivedGC : BaseGC { DerivedGC() { super(); } }
class BaseGC { BaseGC @b; }
class DerivedS : Base
{
  DerivedS(float)
  {
// Call Base::Base(float)
    if( true )
      super(1.4f);
    else
      super();
  }
}
// Must handle inheritance where the classes have been declared out of order
void func()
{
   Intf@ a = C();
}
class C : B {}
interface Intf {}
class B : Intf {}
// Several levels of inheritance
class C0
{
  void Dummy() {}
}
class C1 : C0
{
  void Fun() { print('C1:Fun'); }
}
class C2 : C1
{
  void Fun() { print('C2:Fun'); }
}
class C3 : C2
{
  void Call() { Fun(); }
}
