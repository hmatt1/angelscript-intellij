namespace foo {
  int global = 42;
  void func(int var = global) {}
}
void main() {
  foo::func();
}
