namespace EditorHelpers
{
    namespace Compatibility
    {
        void SetModeBlockNormal(CGameCtnEditorFree@ editor)
        {
#if TMNEXT
            editor.ButtonNormalBlockModeOnClick();
#else
            if (editor.PluginMapType.PlaceMode != CGameEditorPluginMap::EPlaceMode::Block)
            {
                editor.PluginMapType.PlaceMode = CGameEditorPluginMap::EPlaceMode::Block;
            }
#endif
        }

        void SetModeBlockGhost(CGameCtnEditorFree@ editor)
        {
#if TMNEXT
            editor.ButtonGhostBlockModeOnClick();
#else
            editor.ButtonInventoryGhostBlocksOnClick();
#endif
        }

        void SetModeBlockFree(CGameCtnEditorFree@ editor)
        {
#if TMNEXT
            editor.ButtonFreeBlockModeOnClick();
#endif
        }

        void SetModeItemNormal(CGameCtnEditorFree@ editor)
        {
#if TMNEXT
            editor.ButtonNormalItemModeOnClick();
#else
            // TODO: Need way to differentiate between Free and Normal Item Mode
            // editor.ButtonInventoryObjectsOnClick();
#endif
        }

        void SetModeItemFreeGround(CGameCtnEditorFree@ editor)
        {
#if TMNEXT
            editor.ButtonFreeGroundItemModeOnClick();
#endif
        }

        void SetModeItemFree(CGameCtnEditorFree@ editor)
        {
#if TMNEXT
            editor.ButtonFreeItemModeOnClick();
#else
            // TODO: Need way to differentiate between Free and Normal Item Mode
            // editor.ButtonInventoryObjectsOnClick();
#endif
        }

        void SetModeMacroblockNormal(CGameCtnEditorFree@ editor)
        {
#if TMNEXT
            editor.ButtonNormalMacroblockModeOnClick();
#endif
        }

        void SetModeMacroblockFree(CGameCtnEditorFree@ editor)
        {
#if TMNEXT
            editor.ButtonFreeMacroblockModeOnClick();
#endif
        }

        string[] ValidBlockModes = {
              "Normal"
            , "Ghost"
#if TMNEXT
            , "Free"
#endif
        };

        string[] ValidItemModes = {
              "Normal"
#if TMNEXT
            , "Free Ground"
            , "Free"
#endif
        };

        string[] ValidMacroblockModes = {
              "Normal"
#if TMNEXT
            , "Free"
#endif
        };
    }

    [Setting category="DefaultBlockMode" name="Enabled"]
    bool settingDefaultBlockModeEnabled = true;
    [Setting category="DefaultBlockMode" name="Default Block Mode"]
    string settingDefaultBlockMode = "Normal";
    [Setting category="DefaultBlockMode" name="Default Item Mode"]
    string settingDefaultItemMode = "Normal";
    [Setting category="DefaultBlockMode" name="Default Macroblock Mode"]
    string settingDefaultMacroblockMode = "Normal";
    class DefaultBlockMode : EditorHelpers::EditorFunction
    {
        private string lastPlaceModeCategory;

        bool Enabled() override { return settingDefaultBlockModeEnabled; }

        void Init() override 
        {
            if (!Enabled() || Editor is null)
            {
                lastPlaceModeCategory = "";
            }
        }

        void RenderInterface() override
        {
            if (!Enabled()) return;
            if (UI::CollapsingHeader("Default Block Modes"))
            {
                if (Compatibility::ValidBlockModes.Length > 1)
                {
                    if (settingToolTipsEnabled)
                    {
                        EditorHelpers::HelpMarker("Default when switching into block mode");
                        UI::SameLine();
                    }
                    if (UI::BeginCombo("Block Mode", settingDefaultBlockMode))
                    {
                        for (uint i = 0; i < Compatibility::ValidBlockModes.Length; i++)
                        {
                            if (UI::Selectable(Compatibility::ValidBlockModes[i], false))
                            {
                                settingDefaultBlockMode = Compatibility::ValidBlockModes[i];
                                break;
                            }
                        }
                        UI::EndCombo();
                    }
                }

                if (Compatibility::ValidItemModes.Length > 1)
                {
                    if (settingToolTipsEnabled)
                    {
                        EditorHelpers::HelpMarker("Default when switching into item mode");
                        UI::SameLine();
                    }
                    if (UI::BeginCombo("Item Mode", settingDefaultItemMode))
                    {
                        for (uint i = 0; i < Compatibility::ValidItemModes.Length; i++)
                        {
                            if (UI::Selectable(Compatibility::ValidItemModes[i], false))
                            {
                                settingDefaultItemMode = Compatibility::ValidItemModes[i];
                                break;
                            }
                        }
                        UI::EndCombo();
                    }
                }

                if (Compatibility::ValidMacroblockModes.Length > 1)
                {
                    if (settingToolTipsEnabled)
                    {
                        EditorHelpers::HelpMarker("Default when switching into macroblock mode");
                        UI::SameLine();
                    }
                    if (UI::BeginCombo("Macroblock Mode", settingDefaultMacroblockMode))
                    {
                        for (uint i = 0; i < Compatibility::ValidMacroblockModes.Length; i++)
                        {
                            if (UI::Selectable(Compatibility::ValidMacroblockModes[i], false))
                            {
                                settingDefaultMacroblockMode = Compatibility::ValidMacroblockModes[i];
                                break;
                            }
                        }
                        UI::EndCombo();
                    }
                }
            }
        }

        void Update(float) override
        {
            if (!Enabled() || Editor is null) return;
            string currentPlaceModeCategory = "Undefined";
            if (Editor.PluginMapType.PlaceMode == CGameEditorPluginMap::EPlaceMode::Block
            || Editor.PluginMapType.PlaceMode == CGameEditorPluginMap::EPlaceMode::GhostBlock
            || Editor.PluginMapType.PlaceMode == CGameEditorPluginMap::EPlaceMode::Unknown)
            {
                currentPlaceModeCategory = "Block";
            }
            else if (Editor.PluginMapType.PlaceMode == CGameEditorPluginMap::EPlaceMode::Item)
            {
                currentPlaceModeCategory = "Item";
            }
            else if (Editor.PluginMapType.PlaceMode == CGameEditorPluginMap::EPlaceMode::Macroblock)
            {
                currentPlaceModeCategory = "Macroblock";
            }

            if (lastPlaceModeCategory != currentPlaceModeCategory)
            {

                if (Editor.PluginMapType.PlaceMode == CGameEditorPluginMap::EPlaceMode::Block)
                {
                    if (settingDefaultBlockMode == "Normal")
                    {
                        Compatibility::SetModeBlockNormal(Editor);
                    }
                    else if (settingDefaultBlockMode == "Ghost")
                    {
                        Compatibility::SetModeBlockGhost(Editor);
                    }
                    else if (settingDefaultBlockMode == "Free")
                    {
                        Compatibility::SetModeBlockFree(Editor);
                    }
                }
                else if (Editor.PluginMapType.PlaceMode == CGameEditorPluginMap::EPlaceMode::Item)
                {
                    if (settingDefaultItemMode == "Normal")
                    {
                        Compatibility::SetModeItemNormal(Editor);
                    }
                    else if (settingDefaultItemMode == "Free Ground")
                    {
                        Compatibility::SetModeItemFreeGround(Editor);
                    }
                    else if (settingDefaultItemMode == "Free")
                    {
                        Compatibility::SetModeItemFree(Editor);
                    }
                }
                else if (Editor.PluginMapType.PlaceMode == CGameEditorPluginMap::EPlaceMode::Macroblock)
                {
                    if (settingDefaultMacroblockMode == "Normal")
                    {
                        Compatibility::SetModeMacroblockNormal(Editor);
                    }
                    else if (settingDefaultMacroblockMode == "Free")
                    {
                        Compatibility::SetModeMacroblockFree(Editor);
                    }
                }
            }
            lastPlaceModeCategory = currentPlaceModeCategory;
        }
    }
}