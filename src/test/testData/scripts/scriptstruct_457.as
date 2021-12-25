class Some
{
    int[] i; // need be array
}
void main()
{
    Some e;
    e=some(e); // crash
}
Some@ some(Some@ e)
{
    return e;
}
