[Setting name="Rotation Step (default = 0.262)"]
float custom_step = 0.0262;

void RenderInterface()
{
	auto app = GetApp();
	auto editor = cast<CGameCtnEditorFree>(app.Editor);
		
	if (editor is null)
		return;
	
	auto cursor = cast<CGameCursorBlock>(editor.Cursor);
	if(cursor is null)
		return;
		
	//if(!cursor.UseFreePos)
	//	return;

	UI::Begin("Roll/Pitch Setter");
		cursor.Pitch = UI::SliderFloat("Pitch", cursor.Pitch, 0.0, 2*3.14);
		cursor.Roll = UI::SliderFloat("Roll", cursor.Roll, 0.0, 2*3.14);
		custom_step = UI::InputFloat("Custom Step", custom_step, 0.0);
		UI::Text("Up --> I\nDown --> K\nLeft --> J \nRight --> L");
	UI::End();
}

bool OnKeyPress(bool down, VirtualKey key)
{
	auto app = GetApp();
	auto editor = cast<CGameCtnEditorFree>(app.Editor);
		
	if (editor is null)
		return false;
	
	auto cursor = cast<CGameCursorBlock>(editor.Cursor);
	if(cursor is null)
		return false;
		
	//if(!cursor.UseFreePos)
	//	return false;

	if(key == VirtualKey::I && down)
		cursor.Pitch += custom_step;

	if(key == VirtualKey::K && down)
		cursor.Pitch += -custom_step;
		
	if(key == VirtualKey::L && down)
		cursor.Roll += custom_step;

	if(key == VirtualKey::J && down)
		cursor.Roll += -custom_step;
		
	
	return true;
}
