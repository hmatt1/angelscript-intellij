class C {} void func(C @&out) {}
void main() {
  bool f = true;
  if( f )
  {
    func(void);
    func(null);
  }
  else
    func(C());
}
