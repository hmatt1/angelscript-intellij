class Base {
  Base() { SetMember(); }
  void SetMember() {}
};
class Derived : Base {
   string member;
	Derived() {
     super();
	}
// Override base class SetMember method
   void SetMember() {
     member = 'hello';
   }
};
