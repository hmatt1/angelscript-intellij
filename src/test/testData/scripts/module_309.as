class ssBlock
{
    ssNode@    GetNode() { return ssCreateNode(); }
};
class ssNode
{
    ssBlock GetBlock() { return ssBlock(); }
};
class ssNode_Float : ssNode
{
}
ssNode@ ssCreateNode()
{
    ssNode_Float FloatNode();
    return FloatNode;
}
