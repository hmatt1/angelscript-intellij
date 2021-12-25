class CTest
{
  double _vol;
  double get_vol() const property { return _vol; }
  void set_vol(double &in v) property { _vol = v; }
}
CTest t;
void main()
{
  for( t.vol = 0; t.vol < 10; t.vol++ );
}
