class MyObj { MyObj() { a = g_a; b = g_b; } int a; int b; }
int g_a = 314 + g_b;
MyObj obj();
int g_b = 42;
