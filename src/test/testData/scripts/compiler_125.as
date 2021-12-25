class obj {}
bool getPendingMats(obj@&out TL)
{
  return false;
}
void paintFloor()
{
  obj@[] center(4);
  bool bb = getPendingMats(center[3]);
  assert( bb == false );
}
