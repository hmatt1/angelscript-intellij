class InternalClass
{
	InternalClass()
	{
		m_x = 3;
       m_y = 773456;
	}

	int8 m_x;
   int m_y;
}
class MyClass
{
	MyClass()
	{
      m_c = InternalClass();
	}
	void Test()
	{
		Assert( m_c.m_x == 3 );
       Assert( m_c.m_y == 773456 );
	}
	InternalClass m_c;
}
