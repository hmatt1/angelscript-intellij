class A{}
class B{}
int choice;
void func(const A&in, const B&in) { choice = 1; }
void func(A&in, A&in) { choice = 2; }
void test()
{
  A a; B b;
  func(a,b);
  assert( choice == 1 );
}
