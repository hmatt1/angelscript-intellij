
void addToArray(string _name, float _myFloat, bool _bool1, bool _bool2)
{
	if(maxCnt == cnt)
		return;
	a[cnt].myName = _name;
	a[cnt].myFloat = _myFloat;
	a[cnt].myBool1 = _bool1;
	a[cnt].myBool2 = _bool2;
	cnt++;
}

void MyTest()
{
  MyClass c;
  c.myName = "test";
  c.myFloat = 3.14f;
  c.myBool1 = south;
  c.myBool2 = south;
  Assert(c.myBool1 == false);
  Assert(c.myBool2 == false);
  c.myBool1 = north;
  Assert(c.myBool1 == true);
  Assert(c.myBool2 == false);
  c.myBool2 = north;
  Assert(c.myBool1 == true);
  Assert(c.myBool2 == true);
  c.myBool1 = south;
  Assert(c.myBool1 == false);
  Assert(c.myBool2 == true);
  Assert(c.myFloat == 3.14f);
  CFunc(c.myFloat, c.myBool1, c.myBool2, c.myName);

  addToArray(c.myName, 3.14f, south, east);
  addToArray(c.myName, 3.14f, north, east);
  addToArray(c.myName, 3.14f, south, west);
  addToArray(c.myName, 3.14f, north, west);

  Assert(a[0].myBool1 == false);
  Assert(a[0].myBool2 == false);
  Assert(a[1].myBool1 == true);
  Assert(a[1].myBool2 == false);
  Assert(a[2].myBool1 == false);
  Assert(a[2].myBool2 == true);
  Assert(a[3].myBool1 == true);
  Assert(a[3].myBool2 == true);
  CFunc(a[0].myFloat, a[0].myBool1, a[0].myBool2, a[0].myName);
  CFunc(a[1].myFloat, a[1].myBool1, a[1].myBool2, a[1].myName);
  CFunc(a[2].myFloat, a[2].myBool1, a[2].myBool2, a[2].myName);
  CFunc(a[3].myFloat, a[3].myBool1, a[3].myBool2, a[3].myName);
}
