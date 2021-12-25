bool[] f(10);
for (int i=0; i<10; i++) {
	f[i] = false;
}
Assert(f[0] == false);
Assert(f[1] == false);
f[0] = true;
Assert(f[0] == true);
Assert(f[1] == false);
