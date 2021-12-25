void TestFloat()
{
  float a = 2, b = 3, c = 1;
  c = a + b;
  a = b + 23;
  b = 12 + c;
  c = a - b;
  a = b - 23;
  b = 12 - c;
  c = a * b;
  a = b * 23;
  b = 12 * c;
  c = a / b;
  a = b / 23;
  b = 12 / c;
  c = a % b;
  a = b % 23;
  b = 12 % c;
  a++;
  ++a;
  a += b;
  a += 3;
  a /= c;
  a /= 5;
  a = b = c;
  func( a-1, b, c );
  a = -b;
  a = func2();
}
void func(float a, float &in b, float &out c)
{
  c = a + b;
  b = c;
  g = g;
}
float g = 0;
float func2()
{
  return g + 1;
}
