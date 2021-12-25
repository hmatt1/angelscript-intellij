funcdef void Callback( array<int>@ pArray );
class Class
{
	private Callback@ m_pCallback;
	Callback@ Callback
	{
		get const { return m_pCallback; }
	}
	Class( Callback@ pCallback )
	{
		@m_pCallback = @pCallback;
	}
}
void CallbackFn( array<int>@ pArray )
{
	uint uiLength = pArray.length();
   g_length = uiLength;
}
uint g_length;
void test()
{
	Class instance( @CallbackFn );
	array<int> arr = {1,2,3};
	g_length = 0;
	instance.Callback( @arr );
	assert( g_length == 3 );
	g_length = 0;
	Callback@ pCallback = instance.Callback;
	pCallback( @arr );
	assert( g_length == 3 );
}
