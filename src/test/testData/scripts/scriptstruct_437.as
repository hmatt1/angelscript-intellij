class ssNode
{
    ssNode( string Node ) { m_Node = Node; }
    string      GetNode() { return m_Node; }
    string      m_Node;
};
class ssNode_Float : ssNode
{
    ssNode_Float( string Node ) { m_Node = Node; }
}
ssNode ssCreateNode( string Node )
{
    ssNode_Float FloatNode( Node );
    return FloatNode;
}
