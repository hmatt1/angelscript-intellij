Dev::HookInfo@ g_hookSimulationStep;
float prevSpeed;
float prevAcc = 0;
float acc = 0;

int screenWidth;
int screenHeight;

[Setting name="Start position of bar vertically" description="" min="0" max="1" drag="true"]
float startBarAtFactor = 0.6f;

[Setting name="End position of bar vertically" description="" min="0" max="1" drag="true"]
float endBarAtFactor = 0.95f;

[Setting name="Position of bar horizontaly"  min="0" max="1" drag="true"]
float leftBarAtFactor = 0.65f;

[Setting name="Bar width" description="Width of the bar in pixels" min="0" max="1000" drag="true"]
int barWidth = 50;

[Setting name="Zero line height" description="The higher the value, the more values below zero acceleration will be displayed" min="0" max="10" drag="true"]
int zeroLineHeight = 3;

[Setting name="Zoom factor" description="The higher the value, the less the minimum and maximum values will be that can be displayd in the bar" min="1" max="10" drag="true"]
int zoomFactor = 3;

[Setting name="High-accuracy mode" description="The acceleration that is being display will be more accurate but will also jumps around faster" min="1" max="10" drag="true"]
bool accurateMode = false;

float showPositiveValuesFactor;
int barTop;
int barLeft;
int barHeight;

int barActiveTop;
int barActiveHeight;

float barActiveMaximumFactor;
float barActiveMinimumFactor;

int widthSmallIndicatorLine;

int renderTimeout = 0;
bool gotLogin;

void OnDestroyed()
{
    if (g_hookSimulationStep !is null) {
        Dev::Unhook(g_hookSimulationStep);
    }
}

void OnSettingsChanged()
{
    CalculateBarCoordinates();
}

void CalculateBarCoordinates(){
    showPositiveValuesFactor = 1-zeroLineHeight/10.0f;
    widthSmallIndicatorLine = int(barWidth/4);

    screenWidth = Draw::GetWidth();
    screenHeight = Draw::GetHeight();

    barHeight = int(screenHeight * (endBarAtFactor - startBarAtFactor));

    barTop = int(screenHeight*startBarAtFactor);
    barLeft = int(screenWidth*leftBarAtFactor);

    barActiveTop = int( barTop + barHeight * showPositiveValuesFactor);
    barActiveHeight = int(barHeight * -1);

    barActiveMaximumFactor = showPositiveValuesFactor;
    barActiveMinimumFactor = -1.0f * (1.0f - showPositiveValuesFactor);
}

void ArenaSimulationStep(CSmArena@ rcx)
{
    CGameCtnApp@ app = GetApp();
	CTrackManiaNetwork@ net = cast<CTrackManiaNetwork@>(app.Network);
	CTrackManiaNetworkServerInfo@ ser = cast<CTrackManiaNetworkServerInfo@>(net.ServerInfo);

	// only execute in offline matches
	if(ser.ServerName != ""){
		return;
	}
	
    CSmArenaClient@ client = cast<CSmArenaClient>(app.CurrentPlayground);
    CGameTerminal@ terminal = cast<CGameTerminal>(client.GameTerminals[0]);
    CSmPlayer@ player = cast<CSmPlayer>(terminal.ControlledPlayer);

    float speed = player.ScriptAPI.Speed;
    acc = speed - prevSpeed;
    prevSpeed = speed;
	
    if(!accurateMode){
        float lessAccurateAccelaration = (acc + prevAcc) / 2;
        prevAcc = acc;
        acc = lessAccurateAccelaration;
    }   

    renderTimeout = 10;
}

void Main()
{
    while (Draw::GetWidth() == -1) {
		yield();
	}

    CGameCtnApp@ app = GetApp();
    while (!gotLogin) {
        if (app.Network !is null) {
            CTrackManiaNetwork@ net = cast<CTrackManiaNetwork@>(app.Network);
            if (net.PlayerInfo !is null) {
                gotLogin = true;
            }
        } else yield();
    }

    CalculateBarCoordinates();

    auto pfArenaSimulationStep = Dev::FindPattern("48 89 5C 24 18 55 56 57 41 54 41 55 41 56 41 57 48 8D AC 24 E0 FE FF FF 48 81 EC 20 02 00 00 0F 29 B4 24 10 02 00 00 48 8B ?? ?? ?? ?? ?? 48 33 C4 48 89 85");

    if (pfArenaSimulationStep != 0) {
        @g_hookSimulationStep = Dev::Hook(pfArenaSimulationStep, 0, "ArenaSimulationStep");
    }
}

void Render()
{
    if (!gotLogin || renderTimeout == 0)
	{
       return;
	}

    /* background bar */
    nvg::BeginPath();
    nvg::Rect(barLeft, barTop, barWidth, barHeight);
    nvg::FillColor(vec4(1, 1, 1, 0.1));
    nvg::Fill();
    nvg::ClosePath();

    /* active bar */
    float barFactor = acc * zoomFactor;
    if(barFactor > barActiveMaximumFactor){
        barFactor = barActiveMaximumFactor;
    }
    
    if(barFactor < barActiveMinimumFactor){
        barFactor = barActiveMinimumFactor;
    }

    nvg::BeginPath();
    nvg::Rect(barLeft, barActiveTop, barWidth, barActiveHeight * barFactor );
    nvg::FillColor(vec4(1, 1, 1, 0.6));
    nvg::Fill();
    nvg::ClosePath();

     /* indicator lines*/

    nvg::BeginPath();
    nvg::Rect(barLeft, barActiveTop, barWidth, 3);
    nvg::FillColor(vec4(0, 0, 1, 1));
    nvg::Fill();
    nvg::ClosePath();


    nvg::BeginPath();
    nvg::Rect(barLeft, barTop+(barHeight*0.1), widthSmallIndicatorLine, 1);
    nvg::FillColor(vec4(0, 0, 1, 1));
    nvg::Fill();
    nvg::ClosePath();
    
    nvg::BeginPath();
    nvg::Rect(barLeft, barTop+(barHeight*0.2), widthSmallIndicatorLine, 1);
    nvg::FillColor(vec4(0, 0, 1, 1));
    nvg::Fill();
    nvg::ClosePath();

    nvg::BeginPath();
    nvg::Rect(barLeft, barTop+(barHeight*0.3), widthSmallIndicatorLine, 1);
    nvg::FillColor(vec4(0, 0, 1, 1));
    nvg::Fill();
    nvg::ClosePath();

    nvg::BeginPath();
    nvg::Rect(barLeft, barTop+(barHeight*0.4), widthSmallIndicatorLine, 1);
    nvg::FillColor(vec4(0, 0, 1, 1));
    nvg::Fill();
    nvg::ClosePath();

    nvg::BeginPath();
    nvg::Rect(barLeft, barTop+(barHeight*0.5), widthSmallIndicatorLine, 1);
    nvg::FillColor(vec4(0, 0, 1, 1));
    nvg::Fill();
    nvg::ClosePath();

    nvg::BeginPath();
    nvg::Rect(barLeft, barTop+(barHeight*0.6), widthSmallIndicatorLine, 1);
    nvg::FillColor(vec4(0, 0, 1, 1));
    nvg::Fill();
    nvg::ClosePath();

    nvg::BeginPath();
    nvg::Rect(barLeft, barTop+(barHeight*0.7), widthSmallIndicatorLine, 1);
    nvg::FillColor(vec4(0, 0, 1, 1));
    nvg::Fill();
    nvg::ClosePath();

    nvg::BeginPath();
    nvg::Rect(barLeft, barTop+(barHeight*0.8), widthSmallIndicatorLine, 1);
    nvg::FillColor(vec4(0, 0, 1, 1));
    nvg::Fill();
    nvg::ClosePath();

    nvg::BeginPath();
    nvg::Rect(barLeft, barTop+(barHeight*0.9), widthSmallIndicatorLine, 1);
    nvg::FillColor(vec4(0, 0, 1, 1));
    nvg::Fill();
    nvg::ClosePath();

    renderTimeout = renderTimeout - 1;
	
}
