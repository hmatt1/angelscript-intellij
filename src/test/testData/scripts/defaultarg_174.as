class monster
{
 int level;
 void calculate_necessary_experience(int level_to_check=this.level)
 {
  level_to_check=1;
 }
 void act()
 {
  calculate_necessary_experience();
 }
}
