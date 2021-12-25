void main() {
  MyClass @t = MyClass();
  weakref<MyClass> r(t);
  assert( r.get() !is null );
  @t = null;
  assert( r.get() is null );
}
