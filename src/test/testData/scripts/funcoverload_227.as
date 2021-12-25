class A {
  void func(int) { choice = 1; }
  void func(int) const { choice = 2; }
}
int choice;
void main()
{
  A@ a = A();
  const A@ b = A();
  a.func(1); assert( choice == 1 );
  b.func(1); assert( choice == 2 );
}
