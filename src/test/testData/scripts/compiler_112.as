void test(int a) { }
void test(float a) { }
void test(bool c) { }
class Test {
    void test(int a) { }
    void test(float a) { }
    void test(bool c) { }
}
void main() {
    test();
    Test test;
    test.test();
}
