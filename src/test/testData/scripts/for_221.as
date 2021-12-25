
float[] myArray(70);

float aSize = 8;

float MyFunction(float a)
{
return a;
}

void Test()
{
for (float k = 0; k< aSize; k++)
{
myArray[int(MyFunction(k*aSize))] = k;
}

for (int i = 0; i< aSize*aSize; i++)
{
//  Print("i = " + i + "\n");
myArray[i] = i;
}
}
