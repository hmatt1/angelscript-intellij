class MyClass {
  int a;
  MyClass(int a) { this.a = a; }
  MyClass &opAssign(const MyClass &in o) { a = o.a; return this; }
  int foo() { return a; }
}

void main() {
  int i;
  MyClass m(5);
  MyClass t(10);
  i = (m = t).a;
  assert(i == 10);
  i = (m = MyClass(10)).a;
  assert(i == 10);
  MyClass n(10);
  MyClass o(15);
  m = n = o;
  m = n = MyClass(20);
  (m = n).foo();
  (m = MyClass(20)).foo();
}
