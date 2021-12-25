class Test { weakref<Test> friend(null); }
void main() {
  Test t;
  assert( t.friend is null );
  @t.friend = t;
  assert( t.friend is t );
  weakref<Test> f;
}
