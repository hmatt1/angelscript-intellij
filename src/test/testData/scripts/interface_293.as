interface I { void method(); }
class B { void method() {} }
class D : B, I {}
D d;
