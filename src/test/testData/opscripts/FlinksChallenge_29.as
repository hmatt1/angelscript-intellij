// Copyright (c) 2021 thebirk
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

//TODO:
// [X] - Setting for timer duration
// [X] - Timer font size - Would be nice to not do this every render
// [X] - Actually respect overlayVisible
//   [X] - Make it a setting
// [X] - Make hundredths of seconds optional
// [X] - Add a toggle for showing hours
// [X] - Implement hotkeys with OnKeyPress()
// [ ] - Automatically detect author and gold medals. Only recognize medals set this session.
// [ ] - Add support for Random Map Survival
// [ ] - Add support for custom mode. Some variation between the two
// [ ] - Crash proofing

//Version history
// - 1.3 
//  * Add hotkey for restarting a run (Prints AT & GOLD medal count to Log in case you were a little eager with the reset)
//  * Fix - button for author decrementing gold.
// - 1.2
//  * Add toggle for showing hundredths of seconds.
//  * Add toggle for showing hours.
//  * Add hotkeys for adding medals.
//  * Add icon to menu toggle.
// - 1.1
//  * Fix overlay toggle not working.
//  * Fix the .op file so it is installable by Plugin Manager
// - 1.0
//  * Initial release

[Setting category="Timer" name="Timer length (in seconds)"]
int timerLength = 60*60;

[Setting category="Timer" name="Show overlay"]
bool overlayVisible = true;

[Setting category="Timer" name="Show hundredths of seconds"]
bool showHundredths = true;

[Setting category="Timer" name="Show hours"]
bool showHours = false;

[Setting category="Timer" name="Author medal hotkey"]
VirtualKey vkAddAuthor = VirtualKey::F5;

[Setting category="Timer" name="Gold medal hotkey"]
VirtualKey vkAddGold = VirtualKey::F7;

[Setting category="Timer" name="Restart hotkey"]
VirtualKey vkRestart = VirtualKey::F9;

int authorCount = 0;
int goldCount = 0;
int startTime = -1;
int endTime = -1;
Resources::Font@ timerFont;

void Main() {
    @timerFont = Resources::GetFont("Fonts/Montserrat-Bold.ttf", 32);
}

void RenderMenu() {
    if(UI::MenuItem("" + Icons::ClockO + " Flinks Challenge Window", "", overlayVisible)) {
        overlayVisible = !overlayVisible;
    }
}

bool OnKeyPress(bool down, VirtualKey vk) {
    if (!down) {
        return false;
    }

    if (vk == vkRestart) {
        fullRestart();
        return true;
    }

    if(vk == vkAddAuthor) {
        incrementAuthor();
        return true;
    }

    if (vk == vkAddGold) {
        incrementGold();
        return true;
    }

    return false;
}

uint lastDuration = 0;
void Update(float dt) {
    if (startTime < 0) {
        return;
    }
    startTime = Time::get_Now();

    if (startTime > endTime) {
        startTime = -1;
    }
}

void startTimer() {
    startTime = Time::get_Now();
    endTime = startTime + (timerLength*1000);
}

void fullRestart() {
    print("[Flinks Challenge] Restarting. AT: " + authorCount + ", GOLD: " + goldCount);
    authorCount = 0;
    goldCount = 0;
    startTimer();
}

void incrementAuthor() {
    authorCount += 1;
}

void decrementAuhor() {
    authorCount -= 1;
    if (authorCount < 0) {
        authorCount = 0;
    }
}

void incrementGold() {
    goldCount += 1;
}

void decrementGold() {
    goldCount -= 1;
    if (goldCount < 0) {
        goldCount = 0;
    }
}

void Render() {
    if(!overlayVisible) {
        return;
    }

    UI::SetNextWindowPos(100, 170, UI::Cond::FirstUseEver);
    UI::Begin("Flinks Challenge", UI::WindowFlags::NoTitleBar | UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoDocking);
    UI::PushFont(timerFont);
    UI::Text(FormatTimer(endTime - startTime));
    UI::PopFont();
    UI::Separator();

    if(UI::BeginTable("##medals", 5, UI::TableFlags::SizingFixedFit)) {
        // Author
        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("\\$071"+ Icons::Circle + "\\$z Author");
        UI::TableNextColumn();

        if(UI::IsOverlayShown() && UI::Button("-##authm")) {
            decrementAuhor();
        }
        UI::TableNextColumn();
        UI::Text("" + authorCount);
        UI::TableNextColumn();
        if(UI::IsOverlayShown() && UI::Button("+##authp")) {
            incrementAuthor();
        }
        UI::TableNextColumn();
        if(UI::IsOverlayShown() && UI::Button("Reset##authr")) {
            authorCount = 0;
        }

        // Gold
        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("\\$db4"+ Icons::Circle + "\\$z Gold");
        UI::TableNextColumn();

        if(UI::IsOverlayShown() && UI::Button("-##goldm")) {
            decrementGold();
        }
        UI::TableNextColumn();
        UI::Text("" + goldCount);
        UI::TableNextColumn();
        if(UI::IsOverlayShown() && UI::Button("+##goldp")) {
            incrementGold();
        }
        UI::TableNextColumn();
        if(UI::IsOverlayShown() && UI::Button("Reset##goldr")) {
            goldCount = 0;
        }
        UI::TableNextRow();

        UI::EndTable();
    }

    if(UI::IsOverlayShown()) {
        UI::Separator();
        string title = startTime > 0 ? "Restart##start" : "Start##start";
        if(UI::Button(title)) {
            startTimer();
        }
        if(startTime > 0) {
            UI::SameLine();
            if(UI::Button("Stop")) {
                startTime = -1;
            }
        }

        UI::Separator();
        UI::Text("Go to Settings for hotkeys");
    }

    UI::End();
}

string FormatTimer(int time) {
    if (startTime < 0) {
        return _FormatTimer(timerLength*1000);
    }
    return _FormatTimer(time);
}
string _FormatTimer(int time) {
    int hundreths = time % 1000 / 10;
    time /= 1000;
    int hours = time / 60 / 60;
    int minutes = time / (60);
    int seconds = time % 60;

    string result = "";

    if (showHours) {
        minutes %= 60;
        result += "" + Text::Format("%02d", hours) + ":";
    }

    result += "" + Text::Format("%02d", minutes) + ":" + Text::Format("%02d", seconds);

    if (showHundredths) {
        result += "." + Text::Format("%02d", hundreths);
    }

    return result;
}