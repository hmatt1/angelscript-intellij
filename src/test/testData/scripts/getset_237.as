class SceneObject {}
SceneObject @object {
	get {
		return object_;
	}
}
SceneObject @object_;
void func() {
	if (@object != null) {};
}
