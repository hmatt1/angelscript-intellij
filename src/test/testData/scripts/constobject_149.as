class CTest
{
	int m_Int;

	void SetInt(int iInt)
	{
		m_Int = iInt;
	}
};
void func()
{
	const CTest Test;
	const CTest@ TestHandle = @Test;

	TestHandle.SetInt(1);
	Test.SetInt(1);
}
