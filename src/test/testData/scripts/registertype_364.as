class NoRef
{
         Widget @no_ref_count;
}
void startGame()
{
         NoRef nr;
         @nr.no_ref_count = CreateWidget();
         NoRef nr2 = nr;
}
