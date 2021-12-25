interface IMyInterface { void SomeFunc(); }
class MyBaseClass : IMyInterface { ~MyBaseClass(){ Print(); } void SomeFunc(){} }
class MyDerivedClass : MyBaseClass
{
   IMyInterface@ m_obj;
	MyDerivedClass(){}
	void SetObj( IMyInterface@ obj ) { @m_obj = obj; }
	void ClearObj(){ @m_obj = null; }
}
void SomeOtherFunction(){}
any@ GetClass(){
  MyDerivedClass x;
  any a( @x );
  return a;
}
