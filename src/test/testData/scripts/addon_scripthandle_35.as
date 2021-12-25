class A {}
class B {}
void main()
{
  ref@ ra, rb;
  A a; B b;
// Assignment of reference
  @ra = @a;
  assert( ra is a );
  @rb = @b;
// Casting to reference
  A@ ha = cast<A>(ra);
  assert( ha !is null );
  B@ hb = cast<B>(ra);
  assert( hb is null );
// Assigning null, and comparing with null
  @ra = null;
  assert( ra is null );
  func2(ra);
// Handle assignment with explicit handle
  @ra = @rb;
  assert( ra is b );
  assert( rb is b );
  assert( ra is rb );
// Handle assignment with implicit handle
  @rb = rb;
  assert( rb is b );
  assert( ra is rb );
// Function call and return value
  @rb = func(rb);
  assert( rb is b );
  assert( func(rb) is b );
// Arrays of handles
  array<ref@> arr(2);
  assert( arr[0] is null );
  @arr[0] = a;
  @arr[1] = a;
  assert( arr[0] is arr[1] );
  assert( arr[0] is a );
// Implicit conv from type to ref
  func2(null);
  func(a);
  assert( func(a) is a );
}
ref@ func(ref@ r) { return r; }
void func2(ref@r) { assert( r is null ); }
interface ITest {}
class CBase {}
class CTest : ITest, CBase
{
  int val;
  CTest()
  {
    val = 42;
  }
}
