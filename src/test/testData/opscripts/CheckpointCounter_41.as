/*
 * author: Phlarx
 */

[Setting name="Show counter"]
bool showCounter = true;

[Setting name="Hide counter when interface is hidden"]
bool hideCounterWithIFace = false;

[Setting name="Anchor X position" min=0 max=1]
float anchorX = .5;

[Setting name="Anchor Y position" min=0 max=1]
#if TMNEXT
float anchorY = .91;
#elif TURBO
float anchorY = .895;
#elif MP4
float anchorY = .88;
#endif

[Setting name="Show background"]
bool showBackground = false;

[Setting name="Font size" min=8 max=72]
int fontSize = 24;

[Setting name="Font face"]
string fontFace = "";

[Setting name="Display mode"]
EDispMode dispMode = EDispMode::ShowCompletedAndTotal;

[Setting name="Custom display format" description="%c is completed count, %r is remaining count, %t is total count, %% is a literal %"]
string customFormat = "%c / -%r / %t";

[Setting name="Change color when go-to-finish"]
bool finishColorChange = false;

[Setting color name="Normal color"]
vec4 colorNormal = vec4(1, 1, 1, 1);

[Setting color name="Go-to-finish color"]
vec4 colorGoToFinish = vec4(1, 0, 0, 1);

enum EDispMode {
	ShowCompletedAndTotal,
	ShowRemainingAndTotal,
	ShowCompletedAndRemaining,
	ShowCustom
}

string curFontFace = "";
Resources::Font@ font;

void OnSettingsChanged() {
	if(fontFace != curFontFace) {
		@font = Resources::GetFont(fontFace);
		if(font !is null) {
			auto fontIcons = Resources::GetFont("ManiaIcons.ttf");
			nvg::AddFallbackFont(font, fontIcons);
		}
		curFontFace = fontFace;
	}
}

void RenderMenu() {
	if (UI::MenuItem("\\$09f" + Icons::Flag + "\\$z Checkpoint Counter", "", showCounter)) {
		showCounter = !showCounter;
	}
}

string getDisplayText() {
	switch(dispMode) {
	case EDispMode::ShowCompletedAndTotal:
		return doFormat("%c / %t");
	case EDispMode::ShowRemainingAndTotal:
		return doFormat("-%r / %t");
	case EDispMode::ShowCompletedAndRemaining:
		return doFormat("%c / -%r");
	case EDispMode::ShowCustom:
		return doFormat(customFormat);
	}
	return "";
}

void Render() {
	if(showCounter && CP::inGame) {
		string text = getDisplayText();
		
		nvg::FontSize(fontSize);
		if(font !is null) {
			nvg::FontFace(font);
		}
		nvg::TextAlign(nvg::Align::Center | nvg::Align::Middle);
		
		if(showBackground) {
			nvg::FillColor(vec4(0, 0, 0, 0.8));
			vec2 size = nvg::TextBoxBounds(anchorX * Draw::GetWidth() - 100, anchorY * Draw::GetHeight(), 200, text);
			nvg::BeginPath();
			nvg::RoundedRect(anchorX * Draw::GetWidth() - size.x * 0.6, anchorY * Draw::GetHeight() - size.y * 0.67, size.x * 1.2, size.y * 1.2, 5);
			nvg::Fill();
			nvg::ClosePath();
		}
		
		if(finishColorChange && CP::curCP == CP::maxCP) {
			nvg::FillColor(colorGoToFinish);
		} else {
			nvg::FillColor(colorNormal);
		}
		
		nvg::TextBox(anchorX * Draw::GetWidth() - 100, anchorY * Draw::GetHeight(), 200, text);
	}
}

string doFormat(const string format) {
	string result = "";
	int idx = 0;
	while(idx < format.Length) {
		if(format[idx] == 37 /*"%"[0]*/ && idx + 1 < format.Length) {
			switch(format[idx + 1]) {
			case 99 /*"c"[0]*/:
				result += "" + CP::curCP;
				break;
			case 114 /*"r"[0]*/:
				result += "" + (CP::maxCP - CP::curCP);
				break;
			case 116 /*"t"[0]*/:
				result += "" + CP::maxCP;
				break;
			default:
				result += format.SubStr(idx, 2);
				break;
			}
			idx += 2;
		} else {
			result += format.SubStr(idx, 1);
			idx += 1;
		}
	}
	return result;
}

void Update(float dt) {
	CP::Update();
}
