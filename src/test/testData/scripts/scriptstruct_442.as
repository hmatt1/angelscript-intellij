shared class MyClass {}
shared class T {
  array<MyClass> a;
  MyClass[] b;
  array<MyClass> c = {MyClass()};
  array<MyClass@> d = {MyClass()};
  array<array<MyClass>> e = {{MyClass()}, {MyClass()}};
}
