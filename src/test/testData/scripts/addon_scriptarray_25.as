enum fruit
{
  APPLE, ORANGE, BANANA
}
void main()
{
  fruit[] basket;
  basket.insertLast(APPLE);
  basket.insertLast(ORANGE);
  basket.sortDesc();
  int index = basket.find(APPLE);
  assert( index == 1 );
}
