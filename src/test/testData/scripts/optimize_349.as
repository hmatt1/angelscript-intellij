void main() {
  func(glob);
}
C glob;
class C {}
void func(const C &in arg) { assert( arg is glob ); }
