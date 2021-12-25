enum MyEnum { MyEnumValue = 1 }
void Update()
{
        MyEnum enumValue = MyEnumValue;
        bool condition = true;
        if (condition)
        {
                if(enumValue is MyEnumValue)
                {
                        int i = 0;
                }
        }
        else
        {
                int j = 1;
        }
}
