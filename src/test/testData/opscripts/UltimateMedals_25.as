
/* TODO:
 - button for tm.io and tmx?
 - hide window for when all medals are -1
 - auto-chat the times on click?
 - font/window scaling
*/

[Setting category="Medals" name="Show Header"]
bool showHeader = true;

[Setting category="Medals" name="Show Personal Best"]
bool showPbest = true;

#if TMNEXT||MP4
[Setting category="Medals" name="Show Author"]
bool showAuthor = true;

#elif TURBO
[Setting category="Medals" name="Show Super Trackmaster" description="Super medals will automatically be hidden on non-campaign tracks."]
bool showStmaster = true;

[Setting category="Medals" name="Show Super Gold"]
bool showSgold = false;

[Setting category="Medals" name="Show Super Silver"]
bool showSsilver = false;

[Setting category="Medals" name="Show Super Bronze"]
bool showSbronze = false;

[Setting category="Medals" name="Show Trackmaster"]
bool showTmaster = true;
#endif

[Setting category="Medals" name="Show Gold"]
bool showGold = true;

[Setting category="Medals" name="Show Silver"]
bool showSilver = true;

[Setting category="Medals" name="Show Bronze"]
bool showBronze = true;

[Setting category="Additional Info" name="Show Map Name"]
bool showMapName = false;

[Setting category="Additional Info" name="Show Author Name"]
bool showAuthorName = false;

/*Icons::InfoCircle*/
[Setting category="Additional Info" name="Show Map Comment on Hover" description="An 'i' icon will appear next to the map name or author name, if a comment is available."]
bool showComment = false;

[Setting category="Additional Info" name="Show Personal Best Delta Time"]
bool showPbestDelta = false;

[Setting category="Additional Info" name="Show Personal Best Negative Delta Time"]
bool showPbestDeltaNegative = true;

[Setting category="Display Settings" name="Window visible" description="To adjust the position of the window, click and drag while the Openplanet overlay is visible."]
bool windowVisible = true;

[Setting category="Display Settings" name="Hide on hidden interface"]
bool hideWithIFace = false;

[Setting category="Display Settings" name="Window position"]
vec2 anchor = vec2(0, 170);

[Setting category="Display Settings" name="Lock window position" description="Prevents the window moving when click and drag or when the game window changes size."]
bool lockPosition = false;



const array<string> medals = {
  "\\$444" + Icons::Circle + "\\$z", // no medal
  "\\$964" + Icons::Circle + "\\$z", // bronze medal
  "\\$899" + Icons::Circle + "\\$z", // silver medal
  "\\$db4" + Icons::Circle + "\\$z", // gold medal
#if TMNEXT||MP4
  "\\$071" + Icons::Circle + "\\$z", // author medal
#elif TURBO
  "\\$0f1" + Icons::Circle + "\\$z", // trackmaster medal
  "\\$964" + Icons::Circle + "\\$z", // super bronze medal
  "\\$899" + Icons::Circle + "\\$z", // super silver medal
  "\\$db4" + Icons::Circle + "\\$z", // super gold medal
  "\\$0ff" + Icons::Circle + "\\$z", // super trackmaster medal
#endif
};

class Record {
  string name;
  uint medal;
  int time;
  string style;
  bool hidden;
  
  Record(string name = "Unknown", uint medal = 0, int time = -1, string style = "\\$fff") {
    this.name = name;
    this.medal = medal;
    this.time = time;
    this.style = style;
    this.hidden = false;
  }
  
  string NameString() {
    return medals[this.medal] + " " + this.style + this.name + "\\$z";
  }
  
  string TimeString() {
    return this.style + (this.time > 0 ? Time::Format(this.time) : "-:--.---") + "\\$z";
  }
  
  string DeltaString(Record@ other) {
    if (this is other || other.time <= 0) {
      return "";
    }

    int delta = other.time - this.time;
    if (delta < 0) {
      if (!showPbestDeltaNegative) {
        return "";
      }
      return "\\$77f-" + Time::Format(delta * -1);
    }
    return "\\$f77+" + Time::Format(delta);
  }
  
  int opCmp(Record@ other) {
    // like normal, except consider negatives to be larger than positives
    if((this.time >= 0) == (other.time >= 0)) {
      return this.time - other.time;
    } else {
      return other.time - this.time;
    }
  }
}

#if TMNEXT||MP4
Record@ author = Record("Author", 4, -5);
#elif TURBO
Record@ stmaster = Record("S. Trackmaster", 8, -9);
Record@ sgold = Record("S. Gold", 7, -8);
Record@ ssilver = Record("S. Silver", 6, -7);
Record@ sbronze = Record("S. Bronze", 5, -6);
Record@ tmaster = Record("Trackmaster", 4, -5);
#endif
Record@ gold = Record("Gold", 3, -4);
Record@ silver = Record("Silver", 2, -3);
Record@ bronze = Record("Bronze", 1, -2);
Record@ pbest = Record("Pers. Best", 0, -1, "\\$0ff");

#if TMNEXT||MP4
array<Record@> times = {author, gold, silver, bronze, pbest};
#elif TURBO
array<Record@> times = {stmaster, sgold, ssilver, sbronze, tmaster, gold, silver, bronze, pbest};

bool campaignMap = false;
#endif

int timeWidth = 53;
int deltaWidth = 60;


void RenderMenu() {
  if(UI::MenuItem("\\$db4" + Icons::Circle + "\\$z Medals Window", "", windowVisible)) {
    windowVisible = !windowVisible;
  }
}

void Render() {
  auto app = cast<CTrackMania>(GetApp());
  
#if TMNEXT||MP4
  auto map = app.RootMap;
#elif TURBO
  auto map = app.Challenge;
#endif
  
  if(hideWithIFace) {
    auto playground = app.CurrentPlayground;
    if(playground is null || playground.Interface is null || Dev::GetOffsetUint32(playground.Interface, 0x1C) == 0) {
      return;
    }
  }
  
  if(windowVisible && map !is null && map.MapInfo.MapUid != "" && app.Editor is null) {
    if(lockPosition) {
      UI::SetNextWindowPos(int(anchor.x), int(anchor.y), UI::Cond::Always);
    } else {
      UI::SetNextWindowPos(int(anchor.x), int(anchor.y), UI::Cond::FirstUseEver);
    }
    
    int windowFlags = UI::WindowFlags::NoTitleBar | UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoDocking;
    if (!UI::IsOverlayShown()) {
        windowFlags |= UI::WindowFlags::NoInputs;
    }
    
    UI::Begin("Ultimate Medals", windowFlags);
    
    if(!lockPosition) {
      anchor = UI::GetWindowPos();
    }
    
    bool hasComment = string(map.MapInfo.Comments).Length > 0;
    
    UI::BeginGroup();
    if((showMapName || showAuthorName) && UI::BeginTable("header", 1, UI::TableFlags::SizingFixedFit)) {
      if(showMapName) {
        UI::TableNextRow();
        UI::TableNextColumn();
#if TURBO
        UI::Text((campaignMap ? "#" : "") + StripFormatCodes(map.MapInfo.Name) + (hasComment && !showAuthorName ? " \\$68f" + Icons::InfoCircle + "\\$z" : ""));
#else
        UI::Text(StripFormatCodes(map.MapInfo.Name) + (hasComment && !showAuthorName ? " \\$68f" + Icons::InfoCircle + "\\$z" : ""));
#endif
      }
      if(showAuthorName) {
        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("\\$888by " + map.MapInfo.AuthorNickName + (hasComment ? " \\$68f" + Icons::InfoCircle : "") + "\\$z");
      }
      UI::EndTable();
    }
    
    int numCols = 2;
    if (showPbestDelta) {
      numCols = 3;
    }
    if(UI::BeginTable("table", numCols, UI::TableFlags::SizingFixedFit)) {
      if(showHeader) {
        UI::TableNextRow();
        UI::TableNextColumn();
        setMinWidth(0);
        UI::Text("Medal");
        UI::TableNextColumn();
        setMinWidth(timeWidth);
        UI::Text("Time");
        if (showPbestDelta) {
          UI::TableNextColumn();
          setMinWidth(deltaWidth);
          UI::Text("Delta");
        }
      }
      
      for(uint i = 0; i < times.Length; i++) {
        if(times[i].hidden) {
          continue;
        }
        UI::TableNextRow();
        UI::TableNextColumn();
#if TURBO
        if(5 <= times[i].medal && times[i].medal <= 7) {
          UI::PushStyleVar(UI::StyleVar::ItemSpacing, vec2(0, -16)); // 16 is the default font size
          UI::Text(times[i].NameString());
          UI::Text("\\$0f1" + Icons::CircleO + "\\$z");
          UI::PopStyleVar();
        } else {
          UI::Text(times[i].NameString());
        }
#else
        UI::Text(times[i].NameString());
#endif
        UI::TableNextColumn();
        UI::Text(times[i].TimeString());

        if (showPbestDelta) {
          UI::TableNextColumn();
          UI::Text(times[i].DeltaString(pbest));
        }
      }
      
      UI::EndTable();
    }
    UI::EndGroup();
    
    if(hasComment && showComment && UI::IsItemHovered()) {
      UI::BeginTooltip();
#if NEXT
      UI::PushTextWrapPos(200);
      UI::TextWrapped(map.MapInfo.Comments);
      UI::PopTextWrapPos();
#else
      // Wrapping currently unavailable for MP4 and TURBO
      UI::Text(map.MapInfo.Comments);
#endif
      UI::EndTooltip();
    }
    
    UI::End();
  }
}

void setMinWidth(int width) {
  UI::PushStyleVar(UI::StyleVar::ItemSpacing, vec2(0, 0));
  UI::Dummy(vec2(width, 0));
  UI::PopStyleVar();
}

void Main() {
  auto app = cast<CTrackMania>(GetApp());
  auto network = cast<CTrackManiaNetwork>(app.Network);
  
#if TURBO
  TurboSTM::Initialize();
#endif
  
  while(true) {
#if TMNEXT||MP4
    auto map = app.RootMap;
#elif TURBO
    auto map = app.Challenge;
#endif
    
    if(windowVisible && map !is null && map.MapInfo.MapUid != "" && app.Editor is null) {
#if TMNEXT||MP4
      author.time = map.TMObjective_AuthorTime;
      author.hidden = !showAuthor;
#elif TURBO
      int mapNumber = Text::ParseInt(map.MapName);
      campaignMap = mapNumber != 0 && map.MapInfo.AuthorLogin == "Nadeo";
      
      auto super = TurboSTM::GetSuperTime(mapNumber);
      tmaster.time = map.TMObjective_AuthorTime;
      tmaster.hidden = !showTmaster;
      if(super !is null && campaignMap) {
        // we check campaignMap so that a successful parse on a different map doesn't give a false positive
        stmaster.time = int(super.m_time);
        stmaster.hidden = !showStmaster;
        auto delta = tmaster.time - stmaster.time;
        sgold.time = stmaster.time + delta/8;
        sgold.hidden = !showSgold;
        ssilver.time = stmaster.time + delta/4;
        ssilver.hidden = !showSsilver;
        sbronze.time = stmaster.time + delta/2;
        sbronze.hidden = !showSbronze;
      } else {
        stmaster.time = -9;
        stmaster.hidden = true;
        sgold.time = -8;
        sgold.hidden = true;
        ssilver.time = -7;
        ssilver.hidden = true;
        sbronze.time = -6;
        sbronze.hidden = true;
      }
#endif
      gold.time = map.TMObjective_GoldTime;
      gold.hidden = !showGold;
      silver.time = map.TMObjective_SilverTime;
      silver.hidden = !showSilver;
      bronze.time = map.TMObjective_BronzeTime;
      bronze.hidden = !showBronze;
      
#if TMNEXT
      if(network.ClientManiaAppPlayground !is null) {
        auto scoreMgr = network.ClientManiaAppPlayground.ScoreMgr;
        pbest.time = scoreMgr.Map_GetRecord_v2(network.PlayerInfo.Id, map.MapInfo.MapUid, "PersonalBest", "", "TimeAttack", "");
        pbest.medal = scoreMgr.Map_GetMedal(network.PlayerInfo.Id, map.MapInfo.MapUid, "PersonalBest", "", "TimeAttack", "");
      }
#elif TURBO
      if(network.TmRaceRules !is null) {
        auto dataMgr = network.TmRaceRules.DataMgr;
        //dataMgr.RetrieveRecords(map.MapInfo, dataMgr.MenuUserId);
        dataMgr.RetrieveRecordsNoMedals(map.MapInfo.MapUid, dataMgr.MenuUserId);
        yield();
        if(dataMgr.Ready) {
          for(uint i = 0; i < dataMgr.Records.Length; i++) {
            // TODO: identify game mode, and then load arcade or dual-driver best instead? only loads for campaign maps right now
            if(dataMgr.Records[i].GhostName == "Solo_BestGhost") {
              pbest.time = dataMgr.Records[i].Time;
              pbest.medal = CalcMedal();
              break;
            }
          }
        }
      }
#elif MP4
      // don't use network.ClientManiaAppPlayground.ScoreMgr because that always returns -1
      if(network.TmRaceRules !is null && network.TmRaceRules.ScoreMgr !is null) {
        auto scoreMgr = network.TmRaceRules.ScoreMgr;
        // after extensive research, I have concluded that Context must be ""
        pbest.time = scoreMgr.Map_GetRecord(network.PlayerInfo.Id, map.MapInfo.MapUid, "");
        pbest.medal = CalcMedal();
      } else if(app.CurrentProfile !is null && app.CurrentProfile.AccountSettings !is null) {
        // when playing on a server, TmRaceRules.ScoreMgr is unfortunately inaccessible
        // this is using *saved replays* to load the PB; if the replay has been deleted (or never saved), it won't appear
        pbest.time = -1;
        for(uint i = 0; i < app.ReplayRecordInfos.Length; i++) {
          if(app.ReplayRecordInfos[i] !is null
             && app.ReplayRecordInfos[i].MapUid == map.MapInfo.MapUid
             && app.ReplayRecordInfos[i].PlayerLogin == app.CurrentProfile.AccountSettings.OnlineLogin) {
            auto record = app.ReplayRecordInfos[i];
            if(pbest.time < 0 || record.BestTime < pbest.time) {
              pbest.time = record.BestTime;
            }
          }
        }
        pbest.medal = CalcMedal();
      }
#endif
      else {
        pbest.time = -1;
        pbest.medal = 0;
      }
      pbest.hidden = !showPbest;
    
    } else {
#if TMNEXT||MP4
      author.time = -5;
#elif TURBO
      stmaster.time = -9;
      sgold.time = -8;
      ssilver.time = -7;
      sbronze.time = -6;
      tmaster.time = -5;
#endif
      gold.time = -4;
      silver.time = -3;
      bronze.time = -2;
      pbest.time = -1;
      pbest.medal = 0;
    }
    
    times.SortAsc();
    
    sleep(500);
  }
}

#if TURBO||MP4
uint CalcMedal() {
#if TURBO
  if(pbest <= stmaster) return 8;
  else if(pbest <= sgold) return 7;
  else if(pbest <= ssilver) return 6;
  else if(pbest <= sbronze) return 5;
  else if(pbest <= tmaster) return 4;
#elif MP4
  if(pbest <= author) return 4;
#endif
  else if(pbest <= gold) return 3;
  else if(pbest <= silver) return 2;
  else if(pbest <= bronze) return 1;
  else return 0;
}
#endif
