class C {}
C @func_inner() { return C(); }
void func() { C @l = func_inner(); }
