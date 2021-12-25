class Test
{
  Test() { dict.set('int', 1); dict.set('string', 'test'); dict.set('handle', @array<string>()); }
  dictionary dict;
}
void main()
{
  Test test = Test();
}
