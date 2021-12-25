class CTest
{
	string name;

   CTest() { name = 'temp'; print('CTest::CTest() for ' + name + '\n'); }
	CTest(string s) { name = s; print('CTest::CTest() for ' + name + '\n'); }
	~CTest(){ print('CTest::~CTest() for ' + name + '\n'); }

//	"   CTest @opAssign(const CTest &in o) { print('CTest::opAssign(), ' + name + ' becomes ' + o.name + '\n'); name = o.name; return this; }
	void test(){ print('CTest::test() for ' + name + '\n'); }
}
void test()
{
	CTest t1('Ent1');
	CTest t2('Ent2');

	t1.test();
	t2.test();

	t2 = t1;
}
