int get_foo() property { return 42; }
namespace nm { int get_foo2() property { return 42; } }
void test() {
  assert( foo == 42 );
  assert( ::foo == 42 );
  assert( nm::foo == 42 );
  assert( nm::foo2 == 42 );
  assert( foo2 == 42 );
}
namespace nm {
void test2() {
  ::assert( foo == 42 );
  ::assert( ::foo == 42 );
  ::assert( nm::foo == 42 );
  ::assert( nm::foo2 == 42 );
  ::assert( foo2 == 42 );
}
}
