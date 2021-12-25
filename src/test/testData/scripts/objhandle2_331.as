void TestObjHandle()
{
   refclass@ b = @getRefClass();
   Assert(b.id == int(0xdeadc0de));
// Pass argument with explicit handle
   refclass@ c = @getRefClass(@b);
   Assert(@c == @b);
// Pass argument with implicit handle
   @c = @getRefClass(b);
   Assert(@c == @b);
// Pass argument with implicit in reference to handle
   t(b);
// Pass argument with explicit in reference to handle
   t(@b);
// Pass argument with implicit out reference to handle
   s(b);
// Pass argument with explicit out reference to handle
   s(@b);
// Handle assignment
   @c = @b;
   @c = b;
// Handle comparison
   @c == @b;
}
void t(refclass@ &in a)
{
}
void s(refclass@ &out a)
{
}
