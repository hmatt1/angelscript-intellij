void Init()
{
  CObj someObj;
  CVec3 someVec;
  someVec = someObj.simplevec + someObj.constvec;
  someVec = vec3add(someObj.simplevec,someObj.constvec);
}
