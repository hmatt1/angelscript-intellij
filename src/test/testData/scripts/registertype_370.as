class Test { int val = 42; }
void main() {
  ref a;
  Test b;
  b.val = 24;
  a = b;
  assert( a !is b );
  assert( cast<Test>(a).val == b.val );
  @a = b;
  assert( a is b );
}
