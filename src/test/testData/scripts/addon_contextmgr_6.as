int value = 0;
void MyCoRoutine(dictionary @args) { yield(); value = int(args['arg1']); }
void main() {
  createCoRoutine(MyCoRoutine, (dictionary = {{'arg1', 42}}));
  assert( value == 0 );
  yield();
  assert( value == 0 );
  yield();
  assert( value == 42 );
}
