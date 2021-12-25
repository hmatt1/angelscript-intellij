bool alreadyCalled = false;
class CBar
{
 CBar()
 {
  assert(alreadyCalled == false);
  alreadyCalled = true;
 }
 void Foo()
 {
 }
};
class CDerivedBar : CBar
{
 CDerivedBar()
 {
 }
 private void ImNotAnOverrideOfTheBaseClass()
 {
 }
 private void Foo()
 {
 }
};
