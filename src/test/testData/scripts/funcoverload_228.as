void func(int8, double a = 1.0) { choice = 1; }
void func(float) { choice = 2; }
int choice;
void main()
{
  func(1); assert( choice == 1 );
}
