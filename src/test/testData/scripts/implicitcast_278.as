class File {
  int64 readInt(uint a) { int64 v = -1; return v*512; }
}
const int origVal = -512;
void main()
{
  File f;
  assert( f.readInt(4) == origVal );
  assert( int(f.readInt(4)) == origVal );
  const int localVal = -512;
  assert( f.readInt(4) == localVal );
  assert( int(f.readInt(4)) == localVal );
}
