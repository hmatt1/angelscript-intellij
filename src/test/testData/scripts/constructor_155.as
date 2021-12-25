void TestConstructor()
{
  obj l_obj1;
  l_obj1.a = 5; l_obj1.b = 7;
  obj l_obj2();
  obj l_obj3(3, 4);
  a = l_obj1.a + l_obj2.a + l_obj3.a;
  b = l_obj1.b + l_obj2.b + l_obj3.b;
}
