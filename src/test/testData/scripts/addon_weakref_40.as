class Test {}
void main() {
  Test @t = Test();
  weakref<Test> r(t);
  assert( r.get() !is null );
  const_weakref<Test> c;
  @c = r;
  assert( c.get() !is null );
  @t = null;
  assert( r.get() is null );
  assert( c.get() is null );
  @t = Test();
  @c = t;
  assert( c.get() !is null );
  const Test @ct = c;
  assert( ct !is null );
  assert( c !is null );
  assert( c is ct );
  @c = null;
  assert( c is null );
}
