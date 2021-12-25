// shebang directive is removed by preprocessor
#!asrun
// Global functions can have meta data
[ my meta data test ] /* separated by comment */ [second data] void func1() {}
// meta data strings can contain any tokens, and can use nested []
[ test['hello'] ] void func2() {}
// global variables can have meta data
[ init ] int g_var = 0;
// Parts of the code can be excluded through conditional compilation
#if DONTCOMPILE
  // This code should be excluded by the CScriptBuilder
  #if NESTED
   //  Nested blocks are also possible
  #endif
  // Nested block ended
#endif
// global object variable
[ var of type myclass ] MyClass g_obj();
// class declarations can have meta data
#if COMPILE
[ myclass ] class MyClass {}
 #if NESTED
   // dont compile this nested block
 #endif
#endif
// class properties can also have meta data
[ myclass2 ]
class MyClass2 {
 [ edit ]
 int a;
 int func() {
   return 0;
 }
 [ noedit ] int b;
 [ edit,c ]
 complex c;
 [ prop ]
 complex prop { get {return c;} set {c = value;} }
}
// interface declarations can have meta data
[ myintf ] interface MyIntf {}
// arrays must still work
int[] arr = {1, 2, 3};
int[] @arrayfunc(int[] @a) { a.resize(1); return a; }
// directives in comments should be ignored
/*
#include "dont_include"
*/
// namespaces can also contain entities with metadata
namespace NS {
 [func] void func() {}
 [metaclass] class MetaClass {}
}