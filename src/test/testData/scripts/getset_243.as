class Test
{
  bool get_boolProp() property { return true; }
}
void main1()
{
  Test t;
  if( t.boolProp ) {}
  if( t.boolProp && true ) {}
  if( false || t.boolProp ) {}
  if( t.boolProp ^^ t.boolProp ) {}
  if( !t.boolProp ) {}
  t.boolProp ? t.boolProp : t.boolProp;
}
