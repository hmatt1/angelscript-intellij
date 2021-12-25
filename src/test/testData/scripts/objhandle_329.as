class C {int val; C() {val = 0;}}
class D {C c;}
C g;
void Test()
{
   Func(@g);
   Assert(g.val == 1);
   D d;
   Func(@d.c);
   C[] a1(1);
   Func(@a1[0]);
   Assert(a1[0].val == 1);
   C@[] a2(1);
   @a2[0] = @C();
   Func(@a2[0]);
   Assert(a2[0].val == 1);
}
void Func(C@ c) {c.val = 1;}
