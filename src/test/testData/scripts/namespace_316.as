int func() { return var; }
int func2() { return var; }
int var = 0;
class cl { cl() {v = 0;} int v; }
interface i {}
enum e { e1 = 0 }
funcdef void fd();
// Namespaces allow same entities to be declared again
namespace a {
  int func() { return var; }
  int func2() { return func(); }
  int var = 1;
  class cl { cl() {v = 1;} int v; }
  interface i {}
  enum e { e1 = 1 }
  funcdef void fd();
  ::e MyFunc() { return ::e1; }
// Nested namespaces are allowed
  namespace b {
    int var = 2;
    void funcParams(int a, float b) { a+b; }
  }
// Accessing global variables from within a namespace is also possible
  int getglobalvar() { return ::var; }
}
// The class should be able to declare methods to return and take types from other namespaces
class MyClass {
  a::e func(a::e val) { return val; }
  ::e func(::e val) { return val; }
}
// Global functions must also be able to return and take types from other namespaces
a::e MyFunc(a::e val) { return val; }
// It's possible to specify exactly which one is wanted
cl gc;
a::cl gca;
void main()
{
  assert(var == 0);
  assert(::var == 0);
  assert(a::var == 1);
  assert(a::b::var == 2);
  assert(func() == 0);
  assert(a::func() == 1);
  assert(func2() == 0);
  assert(a::func2() == 1);
  assert(e1 == 0);
  assert(::e1 == 0);
  assert(e::e1 == 0);
  assert(::e::e1 == 0);
  assert(a::e1 == 1);
  assert(a::e::e1 == 1);
  cl c;
  a::cl ca;
  assert(c.v == 0);
  assert(ca.v == 1);
  assert(gc.v == 0);
  assert(gca.v == 1);
  assert(a::getglobalvar() == 0);
}
