class Hoge
{
  int mValue;
  Hoge()
  {
    mValue = 0;
  }
  Hoge@ opAssign(const Hoge &in aObj)
  {
    mValue = aObj.mValue;
    return @this;
  }
};
void main()
{
  Hoge a = Hoge();
}
