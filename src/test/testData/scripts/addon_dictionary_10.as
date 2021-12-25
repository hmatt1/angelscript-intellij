class C { dictionary dict; }
void f() { C c; c.dict.set("self", @c); }
