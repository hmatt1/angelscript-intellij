namespace n {
   interface i {}
   mixin class m {
        void f(i@) {
            i@ a;
        }
    }
}
class c : n::m {}