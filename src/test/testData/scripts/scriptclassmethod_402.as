class Set
{
   Set(int a) {print("Set::Set");}
};
class Test
{
   void Set(int a) {print("Test::Set");}
   void Test2()
   {
      int a = 0;
// Call class method
      Set(a);
// Call Set constructor
      ::Set(a);
   }
}
