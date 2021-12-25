void Test()
{
  dictionary dict;
// Test integer with the dictionary
  dict.set('a', 42);
  assert(dict.exists('a'));
  uint u = 0;
  dict.get('a', u);
  assert(u == 42);
  dict.delete('a');
  assert(!dict.exists('a'));
// Test array by handle
  array<string> a = {'t'};
  dict.set('a', @a);
  array<string> @b;
  dict.get('a', @b);
  assert(b == a);
// Test string by value
  dict.set('a', 't');
  string c;
  dict.get('a', c);
  assert(c == 't');
// Test int8 with the dictionary
  int8 q = 41;
  dict.set('b', q);
  dict.get('b', q);
  assert(q == 41);
// Test float with the dictionary
  float f = 300;
  dict.set('c', f);
  dict.get('c', f);
  assert(f == 300);
// Test automatic conversion between int and float in the dictionary
  int i;
  dict.get('c', i);
  assert(i == 300);
  dict.get('b', f);
  assert(f == 41);
// Test booleans with the variable type
  bool bl;
  dict.set('true', true);
  dict.set('false', false);
  bl = false;
  dict.get('true', bl);
  assert( bl == true );
  dict.get('false', bl);
  assert( bl == false );
// Test circular reference with itself
  dict.set('self', @dict);
// Test the keys
  array<string> @keys = dict.getKeys();
  assert( keys.find('a') != -1 );
  assert( keys.length() == 6 );
}
