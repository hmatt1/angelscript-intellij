const auto aConstant = 18;
auto str = "some string";
auto concat = str + aConstant;
void test() {
  assert(aConstant == 18);
  assert(str == "some string");
  assert(concat == "some string18");
}

