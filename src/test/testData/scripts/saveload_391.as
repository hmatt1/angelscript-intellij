interface ITest
{
  ITest@ test();
}
class CTest : ITest
{
  ITest@ test()
  {
    return this;
  }
}
