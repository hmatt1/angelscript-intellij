class Obj {
  uint16 prop {
    get { return _prop; }
    set { _prop = value; }
  }
  uint16 _prop = 0;
}
Obj @get_Objs(uint idx) property {
  return _obj;
}
Obj @_obj = Obj();
