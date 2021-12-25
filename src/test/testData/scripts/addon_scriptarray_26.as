class fish
{
  bool opEquals(fish@ other)
  {
    return false;
  }
}
void main()
{
  fish[] ocean(100);
  fish nemo;
  int index = ocean.find(nemo);
}
