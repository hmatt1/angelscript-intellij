refclass@ g;
refclass@ c = @g;
class t
{
  refclass @m;
  void test() {Assert(@m != null);}
}
void TestObjHandle()
{
   refclass@ b = @refclass();
// Should generate an exception
// as g isn't initialized yet.
//"   g = b;
//"   b = g;
// Do a handle assignment
   @g = @b;
// Now an assignment to g is possible
   g = b;
// Compare with null
   if( @g != null ) {}
   if( null != @g ) {}
// Compare with another object
   if( @g == @b ) {}
   if( @b == @g ) {}
// Value comparison
//"   if( g == b );
//"   if( b == g );
// Assign null to release the object
   @g = null;
   @g = @b;
// Operators
   b = g + b;
// parameter references
   @g = null;
   TestObjHandleRef(b, @g);
   Assert(@g == @b);
// return handles
   @g = null;
   @g = @TestObjReturnHandle(b);
   Assert(@g == @b);
   Assert(@TestReturnNull() == null);
   Assert(@TestObjReturnHandle(b) != null);
// Test for class members
   t cl;
   @cl.m = @TestObjReturnHandle(b);
   Assert(@cl.m != null);
   cl.test();
}
void TestObjHandleRef(refclass@ i, refclass@ &out o)
{
   @o = @i;
}
refclass@ TestObjReturnHandle(refclass@ i)
{
   return i;
}
refclass@ TestReturnNull()
{
   return null;
}
// Make sure the handle can be explicitly taken for class properties, array members, and global variables
