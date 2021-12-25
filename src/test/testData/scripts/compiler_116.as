class Test
{
  const string @get_id() property
  {
    return @'test';
  }
}
void getClauseDesc(const string &in s)
{
}
void main()
{
  Test t;
  getClauseDesc(t.id);
}
