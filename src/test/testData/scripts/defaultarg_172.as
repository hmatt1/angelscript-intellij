class T {
  void test() {}
  void test(float a = 0) {}
}
class Base {
  void test() {}
}
class Derived : Base {
  void test(float a = 0) {}
}
