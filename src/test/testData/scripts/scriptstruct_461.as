class C {
  int a(int i) { return ABS(i); }
  private int ABS(int i)
  {
    if(i <= 0) return (-1 * i);
    else return i;
  }
}
