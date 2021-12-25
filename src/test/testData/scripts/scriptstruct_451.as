class MyStruct
{
  uint myBits;
};
uint MyFunc(uint a)
{
  return a;
}
void MyFunc(string@) {}
void Test()
{
  uint val = 0x0;
  MyStruct s;
  s.myBits = 0x5;
  val = MyFunc(s.myBits);
}
