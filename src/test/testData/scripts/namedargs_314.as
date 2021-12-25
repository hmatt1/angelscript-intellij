class Base {
  bool func(int a = 4, int b = 6, int c = 8) {
    return a == 4 && b == 6 && c == 8;
  }
}

void test() {
  Base o;
  assert(o.func());
  assert(o.func(4, 6));
  assert(o.func(a:4));
  assert(o.func(b:6));
  assert(o.func(c:8));
  assert(o.func(c:8, a:4));
  assert(o.func(a:4, b:6, c:8));
  assert(o.func(a:4, c:8, b:6));
  assert(o.func(c:8, b:6, a:4));
}
