#name "Author-Time"
#author "RoboTec13"
#category "Race"

// Step of the tutorial we're in:
string author = "0";
Resources::Texture@ authorIcon;

void Main()
{
  @authorIcon = Resources::GetTexture("AT-Icon.png");
  while (true) {
    CGameCtnApp@ app = GetApp();
    if (app.RootMap !is null) {
      if (app.RootMap.ChallengeParameters.IsValidatedForScriptModes)
        author = app.RootMap.ChallengeParameters.AuthorTime + "";
      else
        author = "No AT";
    } else {
      author = "0";
    }
    sleep(1000);
  }
}

void Render()
{
    // hide if unwanted
  if (Setting_Show_Author_Plugin && author != "0") {
		string authorTimeString = author;
    if (GetApp().RootMap.ChallengeParameters.IsValidatedForScriptModes) authorTimeString = "\\$fff" + Time::Format(Text::ParseInt(author));
    UI::Begin("Author-Time", UI::WindowFlags::NoCollapse | UI::WindowFlags::NoResize);
    if (UI::IsItemHovered()) {
      Setting_View_AuthorPos = UI::GetWindowPos();
    }
    UI::SetWindowPos(Setting_View_AuthorPos);
    UI::SetWindowSize(vec2(90, 56));
		UI::Image(authorIcon,vec2(15,15));
		UI::SameLine();
    UI::Text(authorTimeString);
    UI::End();
	}
}

void RenderMenu()
{
    // add menu items to go to the right Tutorial Steps
    if (UI::MenuItem("\\$0f6" + Icons::FlagCheckered + "\\$z Author-Time", "", Setting_Show_Author_Plugin)) {
		    Setting_Show_Author_Plugin = !Setting_Show_Author_Plugin;
	  }
}
