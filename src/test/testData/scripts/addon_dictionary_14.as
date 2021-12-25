string testGlobalStr = 'hello';
void main()
{
   dictionary dic = {{'test', testGlobalStr}};
   string txt;
   dic.get('test', txt);
   assert( txt == 'hello' );
}
