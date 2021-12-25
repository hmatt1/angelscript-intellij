class Value
{
  int val;
  Value(int v) {val = v;}
  Value() {}
  int opCmp(const Value &in o) {return val - o.val;}
}
