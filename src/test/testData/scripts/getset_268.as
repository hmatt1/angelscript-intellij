class Vector3
{
  float x;
  float y;
  float z;
};
class Hoge
{
    const Vector3 get_pos() property { return mPos; }
    const Vector3 foo() { return pos;  }
    const Vector3 zoo() { return get_pos(); }
    Vector3 mPos;
};
void main()
{
    Hoge h;
    Vector3 vec;
    vec = h.zoo();
    vec = h.foo();
}
