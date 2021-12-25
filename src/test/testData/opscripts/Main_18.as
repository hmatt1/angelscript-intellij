
bool PermissionChecksPassed = false;
string inputUrl = "";
string savedMessage = "";
bool triggerDownload = false;
bool windowVisible = false;

void RenderMenu()
{
    if (!PermissionChecksPassed) return;
    if (UI::MenuItem("\\$999" + Icons::Download + "\\$z Ghost to Replay", "", windowVisible) && !windowVisible)
    {
        windowVisible = !windowVisible;
    }
}

void RenderInterface()
{
    if (!PermissionChecksPassed) return;
    if (windowVisible)
    {
        UI::Begin("Ghost To Replay", windowVisible, UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize);

        CTrackMania@ app = cast<CTrackMania>(GetApp());
        if (app.RootMap !is null)
        {
            UI::Text("Enter download URL for the Ghost");
            inputUrl = UI::InputText("Ghost URL", inputUrl);
            if (!triggerDownload && UI::Button("Create Replay"))
            {
                triggerDownload = true;
            }
            if (savedMessage != "")
            {
                UI::Text(savedMessage);
            }
        }
        else
        {
            UI::Text("Play the track you want to combine the ghost with");
            savedMessage = "";
        }

        UI::End();
    }
}

CGameDataFileManagerScript@ TryGetDataFileMgr()
{
    CTrackMania@ app = cast<CTrackMania>(GetApp());
    if (app !is null)
    {
        CSmArenaRulesMode@ playgroundScript = cast<CSmArenaRulesMode>(app.PlaygroundScript);
        if (playgroundScript !is null)
        {
            CGameDataFileManagerScript@ dataFileMgr = cast<CGameDataFileManagerScript>(playgroundScript.DataFileMgr);
            if (dataFileMgr !is null)
            {
                return dataFileMgr;
            }
        }
    }
    return null;
}

bool HasPermission()
{
    bool hasPermission = true;
    if (!Permissions::CreateLocalReplay())
    {
        error(Meta::ExecutingPlugin().Name + ": Missing permission client_CreateLocalReplay");
        hasPermission = false;
    }
    if (!Permissions::OpenReplayEditor())
    {
        error(Meta::ExecutingPlugin().Name + ": Missing permission client_OpenReplayEditor");
        hasPermission = false;
    }
    return hasPermission;
}

void Main()
{
    if (!HasPermission())
    {
        error("Insufficient permissions to use " + Meta::ExecutingPlugin().Name + ". Exiting...");
        return;
    }
    else
    {
        PermissionChecksPassed = true;
    }

    while (true)
    {
        if (triggerDownload)
        {
            print(Meta::ExecutingPlugin().Name + ": Download triggered for " + inputUrl);
            savedMessage = "";
            auto dataFileMgr = TryGetDataFileMgr();
            CTrackMania@ app = cast<CTrackMania>(GetApp());
            if (dataFileMgr !is null && app.RootMap !is null && inputUrl != "")
            {
                CWebServicesTaskResult_GhostScript@ result = dataFileMgr.Ghost_Download("", inputUrl);
                inputUrl = "";
                uint timeout = 20000;
                uint currentTime = 0;
                while (result.Ghost is null && currentTime < timeout)
                {
                    currentTime += 100;
                    sleep(100);
                }
                CGameGhostScript@ ghost = cast<CGameGhostScript>(result.Ghost);
                if (ghost !is null)
                {
                    string safeMapName = StripFormatCodes(app.RootMap.MapName);
                    string safeUserName = ghost.Nickname;
                    string safeCurrTime = Regex::Replace(app.OSLocalDate, "[/ ]", "_");
                    string fmtGhostTime = Time::Format(ghost.Result.Time);
                    string replayName = safeMapName + "_" + safeUserName + "_" + safeCurrTime + "_(" + fmtGhostTime + ")";
                    string replayPath = "Downloaded/" + replayName;
                    savedMessage = "Saving replay to " + replayPath + ".Replay.Gbx";
                    print(Meta::ExecutingPlugin().Name + ": " + savedMessage);
                    dataFileMgr.Replay_Save(replayPath, app.RootMap, ghost);
                }
                else
                {
                    error(Meta::ExecutingPlugin().Name + ": Download Failed");
                }
            }
            else
            {
                error(Meta::ExecutingPlugin().Name + ": Failed");
            }
            triggerDownload = false;
        }

        sleep(1000);
    }
}
