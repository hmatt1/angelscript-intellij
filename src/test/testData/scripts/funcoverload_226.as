int choice = 0;
void func(int, float, double) { choice = 1; }
void func(float, int, double) { choice = 2; }
void func(double, float, int) { choice = 3; }
void main()
{
  func(1, 1.0f, 1.0); assert( choice == 1 );
  func(1.0f, 1, 1.0); assert( choice == 2 );
  func(1.0, 1.0f, 1); assert( choice == 3 );
  func(1.0, 1, 1); assert( choice == 3 );
  func(1.0f, 1.0, 1.0); assert( choice == 2 );
  func(1.0f, 1.0f, 1); assert( choice == 3 );
}
