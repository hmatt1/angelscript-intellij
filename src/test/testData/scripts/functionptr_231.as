funcdef void functype();
// It must be possible to declare variables of the funcdef type
functype @myFunc = null;
// It must be possible to initialize the function pointer directly
functype @myFunc1 = @func;
void func() { called = true; }
bool called = false;
// It must be possible to compare the function pointer with another
void main() {
  assert( myFunc1 !is null );
  assert( myFunc1 is func );
// It must be possible to call a function through the function pointer
  myFunc1();
  assert( called );
// Local function pointer variables are also possible
  functype @myFunc2 = @func;
}
