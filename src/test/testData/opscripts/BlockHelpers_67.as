
namespace EditorHelpers
{
    namespace Compatibility
    {
        void SetHideBlockHelpers(CGameCtnEditorFree@ editor, bool setValue)
        {
#if TMNEXT
            editor.HideBlockHelpers = setValue;
#elif MP4
            editor.PluginMapType.HideBlockHelpers = setValue;
#endif
        }
    }

    [Setting category="BlockHelpers" name="Enabled"]
    bool settingBlockHelpers = true;
    [Setting category="BlockHelpers" name="Block Helpers Off"]
    bool settingBlockHelpersBlockHelpersOff = false;
    class BlockHelpers : EditorHelpers::EditorFunction
    {
        private bool lastBlockHelpersOff;

        bool Enabled() override { return settingBlockHelpers; }

        void Init() override 
        {
            if (!Enabled() || Editor is null)
            {
                lastBlockHelpersOff = false;
            }
        }

        void RenderInterface() override
        {
            if (!Enabled()) return;
            if (UI::CollapsingHeader("Block Helpers"))
            {
                if (settingToolTipsEnabled)
                {
                    EditorHelpers::HelpMarker("Hide/Show block clip helpers");
                    UI::SameLine();
                }
                settingBlockHelpersBlockHelpersOff = UI::Checkbox("Block Helpers Off", settingBlockHelpersBlockHelpersOff);
            }
        }

        void Update(float) override
        {
            if (!Enabled() || Editor is null) return;
            if (settingBlockHelpersBlockHelpersOff)
            {
                Compatibility::SetHideBlockHelpers(Editor, true);
            }
            else if (lastBlockHelpersOff && !settingBlockHelpersBlockHelpersOff)
            {
                Compatibility::SetHideBlockHelpers(Editor, false);
            }
            lastBlockHelpersOff = settingBlockHelpersBlockHelpersOff;
        }
    }
}