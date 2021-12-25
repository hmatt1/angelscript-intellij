#if TMNEXT
[Setting name="Show timer"]
bool showTimer = true;

[Setting name="Hide timer when interface is hidden"]
bool hideTimerWithIFace = true;

[Setting name="Anchor X position" min=0 max=1]
float anchorX = .5;

[Setting name="Anchor Y position" min=0 max=1]
float anchorY = .987;

[Setting name="Font size" min=8 max=72]
int fontSize = 24;

[Setting color name="Timer color"]
vec4 colorNormal = vec4(1, 1, 1, 1);

bool inGame = false;
int preCPIdx = -1;
uint64 lastCPTime = 0;
int respawnCount = -1;
uint64 timeShift = 0;

string infos;
int medal = -1;

const array<vec4> medals = {
  vec4(0, 0, 0, 0), // no medal
  vec4(0.604, 0.400, 0.259, 1), // bronze medal
  vec4(0.537, 0.604, 0.604, 1), // silver medal
  vec4(0.871, 0.737, 0.259, 1), // gold medal
  vec4(0.000, 0.471, 0.035, 1), // author medal
};

void RenderMenu() 
{
	if (UI::MenuItem("\\$09f" + Icons::Flag + "\\$z No-Respawn Timer", "", showTimer)) 
		showTimer = !showTimer;
}

void Render() 
{
	if (showTimer && inGame)
	{
		nvg::FontSize(fontSize);
		nvg::TextAlign(nvg::Align::Center | nvg::Align::Middle);
		nvg::FillColor(colorNormal);
		vec2 sz = nvg::TextBounds(infos);
		nvg::TextBox(anchorX * Draw::GetWidth() - sz.x / 2 - 2, anchorY * Draw::GetHeight(), sz.x + 4, infos);
		if (medal >= 0)
		{
			nvg::BeginPath();
            nvg::Ellipse(vec2(anchorX * Draw::GetWidth() - sz.x / 2 - sz.y, anchorY * Draw::GetHeight() - 1), sz.y / 2.5, sz.y / 2.5);
            nvg::FillColor(medals[medal]);
            nvg::Fill();
            nvg::ClosePath();
			nvg::BeginPath();
            nvg::Ellipse(vec2(anchorX * Draw::GetWidth() + sz.x / 2 + sz.y, anchorY * Draw::GetHeight() - 1), sz.y / 2.5, sz.y / 2.5);
            nvg::FillColor(medals[medal]);
            nvg::Fill();
            nvg::ClosePath();
		}
	}
}

void Update(float dt) 
{
	auto playground = cast<CSmArenaClient>(GetApp().CurrentPlayground);

	if (playground is null
		|| playground.Arena is null
		|| playground.Map is null
		|| playground.GameTerminals.Length <= 0
		|| (playground.GameTerminals[0].UISequence_Current != CGamePlaygroundUIConfig::EUISequence::Playing
			&& playground.GameTerminals[0].UISequence_Current != CGamePlaygroundUIConfig::EUISequence::Finish
			&& playground.GameTerminals[0].UISequence_Current != CGamePlaygroundUIConfig::EUISequence::EndRound) )
	{
		inGame = false;
		preCPIdx = -1;
		return;
	}
	
	auto player = cast<CSmPlayer>(playground.GameTerminals[0].GUIPlayer);
	auto scriptPlayer = player is null ? null : player.ScriptAPI;
	int64 raceTime = 0;
	
	if (playground.GameTerminals[0].UISequence_Current != CGamePlaygroundUIConfig::EUISequence::EndRound)
	{
		if (scriptPlayer is null) 
		{
			inGame = false;
			preCPIdx = -1;
			return;
		}
		
		raceTime = GetRaceTime(scriptPlayer);

		if (player.CurrentLaunchedRespawnLandmarkIndex == uint(-1) || raceTime <= 0) 
		{
			inGame = false;
			preCPIdx = -1;
			return;
		}
	}

	// in game only if interface displayed or don't care
	inGame = !hideTimerWithIFace || (playground.Interface !is null && Dev::GetOffsetUint32(playground.Interface, 0x1C) != 0);
	
	if (playground.GameTerminals[0].UISequence_Current == CGamePlaygroundUIConfig::EUISequence::Playing)
	{
		if (preCPIdx == -1)
		{
			// starting => no time shift, no respawn yet
			timeShift = respawnCount = 0;
			infos = "";
			medal = -1;
			preCPIdx = player.CurrentLaunchedRespawnLandmarkIndex;
		}
		else
		{
			if (preCPIdx != int(player.CurrentLaunchedRespawnLandmarkIndex))
			{
				// changing CP => save last CP time with time shift
				preCPIdx = player.CurrentLaunchedRespawnLandmarkIndex;
				lastCPTime = raceTime - timeShift - 1000; // 1000 = 3 - 2 - 1 delay
			}
			if (respawnCount != int(scriptPlayer.Score.NbRespawnsRequested))
			{
				// changing respawn count => time shift recalculated so that timer will be reset to last CP time 
				respawnCount = scriptPlayer.Score.NbRespawnsRequested;
				timeShift = raceTime - lastCPTime;
			}
		}

		if (respawnCount > 0)
			// display timer only if at least one respawn
			infos = FormatTime(raceTime - timeShift);
	}
	else if (preCPIdx != -1)
	{
		preCPIdx = -1;
		if (respawnCount > 0)
		{
			infos = FormatTime(raceTime - timeShift) + " (" + respawnCount + " respawn" + (respawnCount > 1 ? "s" : "") + ")";
			
			auto app = cast<CTrackMania>(GetApp());
			auto map = app.RootMap;
			if (map.TMObjective_AuthorTime >= uint(raceTime - timeShift))
				medal = 4;
			else if (map.TMObjective_GoldTime >= uint(raceTime - timeShift))
				medal = 3;
			else if (map.TMObjective_SilverTime >= uint(raceTime - timeShift))
				medal = 2;
			else if (map.TMObjective_BronzeTime >= uint(raceTime - timeShift))
				medal = 1;
			else
				medal = 0;
		}
	}
}

int64 GetRaceTime(CSmScriptPlayer& scriptPlayer)
{
	if (scriptPlayer is null)
		// not playing
		return 0;
	
	auto playgroundScript = cast<CSmArenaRulesMode>(GetApp().PlaygroundScript);

	if (playgroundScript is null)
		// Online 
		return GetApp().Network.PlaygroundClientScriptAPI.GameTime - scriptPlayer.StartTime;
	else
		// Solo
		return playgroundScript.Now - scriptPlayer.StartTime;
}

string FormatTime(uint64 time)
{
	string str = "";
	double tm = time / 1000.0;

	int hundredth = int((tm % 1.0) * 100);
	int seconds = int(tm % 60);
	int minutes = int(tm / 60) % 60;
	int hours = int(tm / 60 / 60);

	if (hours > 0) str += hours + ":";
	str += PadNumber(minutes) + ":";
	str += PadNumber(seconds) + ".";
	str += PadNumber(hundredth);

	return str;
}

string PadNumber(int number)
{
	if (number < 10)
		return "0" + number;
	else
		return "" + number;
}

#else

void Main() 
{
	print("This plugin only works with TM 2020 !");
}

#endif