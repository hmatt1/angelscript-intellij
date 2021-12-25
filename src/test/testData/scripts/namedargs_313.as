bool func(int a = 4, int b = 6, int c = 8) {
  return a == 4 && b == 6 && c == 8;
}

void test() {
  assert(func());
  assert(func(4, 6));
  assert(func(a:4));
  assert(func(b:6));
  assert(func(c:8));
  assert(func(c:8, a:4));
  assert(func(a:4, b:6, c:8));
  assert(func(a:4, c:8, b:6));
  assert(func(c:8, b:6, a:4));
}
