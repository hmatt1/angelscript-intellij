int getInt() { return 18; }
float getFloat() { return 18.f; }
void test() {
  auto anInt = getInt(); assert(anInt == 18);
  auto aFloat = getFloat(); assert(aFloat == 18.f);
  auto combined = anInt + aFloat; assert(combined == (18 + 18.f));
}

