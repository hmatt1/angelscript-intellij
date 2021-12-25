#name "Personal-Best-Time"
#author "RoboTec13"
#category "Race"

// Step of the tutorial we're in:
string map = "-1";
int pb = -1;
int medal = -1;
bool loadPb = true;
bool lastStatusFinish = false;
Resources::Texture@ authorIcon;
Resources::Texture@ goldIcon;
Resources::Texture@ silverIcon;
Resources::Texture@ bronzeIcon;
Resources::Texture@ noMedalIcon;

void Main()
{
  //load Icons
  @authorIcon = Resources::GetTexture("AT-Icon.png");
  @goldIcon = Resources::GetTexture("Gold-Icon.png");
  @silverIcon = Resources::GetTexture("Silver-Icon.png");
  @bronzeIcon = Resources::GetTexture("Bronze-Icon.png");
  @noMedalIcon = Resources::GetTexture("NoMedal-Icon.png");
  //Logic
  while (true) {
    CTrackMania@ app = cast<CTrackMania>(GetApp());
	if (app.RootMap !is null) {
		string currentMap = app.RootMap.MapInfo.MapUid;
		if (currentMap != map) {
			map = currentMap;
			setNewPbAndMedalInformation(app);
		}
		if (isFinished(app) && loadPb) {
			sleep(1000);
			setNewPbAndMedalInformation(app);
		}
	} else {
		pb = -1;
		medal = -1;
		map = "-1";
	}
	sleep(100);
  }
}

//
void setNewPbAndMedalInformation(CTrackMania@ app) {
	CGamePlayerInfo@ playerInfo = cast<CTrackManiaNetwork@>(app.Network).PlayerInfo;
	if (app.Network.ClientManiaAppPlayground !is null) {
		pb = app.Network.ClientManiaAppPlayground.ScoreMgr.Map_GetRecord_v2(playerInfo.Id, app.RootMap.MapInfo.MapUid, "PersonalBest", "", "TimeAttack", "");
		medal = app.Network.ClientManiaAppPlayground.ScoreMgr.Map_GetMedal(playerInfo.Id, app.RootMap.MapInfo.MapUid, "PersonalBest", "", "TimeAttack", "");
	}
	loadPb = false;
}

// RenderInterface to hide it when the overlay isn't open
// as you need the overlay to go from step to step regardless.
void Render()
{
    // hide if unwanted
    if (Setting_Show_PB_Plugin && medal != -1) {
		string pbTimeString = getPbTimeString();
        UI::Begin("PB", UI::WindowFlags::NoCollapse | UI::WindowFlags::NoResize);
		if (UI::IsItemHovered()) {
      		Setting_View_Pos = UI::GetWindowPos();
    	}
		UI::SetWindowPos(Setting_View_Pos);
        UI::SetWindowSize(vec2(90, 56));
		UI::Image(getMedalIcon(),vec2(15,15));
		UI::SameLine();
        UI::Text(pbTimeString);
        UI::End();
	}
}

void RenderMenu()
{
    // add menu items to go to the right Tutorial Steps
	if (UI::MenuItem("\\$fff" + Icons::FlagCheckered + "\\$z Personal Best", "", Setting_Show_PB_Plugin)) {
		Setting_Show_PB_Plugin = !Setting_Show_PB_Plugin;
	}
}

Resources::Texture@ getMedalIcon() {
	switch(medal) {
		case 1: return bronzeIcon;
		case 2: return silverIcon;
		case 3: return goldIcon;
		case 4: return authorIcon;
	}
	return noMedalIcon;
}

string getPbTimeString() {
	string pbTimeString = "\\$fffNo PB";
	if (pb != -1) {
		pbTimeString = "\\$fff" + Time::Format(pb);
	}
	return pbTimeString;
}

bool isFinished(CTrackMania@ app) {
	if (GetCurrentPlayground() !is null && app.CurrentPlayground.GameTerminals.Length > 0) {
		CGameTerminal@ terminal = app.CurrentPlayground.GameTerminals[0];
		CGameTerminal::ESGamePlaygroundUIConfig__EUISequence raceStatus = terminal.UISequence_Current;
		if (raceStatus == CGameTerminal::ESGamePlaygroundUIConfig__EUISequence::Finish && !lastStatusFinish && !loadPb) {
			lastStatusFinish = true;
			loadPb = true;
			return true;
		} else {
			if (raceStatus != CGameTerminal::ESGamePlaygroundUIConfig__EUISequence::Finish) {
				lastStatusFinish = false;
			}
			return false;
		}
	}
	return false;
}
