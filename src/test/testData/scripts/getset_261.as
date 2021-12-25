class Test {
 int a;
 Test @member;
 int get_a() const property { return a; }
 void set_a(int val) property {a = val; if( member !is null ) member.a = val;}
}
