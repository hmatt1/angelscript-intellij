enum TestEnum {
 TE_0,
 TE_1,
};
class TestClass {
 TestClass(TestEnum en) {
 }
};
void init() {
 TestClass@ cl = TestClass(TE_1);
}
