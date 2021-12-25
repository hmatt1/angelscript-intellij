bool g_IsSM;
string g_Site;

[Setting name="Button visibility" description="0: Never, 1: Sync with F3 overlay, 2: Sync with ingame interface, 3: Always"]
int Setting_ShowButton = 2;

Resources::Texture@ g_Logo_Disabled;
Resources::Texture@ g_Logo_Enabled;
bool g_ShowButton;
bool g_MapLoaded;
bool g_IsHovering;
string g_MapUid;
int g_MXId;

bool g_Rendered = false;

vec2 g_ButtonSize = vec2(100,100);
vec2 g_ButtonPos = vec2(0, 500);

void Main() {
    yield();
    @g_Logo_Disabled = Resources::GetTexture("Textures/MXLogo_Disabled.png");
#if TMNEXT
    @g_Logo_Enabled = Resources::GetTexture("Textures/MXLogo_Enabled.png");
#else
    @g_Logo_Enabled = Resources::GetTexture("Textures/MXLogo_Enabled_TM2.png");
#endif
}

void Update(float dt) {
    if (GetApp().CurrentPlayground !is null && GetApp().RootMap !is null) {
        if (GetApp().RootMap is null) {
            g_MapLoaded = false;
            return;
        }
        if (!g_MapLoaded) {
            g_MapLoaded = true;
            g_ShowButton = false;
#if TMNEXT
            //only in SM title
#else
	        auto interfaceTM = cast<CTrackManiaRaceInterface>(GetApp().CurrentPlayground.Interface);
            g_IsSM = !(interfaceTM !is null);
#endif
            g_MapUid = GetApp().RootMap.EdChallengeId;
            startnew(CheckMapExistence);
        }
    } else {
        g_MapLoaded = false;
    }
}

void Render() {
    g_Rendered = false;
    if (g_MapLoaded && g_ShowButton && Setting_ShowButton > 0) {
        auto playground = GetApp().CurrentPlayground;
        if (Setting_ShowButton == 1 && !UI::IsOverlayShown()) return;
        else if (Setting_ShowButton == 2 && (playground is null || playground.Interface is null || Dev::GetOffsetUint32(playground.Interface, 0x1C) == 0) ) return;
        float height = Draw::GetHeight();
        g_ButtonSize = vec2(height / 22.5, height / 22.5);
        g_ButtonPos = vec2(0, 0.282222 * height);
        UI::DrawList@ drawList = UI::GetBackgroundDrawList();
        if (g_IsHovering) {
            drawList.AddImage(g_Logo_Enabled, g_ButtonPos, g_ButtonSize);
        } else {
            drawList.AddImage(g_Logo_Disabled, g_ButtonPos, g_ButtonSize);
        }
        g_Rendered = true;
    }
}

void OnMouseMove(int x, int y) {
    g_IsHovering = (x > g_ButtonPos.x && x < g_ButtonPos.x + g_ButtonSize.x && y > g_ButtonPos.y && y < g_ButtonPos.y + g_ButtonSize.y);
}

bool OnMouseButton(bool down, int button, int x, int y) {
    if (down && button == 0 && (x > g_ButtonPos.x && x < g_ButtonPos.x + g_ButtonSize.x && y > g_ButtonPos.y && y < g_ButtonPos.y + g_ButtonSize.y) && g_ShowButton && g_Rendered) {
        OpenBrowserURL("https://" + g_Site + "/maps/" + g_MXId);
        return true;
    }
    return false;
}

void OnSettingsChanged() {
    if (Setting_ShowButton < 0) Setting_ShowButton = 0;
    else if (Setting_ShowButton > 3) Setting_ShowButton = 3;
}

void CheckMapExistence() {
    if (!g_MapLoaded) return;

#if TMNEXT
	g_Site = "trackmania.exchange";
#else
	if (g_IsSM) {
        g_Site = "sm.mania.exchange";
    } else {
        g_Site = "tm.mania.exchange";
    }
#endif

    // Send API request
    Net::HttpRequest req;
    req.Method = Net::HttpMethod::Get;
    req.Url = "https://" + g_Site + "/api/maps/get_map_info/multi/" + g_MapUid;
    req.Start();
    while (!req.Finished()) {
        yield();
    }
    string response = req.String();

    // Evaluate reqest result
    Json::Value returnedObject = Json::Parse(response);
    try {
        if (returnedObject.get_Length() > 0) {
            g_MXId = returnedObject[0]["TrackID"];
            g_ShowButton = true;
        } else {
            g_ShowButton = false;
        }
    } catch {
        warn("Something went wrong while checking the map on MX.");
    }
}