class A { void Access() {} }
class B { B() { g_a.Access(); g_c.Access(); } }
A g_a;
B g_b;
A g_c;
