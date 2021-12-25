void main()
{
  uint8[] a={2,3,4,5};

  a[1] |= 0x30;
  a[2] += 0x30;
  print(a[1]);
  print(a[2]);
  assert(a[1] == 0x33);
  assert(a[2] == 0x34);
}
