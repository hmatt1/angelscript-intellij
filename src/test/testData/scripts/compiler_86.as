class AAA
{
  Car @car;
  void Update()
  {
    if( car !is null )
      car.Update();
  }
}
