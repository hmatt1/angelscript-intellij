class A {
  void func() {
    g = 0;
    testScope();
    assert(g == 3);
    ::testScope();
    assert(g == 2);
  }
  void testScope() { g = 3; }
}
void testScope() { g = 2; }
int g;
