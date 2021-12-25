class myclass
{
  myclass() {value = 42;}
  void func() {Assert(value == 42);}
  void func(int x, int y) {Assert(value == 42);}
  int value;
};
myclass c;
