class TestClass
{
	ArgClass @m_arg;
   CallerClass @m_caller;
	TestClass()
	{
		ArgClass _arg;
		_arg.SetWeight( 2.0f );
		@m_arg = _arg;
		m_arg.SetWeight( 3.0f );
		CallerClass _caller;
		@m_caller = _caller;
	}
	void Test()
	{
		Point pos(0.0f,0.0f,0.0f);
//////////////////////////////////////////////////
// UNCOMMENT THE NEXT TWO LINES TO MAKE IT WORK
//"		ArgClass @ap = m_arg;
//"		m_caller.DoSomething( ap, pos );
//////////////////////////////////////////////////
// THIS LINE DOESN'T WORK
		m_caller.DoSomething( m_arg, pos );
//////////////////////////////////////////////////
	}
}
void TestScript()
{
	TestClass t;
	t.Test();
}
