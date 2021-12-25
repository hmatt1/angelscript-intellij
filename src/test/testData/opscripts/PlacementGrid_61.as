
namespace EditorHelpers
{
    [Setting category="PlacementGrid" name="Enabled"]
    bool settingPlacementGridEnabled = true;
    [Setting category="PlacementGrid" name="Placement Grid On"]
    bool settingPlacementGridPlacementGridOn = false;
    [Setting category="PlacementGrid" name="Placement Grid Transparent"]
    bool settingPlacementGridPlacementGridTransparent = true;
    class PlacementGrid : EditorHelpers::EditorFunction
    {
        bool Enabled() override { return settingPlacementGridEnabled; }

        void RenderInterface() override
        {
            if (!Enabled()) return;
            if (UI::CollapsingHeader("Placement Grid"))
            {
                if (settingToolTipsEnabled)
                {
                    EditorHelpers::HelpMarker("Display the horizontal block grid");
                    UI::SameLine();
                }
                settingPlacementGridPlacementGridOn = UI::Checkbox("Placement Grid On", settingPlacementGridPlacementGridOn);
                UI::SameLine();
                settingPlacementGridPlacementGridTransparent = UI::Checkbox("Transparent", settingPlacementGridPlacementGridTransparent);
            }
        }

        void Update(float) override
        {
            if (!Enabled() || Editor is null) return;
            if (settingPlacementGridPlacementGridOn != Editor.PluginMapType.ShowPlacementGrid)
            {
                Editor.ButtonHelper1OnClick();
            }
            if (settingPlacementGridPlacementGridTransparent)
            {
                Editor.GridColorAlpha = 0.0;
            }
            else
            {
                Editor.GridColorAlpha = 0.2;
            }
        }
    }
}