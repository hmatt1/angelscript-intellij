void Test(string strA, string strB)
{
  a = true ? strA : strB;
  a = false ? "t" : "f";
  SetAttrib(true ? strA : strB);
  SetAttrib(false ? "f" : "t");
}
void SetAttrib(string str) { assert( str == 't' ); }
