class Foo {
  Foo(string arg = '23') { val = arg; }
  Foo func() { Foo bar; return bar; }
  Foo &opAssign(const Foo &in o) { val = o.val; return this; }
  string val;
}
Foo bar;
Foo bar2('2');
