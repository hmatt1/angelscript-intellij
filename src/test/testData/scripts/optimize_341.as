void TestOptimizeAdd()
{
  int a = 43, b = 13;
  g_i0 = a + b;
  g_i1 = a + 13;
  g_i2 = 43 + b;
  g_i3 = 43 + 13;
  g_i4 = a;
  g_i4 += b;
  g_i5 = a;
  g_i5 += 13;
}
void TestOptimizeSub()
{
  int a = 43, b = 13;
  g_i0 = a - b;
  g_i1 = a - 13;
  g_i2 = 43 - b;
  g_i3 = 43 - 13;
  g_i4 = a;
  g_i4 -= b;
  g_i5 = a;
  g_i5 -= 13;
}
void TestOptimizeMul()
{
  int a = 43, b = 13;
  g_i0 = a * b;
  g_i1 = a * 13;
  g_i2 = 43 * b;
  g_i3 = 43 * 13;
  g_i4 = a;
  g_i4 *= b;
  g_i5 = a;
  g_i5 *= 13;
}
void TestOptimizeDiv()
{
  int a = 43, b = 13;
  g_i0 = a / b;
  g_i1 = a / 13;
  g_i2 = 43 / b;
  g_i3 = 43 / 13;
  g_i4 = a;
  g_i4 /= b;
  g_i5 = a;
  g_i5 /= 13;
}
void TestOptimizeMod()
{
  int a = 43, b = 13;
  g_i0 = a % b;
  g_i1 = a % 13;
  g_i2 = 43 % b;
  g_i3 = 43 % 13;
  g_i4 = a;
  g_i4 %= b;
  g_i5 = a;
  g_i5 %= 13;
}
void TestOptimizeAdd64()
{
  int64 a = 43, b = 13;
  g_i64_0 = a + b;
  g_i64_1 = a + 13;
  g_i64_2 = 43 + b;
  g_i64_3 = 43 + 13;
  g_i64_4 = a;
  g_i64_4 += b;
  g_i64_5 = a;
  g_i64_5 += 13;
}
void TestOptimizeSub64()
{
  int64 a = 43, b = 13;
  g_i64_0 = a - b;
  g_i64_1 = a - 13;
  g_i64_2 = 43 - b;
  g_i64_3 = 43 - 13;
  g_i64_4 = a;
  g_i64_4 -= b;
  g_i64_5 = a;
  g_i64_5 -= 13;
}
void TestOptimizeMul64()
{
  int64 a = 43, b = 13;
  g_i64_0 = a * b;
  g_i64_1 = a * 13;
  g_i64_2 = 43 * b;
  g_i64_3 = 43 * 13;
  g_i64_4 = a;
  g_i64_4 *= b;
  g_i64_5 = a;
  g_i64_5 *= 13;
}
void TestOptimizeDiv64()
{
  int64 a = 43, b = 13;
  g_i64_0 = a / b;
  g_i64_1 = a / 13;
  g_i64_2 = 43 / b;
  g_i64_3 = 43 / 13;
  g_i64_4 = a;
  g_i64_4 /= b;
  g_i64_5 = a;
  g_i64_5 /= 13;
}
void TestOptimizeMod64()
{
  int64 a = 43, b = 13;
  g_i64_0 = a % b;
  g_i64_1 = a % 13;
  g_i64_2 = 43 % b;
  g_i64_3 = 43 % 13;
  g_i64_4 = a;
  g_i64_4 %= b;
  g_i64_5 = a;
  g_i64_5 %= 13;
}
void TestOptimizeAddf()
{
  float a = 43, b = 13;
  g_f0 = a + b;
  g_f1 = a + 13;
  g_f2 = 43 + b;
  g_f3 = 43.0f + 13;
  g_f4 = a;
  g_f4 += b;
  g_f5 = a;
  g_f5 += 13;
}
void TestOptimizeSubf()
{
  float a = 43, b = 13;
  g_f0 = a - b;
  g_f1 = a - 13;
  g_f2 = 43 - b;
  g_f3 = 43.0f - 13;
  g_f4 = a;
  g_f4 -= b;
  g_f5 = a;
  g_f5 -= 13;
}
void TestOptimizeMulf()
{
  float a = 43, b = 13;
  g_f0 = a * b;
  g_f1 = a * 13;
  g_f2 = 43 * b;
  g_f3 = 43.0f * 13;
  g_f4 = a;
  g_f4 *= b;
  g_f5 = a;
  g_f5 *= 13;
}
void TestOptimizeDivf()
{
  float a = 43, b = 13;
  g_f0 = a / b;
  g_f1 = a / 13;
  g_f2 = 43 / b;
  g_f3 = 43.0f / 13.0f;
  g_f4 = a;
  g_f4 /= b;
  g_f5 = a;
  g_f5 /= 13;
}
void TestOptimizeModf()
{
  float a = 43, b = 13;
  g_f0 = a % b;
  g_f1 = a % 13;
  g_f2 = 43 % b;
  g_f3 = 43.0f % 13;
  g_f4 = a;
  g_f4 %= b;
  g_f5 = a;
  g_f5 %= 13;
}
void TestOptimizeAddd()
{
  double a = 43.0, b = 13.0;
  g_d0 = a + b;
  g_d1 = a + 13.0;
  g_d2 = 43.0 + b;
  g_d3 = 43.0 + 13.0;
  g_d4 = a;
  g_d4 += b;
  g_d5 = a;
  g_d5 += 13.0;
}
void TestOptimizeSubd()
{
  double a = 43.0, b = 13.0;
  g_d0 = a - b;
  g_d1 = a - 13.0;
  g_d2 = 43.0 - b;
  g_d3 = 43.0 - 13.0;
  g_d4 = a;
  g_d4 -= b;
  g_d5 = a;
  g_d5 -= 13.0;
}
void TestOptimizeMuld()
{
  double a = 43.0, b = 13.0;
  g_d0 = a * b;
  g_d1 = a * 13.0;
  g_d2 = 43.0 * b;
  g_d3 = 43.0 * 13.0;
  g_d4 = a;
  g_d4 *= b;
  g_d5 = a;
  g_d5 *= 13.0;
}
void TestOptimizeDivd()
{
  double a = 43.0, b = 13.0;
  g_d0 = a / b;
  g_d1 = a / 13.0;
  g_d2 = 43.0 / b;
  g_d3 = 43.0 / 13.0;
  g_d4 = a;
  g_d4 /= b;
  g_d5 = a;
  g_d5 /= 13.0;
}
void TestOptimizeModd()
{
  double a = 43.0, b = 13.0;
  g_d0 = a % b;
  g_d1 = a % 13.0;
  g_d2 = 43.0 % b;
  g_d3 = 43.0 % 13.0;
  g_d4 = a;
  g_d4 %= b;
  g_d5 = a;
  g_d5 %= 13.0;
}
void TestOptimizeAnd()
{
  uint a = 0xF3, b = 0x17;
  g_b0 = a & b;
  g_b1 = a & 0x17;
  g_b2 = 0xF3 & b;
  g_b3 = 0xF3 & 0x17;
  g_b4 = a;
  g_b4 &= b;
  g_b5 = a;
  g_b5 &= 0x17;
}
void TestOptimizeOr()
{
  uint a = 0xF3, b = 0x17;
  g_b0 = a | b;
  g_b1 = a | 0x17;
  g_b2 = 0xF3 | b;
  g_b3 = 0xF3 | 0x17;
  g_b4 = a;
  g_b4 |= b;
  g_b5 = a;
  g_b5 |= 0x17;
}
void TestOptimizeXor()
{
  uint a = 0xF3, b = 0x17;
  g_b0 = a ^ b;
  g_b1 = a ^ 0x17;
  g_b2 = 0xF3 ^ b;
  g_b3 = 0xF3 ^ 0x17;
  g_b4 = a;
  g_b4 ^= b;
  g_b5 = a;
  g_b5 ^= 0x17;
}
void TestOptimizeSLL()
{
  uint a = 0xF3;
  uint b = 3;
  g_b0 = a << b;
  g_b1 = a << 3;
  g_b2 = 0xF3 << b;
  g_b3 = 0xF3 << 3;
  g_b4 = a;
  g_b4 <<= b;
  g_b5 = a;
  g_b5 <<= 3;
}
void TestOptimizeSRA()
{
  uint a = 0xF3;
  uint b = 3;
  g_b0 = a >>> b;
  g_b1 = a >>> 3;
  g_b2 = 0xF3 >>> b;
  g_b3 = 0xF3 >>> 3;
  g_b4 = a;
  g_b4 >>>= b;
  g_b5 = a;
  g_b5 >>>= 3;
}
void TestOptimizeSRL()
{
  uint a = 0xF3;
  uint b = 3;
  g_b0 = a >> b;
  g_b1 = a >> 3;
  g_b2 = 0xF3 >> b;
  g_b3 = 0xF3 >> 3;
  g_b4 = a;
  g_b4 >>= b;
  g_b5 = a;
  g_b5 >>= 3;
}
void TestOptimizeAnd64()
{
  uint64 a = 0xF3, b = 0x17;
  g_b64_0 = a & b;
  g_b64_1 = a & 0x17;
  g_b64_2 = 0xF3 & b;
  g_b64_3 = 0xF3 & 0x17;
  g_b64_4 = a;
  g_b64_4 &= b;
  g_b64_5 = a;
  g_b64_5 &= 0x17;
}
void TestOptimizeOr64()
{
  uint64 a = 0xF3, b = 0x17;
  g_b64_0 = a | b;
  g_b64_1 = a | 0x17;
  g_b64_2 = 0xF3 | b;
  g_b64_3 = 0xF3 | 0x17;
  g_b64_4 = a;
  g_b64_4 |= b;
  g_b64_5 = a;
  g_b64_5 |= 0x17;
}
void TestOptimizeXor64()
{
  uint64 a = 0xF3, b = 0x17;
  g_b64_0 = a ^ b;
  g_b64_1 = a ^ 0x17;
  g_b64_2 = 0xF3 ^ b;
  g_b64_3 = 0xF3 ^ 0x17;
  g_b64_4 = a;
  g_b64_4 ^= b;
  g_b64_5 = a;
  g_b64_5 ^= 0x17;
}
void TestOptimizeSLL64()
{
  uint64 a = 0xF3;
  uint64 b = 3;
  g_b64_0 = a << b;
  g_b64_1 = a << 3;
  g_b64_2 = 0xF3 << b;
  g_b64_3 = 0xF3 << 3;
  g_b64_4 = a;
  g_b64_4 <<= b;
  g_b64_5 = a;
  g_b64_5 <<= 3;
}
void TestOptimizeSRA64()
{
  uint64 a = 0xF3;
  uint64 b = 3;
  g_b64_0 = a >>> b;
  g_b64_1 = a >>> 3;
  g_b64_2 = 0xF3 >>> b;
  g_b64_3 = 0xF3 >>> 3;
  g_b64_4 = a;
  g_b64_4 >>>= b;
  g_b64_5 = a;
  g_b64_5 >>>= 3;
}
void TestOptimizeSRL64()
{
  uint64 a = 0xF3;
  uint64 b = 3;
  g_b64_0 = a >> b;
  g_b64_1 = a >> 3;
  g_b64_2 = 0xF3 >> b;
  g_b64_3 = 0xF3 >> 3;
  g_b64_4 = a;
  g_b64_4 >>= b;
  g_b64_5 = a;
  g_b64_5 >>= 3;
}
