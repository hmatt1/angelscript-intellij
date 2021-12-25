class Object {}
Object obj;
Object@ getHandleOf() { return obj; }
Object& getReferenceOf() { return obj; }
Object getValueOf() { return obj; }
void test() {
  auto copy = obj; assert(copy is obj);
  auto@ handle = obj; assert(handle is obj);
  auto handleReturn = getHandleOf(); assert(handleReturn is obj);
  auto@ explicitHandle = getHandleOf(); assert(explicitHandle is obj);
  auto copyReturn = getReferenceOf(); assert(copyReturn is obj);
  auto valueReturn = getValueOf(); assert(valueReturn !is obj);
  auto@ handleToReference = getReferenceOf(); assert(handleToReference is obj);
  auto@ handleToCopy = getValueOf(); assert(handleToCopy !is obj);
}

