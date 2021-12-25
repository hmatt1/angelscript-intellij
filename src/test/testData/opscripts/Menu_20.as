void RenderMenu()
{
	if (UI::MenuItem("\\$0cf" + Icons::FacebookMessenger + "\\$z Chat-Button-Bar", "", Show_Chat_Button_Bar)) {
		Show_Chat_Button_Bar = !Show_Chat_Button_Bar;
	}
}