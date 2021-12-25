class Node
{
  Node@[]@ GetSubnodes() { return subNodes; }
  Node@[] subNodes;
  int member;
}
void TestFunc(Node@ input)
{
  Node@[]@ nodearray;
  Node@ subnode;
  // Case 1. Works as expected
  @nodearray = @input.GetSubnodes();
  @subnode = @nodearray[0];
  int value1 = subnode.member; // <- ok
  assert( value1 == 42 );
  // Case 2. Wrong address sent to following operations on 'subnode'
  @subnode = @input.GetSubnodes()[0];
  int value2 = subnode.member; // <- weird behavior
  assert( value2 == 42 );
}
