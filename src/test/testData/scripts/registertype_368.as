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
// Global variable
  @g = @b;
  assert( g is b );
// Assignment to reference
  @func3() = @a;
  assert( g is a );
  assert( func3() is a );
// Copying the reference
  ref@ rc = rb;
  assert( rc is rb );
}
ref@ func(ref@ r) { return r; }
void func2(ref@r) { assert( r is null ); }
ref@ g;
ref@ g2 = g;
ref@& func3() { return g; }
