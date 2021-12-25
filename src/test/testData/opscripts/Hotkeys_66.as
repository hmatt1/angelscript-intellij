
namespace EditorHelpers
{
    namespace Compatibility
    {
        bool OnKeyPress_AirBlockModeHotkey(CGameCtnEditorFree@ Editor, VirtualKey key)
        {
            bool handled = false;
#if TMNEXT
            if (Setting_Hotkeys_AirBlockHotKeyEnabled && key == Setting_Hotkeys_AirBlockHotKey
                && (Editor.PluginMapType.PlaceMode == CGameEditorPluginMap::EPlaceMode::Block
                    || Editor.PluginMapType.PlaceMode == CGameEditorPluginMap::EPlaceMode::GhostBlock
                    || Editor.PluginMapType.PlaceMode == CGameEditorPluginMap::EPlaceMode::FreeBlock))
            {
                Editor.ButtonAirBlockModeOnClick();
                handled = true;
            }
#elif MP4
            handled = false;
#endif
            return handled;
        }

        bool OnKeyPress_ToggleColorsHotkey(CGameCtnEditorFree@ Editor, VirtualKey key)
        {
            bool handled = false;
#if TMNEXT
            if (Setting_Hotkeys_ToggleColorsHotKeyEnabled && key == Setting_Hotkeys_ToggleColorsHotKey)
            {
                int currValue = int(Editor.PluginMapType.NextMapElemColor);
                if (currValue < 5) { currValue += 1; } else { currValue = 0; }
                Editor.PluginMapType.NextMapElemColor = CGameEditorPluginMap::EMapElemColor(currValue);
                handled = true;
            }
#elif MP4
            handled = false;
#endif
            return handled;
        }

        bool EnableHotkeysFunction()
        {
#if TMNEXT
#elif MP4
            Setting_Hotkeys_Enabled = false;
#endif
            return Setting_Hotkeys_Enabled;
        }
    }

    [Setting category="Hotkeys" name="Hotkeys Function Enabled"]
    bool Setting_Hotkeys_Enabled = true;

    [Setting category="Hotkeys" name="AirBlock HotKey Enabled"]
    bool Setting_Hotkeys_AirBlockHotKeyEnabled = true;
    [Setting category="Hotkeys" name="AirBlock HotKey"]
    VirtualKey Setting_Hotkeys_AirBlockHotKey = VirtualKey::A;

    [Setting category="Hotkeys" name="ToggleColors HotKey Enabled"]
    bool Setting_Hotkeys_ToggleColorsHotKeyEnabled = false;
    [Setting category="Hotkeys" name="ToggleColors HotKey"]
    VirtualKey Setting_Hotkeys_ToggleColorsHotKey = VirtualKey::F6;

    class Hotkeys : EditorHelpers::EditorFunction
    {
        VirtualKey[] m_keysDown = {};

        bool Enabled() override { return Compatibility::EnableHotkeysFunction(); }

        void Init() override
        {
            if (!Enabled() || Editor is null)
            {
                m_keysDown.RemoveRange(0, m_keysDown.Length - 1);
            }
        }

        void RenderInterface() override
        {
            if (!Enabled()) return;
            if (UI::CollapsingHeader("Hotkeys"))
            {
                if (settingToolTipsEnabled)
                {
                    EditorHelpers::HelpMarker("[" + tostring(Setting_Hotkeys_AirBlockHotKey) + "] Hotkey for airblock mode toggle");
                    UI::SameLine();
                }
                Setting_Hotkeys_AirBlockHotKeyEnabled = UI::Checkbox("Enable AirBlockMode Hotkey", Setting_Hotkeys_AirBlockHotKeyEnabled);

                if (settingToolTipsEnabled)
                {
                    EditorHelpers::HelpMarker("[" + tostring(Setting_Hotkeys_ToggleColorsHotKey) + "] Hotkey to cycle through block colors");
                    UI::SameLine();
                }
                Setting_Hotkeys_ToggleColorsHotKeyEnabled = UI::Checkbox("Enable ColorToggle Hotkey", Setting_Hotkeys_ToggleColorsHotKeyEnabled);
            }
        }

        bool OnKeyPress(bool down, VirtualKey key) override
        {
            auto currKeyIndex = m_keysDown.Find(key);
            if (down && currKeyIndex < 0)
            {
                m_keysDown.InsertLast(key);
            }
            else if (!down && currKeyIndex >= 0)
            {
                m_keysDown.RemoveAt(currKeyIndex);
            }

            bool handled = false;
            if (!Enabled()) return handled;
            if (!down && m_keysDown.IsEmpty() && Editor.PluginMapType !is null && Editor.PluginMapType.IsEditorReadyForRequest)
            {
                // '|| handled' second will result in multiple hotkeys being
                // able to be handled together if assigned to the same key
                handled = Compatibility::OnKeyPress_AirBlockModeHotkey(Editor, key) || handled;
                handled = Compatibility::OnKeyPress_ToggleColorsHotkey(Editor, key) || handled;
            }
            return handled;
        }
    }
}
