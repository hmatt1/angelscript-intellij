Resources::Font@ g_font;

void Render()
{
	auto loadProgress = GetApp().LoadProgress;
	if (loadProgress is null || loadProgress.State == NGameLoadProgress_SMgr::EState::Disabled) {
		return;
	}

	string str;

	if (loadProgress.HoldScreenGet_DownloadData) {
		str += "Downloading data...\n";
	}

	if (loadProgress.HoldScreenGet_ChallengeData) {
		str += "Loading challenge data...\n";
	}

	if (loadProgress.HoldScreenGet_PreparePlayground) {
		str += "Preparing playground...\n";
	}

	if (loadProgress.HoldScreenGet_WaitKeyPress) {
		str += "Waiting for key press...\n";
	}

	if (loadProgress.HoldScreenGet_RulesScript) {
		str += "Loading rules script...\n";
	}

	if (loadProgress.HoldScreenGet_EditorScript) {
		str += "Loading editor script...\n";
	}

	int w = Draw::GetWidth();
	int h = Draw::GetHeight();

	nvg::BeginPath();

	// Tweakable
	nvg::FontFace(g_font);
	nvg::FontSize(20);
	nvg::TextAlign(nvg::Align::Center);
	float x = 0;
	float y = h / 3;
	float textWidth = w;

	// Render shadow
	nvg::FillColor(vec4(0, 0, 0, 1));
	nvg::FontBlur(3.0f);
	nvg::TextBox(x + 2, y + 2, textWidth,  str);

	// Render text
	nvg::FillColor(vec4(1, 1, 1, 1));
	nvg::FontBlur(0.0f);
	nvg::TextBox(x, y, textWidth, str);
}

void Main()
{
	@g_font = Resources::GetFont("DroidSans.ttf");
}
