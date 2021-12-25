int calls = 0;
class Value
{
  int val;
  Value(int v) {val = v;}
  Value() {}
  Value &opAssign(const Value &in o) { calls++; return this; }
}
