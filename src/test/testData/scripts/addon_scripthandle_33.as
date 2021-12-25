class base {}
class derived : base {}
class unrelated {}
void fillInProperType(ref@ obj, base@& out b, unrelated@& out u)
{
	if ( obj is null )
	{
		print('obj is null');
		return;
	}
	@b = cast<base>(obj);
	@u = cast<unrelated>(obj);
	if ( b !is null )
		print('b');
	if ( u !is null )
		print('u');
}
