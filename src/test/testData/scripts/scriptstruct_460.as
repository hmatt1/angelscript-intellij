class C {
  private void func() {}
  void func2() { func(); } }
void main() { C c; c.func(); }
