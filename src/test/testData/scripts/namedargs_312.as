bool func(int a, int b, int c) {
  return a == 4 && b == 6 && c == 8;
}

void test() {
  assert(func(4, 6, 8));
  assert(func(4, 6, c: 8));
  assert(func(a: 4, b: 6, c: 8));
  assert(func(a: 4, c: 8, b: 6));
  assert(func(c: 8, b: 6, a: 4));
}
