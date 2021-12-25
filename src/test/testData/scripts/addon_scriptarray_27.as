class fish
{
  bool opEquals(fish@ other)
  {
    return false;
  }
}
void main()
{
  fish@[] ocean(100);
  for(uint i=0; i<ocean.length(); i++)
  {
    fish fred;
    @(ocean[i]) = fred;
  }
  fish nemo;
  int index = ocean.find(nemo);
}
