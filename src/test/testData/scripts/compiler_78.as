array<string> foo = { 'a', 'b', 'c' };
dictionary d1 = { {'arr', foo} };
array<string>@ s1 = array<string>@(d1['arr']);
