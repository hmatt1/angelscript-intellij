class ArrayOf
{
  uint8[] _boolList;
  int _numOfStockedObject;
  ArrayOf(int arraySizeMax)
  {
    _boolList.resize(arraySizeMax);
    _numOfStockedObject = 0;
    for(int i = 0; i < arraySizeMax; ++i)
    {
       _boolList[i] = 0;
    }
  }
}
