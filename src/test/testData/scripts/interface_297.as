shared interface A { B@ f(); }
shared interface B { A@ f1(); C@ f2(); }
shared interface C { A@ f(); }
