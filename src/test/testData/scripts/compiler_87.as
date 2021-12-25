class BugClass
{
         int ID;
}
void CallBug( BugClass @bc )
{
         int id = bc.ID;
}
void startGame()
{
         CallBug( null );
}
