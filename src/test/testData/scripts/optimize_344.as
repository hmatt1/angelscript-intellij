class C {}
C @c;
C @&func_inner() { return c; }
C @func() { C @l = func_inner(); return l; }
