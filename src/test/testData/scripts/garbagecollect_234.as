CBar test;
class CBase : IMyInterface
{
  IMyInterface@ m_dummy;
}
class CBar : CBase
{
  CBar()
  {
    m_foo.SetObject(this);
  }
  CFoo m_foo;
};
