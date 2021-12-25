array<TestScript@> arr;
class TestScript
{
         TestScript()
         {
                  arr.insertLast( this );
         }
}
void startGame()
{
         TestScript @t = TestScript();
}