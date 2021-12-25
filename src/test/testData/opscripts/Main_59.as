
// TODO: Features to investigate/add
// - Custom pivot points for blocks
// - more precise placement for blocks in free mode
// - remember erase mode
// - validate menu
// - set medal times
// - change map bases dynamically


[Setting category="General" name="Window Visible In Editor"]
bool settingWindowVisible = true;
[Setting category="General" name="Tooltips Enabled"]
bool settingToolTipsEnabled = true;

array<EditorHelpers::EditorFunction@> functions = 
{
      EditorHelpers::Quicksave()
    , EditorHelpers::BlockHelpers()
    , EditorHelpers::PlacementGrid()
    , EditorHelpers::DefaultBlockMode()
    , EditorHelpers::RememberPlacementModes()
    , EditorHelpers::CustomItemPlacement()
    , EditorHelpers::FreeblockModePreciseRotation()
    , EditorHelpers::Hotkeys()
};

namespace Compatibility
{
    bool EditorIsNull()
    {
        return cast<CGameCtnEditorFree>(GetApp().Editor) is null;
    }

    bool IsMapTesting()
    {
#if TMNEXT
        return GetApp().CurrentPlayground !is null;
#else
        CGameCtnEditorFree@ editor = cast<CGameCtnEditorFree>(GetApp().Editor);
        return editor !is null && editor.PluginMapType.IsSwitchedToPlayground;
#endif
    }
}

void RenderMenu()
{
    if (!EditorHelpers::HasPermission()) return;
    if (UI::MenuItem("\\$2f9" + Icons::PuzzlePiece + "\\$fff Editor Helpers", selected: settingWindowVisible, enabled: GetApp().Editor !is null))
    {
        settingWindowVisible = !settingWindowVisible;
    }
}

void RenderInterface()
{
    if (!EditorHelpers::HasPermission()) return;
    if (Compatibility::EditorIsNull() || Compatibility::IsMapTesting() || !settingWindowVisible) return;
    UI::SetNextWindowSize(300, 600, UI::Cond::FirstUseEver);
    UI::Begin(Icons::PuzzlePiece + " Editor Helpers", settingWindowVisible);
    for (uint index = 0; index < functions.Length; index++)
    {
        functions[index].RenderInterface();
    }
    UI::End();
}

bool OnKeyPress(bool down, VirtualKey key)
{
    bool handled = false;
    if (!EditorHelpers::HasPermission()) return handled;
    if (Compatibility::EditorIsNull() || Compatibility::IsMapTesting() || !settingWindowVisible) return handled;
    for (uint index = 0; index < functions.Length; index++)
    {
        handled = functions[index].OnKeyPress(down, key);
        if (handled) { break; }
    }
    return handled;
}

void Main()
{
    if (!EditorHelpers::HasPermission())
    {
        error("Invalid permissions to run EditorHelpers plugin.");
        return;
    }

    int dt = 0;
    float dtSeconds = 0.0;
    int prevFrameTime = Time::Now;
    while (true)
    {
        sleep(10);
        dt = Time::Now - prevFrameTime;
        dtSeconds = dt / 1000.0f;

        EditorHelpers::tipHoverTimer.Update(dtSeconds);
        for (uint index = 0; index < functions.Length; index++)
        {
            functions[index].Init();
            functions[index].Update(dt);
            functions[index].FirstPass = false;
        }
        prevFrameTime = Time::Now;
    }
}
