void Test()
{
   myclass a;
   a.mthd(1);
   Assert( a.c == 4 );
   mthd2(2);
   @g = myclass();
   g.deleteGlobal();
}
class myclass
{
   void deleteGlobal()
   {
      @g = null;
      Analyze(any(@this));
   }
   void mthd(int a)
   {
      int b = 3;
      print("class:"+a+":"+b);
      myclass tmp;
      this = tmp;
      this.c = 4;
   }
   void mthd2(int a)
   {
      print("class:"+a);
   }
   int c;
};
void mthd2(int a) { print("global:"+a); }
myclass @g;
