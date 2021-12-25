[Setting name="Format"]
string Setting_Format = "%F | %r";

void RenderMenuMain()
{
	string text = "\\$777" + Time::FormatString(Setting_Format) + " " + Icons::Clock;
	auto textSize = Draw::MeasureString(text);

	auto pos_orig = UI::GetCursorPos();
	UI::SetCursorPos(vec2(UI::GetWindowSize().x - textSize.x - 4, pos_orig.y));
	UI::Text(text);
	UI::SetCursorPos(pos_orig);
}
