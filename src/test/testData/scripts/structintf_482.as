struct MyStruct
{
   float a;
   string b;
   string @c;
};
void Test()
{
   MyStruct s;
   s.a = 3.141592f;
   s.b = "test";
   @s.c = "test2";
   g_any.store(@s);
}
