class Base {
  bool func(int a = 3, int b = 5, int c = 7) {
    return a == 3 && b == 5 && c == 7;
  }
}

class Derived : Base {
  bool func(int x = 3, int y = 5, int z = 7) override {
    return x == 3 && y == 5 && z == 7;
  }
}

void test() {
  Derived o;
  assert(o.func());
  assert(o.func(3, 5));
  assert(o.func(x:3));
  assert(o.func(y:5));
  assert(o.func(z:7));
  assert(o.func(z:7, x:3));
  assert(o.func(x:3, y:5, z:7));
  assert(o.func(x:3, z:7, y:5));
  assert(o.func(z:7, y:5, x:3));
  Base@ asBase = o;
  assert(asBase.func());
  assert(asBase.func(3, 5));
  assert(asBase.func(a:3));
  assert(asBase.func(b:5));
  assert(asBase.func(c:7));
  assert(asBase.func(c:7, a:3));
  assert(asBase.func(a:3, b:5, c:7));
  assert(asBase.func(a:3, c:7, b:5));
  assert(asBase.func(c:7, b:5, a:3));
}
