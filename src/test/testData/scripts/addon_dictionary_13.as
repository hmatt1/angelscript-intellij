void main()
{
 dictionary test;
 test.set('test', 'something');
 string output;
 test.get('test', output);
 assert(output == 'something');
}
