
namespace EditorHelpers
{
    namespace Compatibility
    {
        bool FreeblockModePreciseRotationShouldBeActive(CGameCtnEditorFree@ editor)
        {
#if TMNEXT
            return editor.Cursor.UseFreePos || editor.PluginMapType.PlaceMode == CGameEditorPluginMap::EPlaceMode::Item;
#else
            return editor.PluginMapType.PlaceMode == CGameEditorPluginMap::EPlaceMode::Item;
#endif
        }

        string FreeblockModePreciseRotationName()
        {
#if TMNEXT
            return "";
#else
            return "Item ";
#endif
        }
    }

    [Setting category="FreeblockModePreciseRotation" name="Enabled"]
    bool settingsFreeblockModePreciseRotationEnabled = true;
    [Setting category="FreeblockModePreciseRotation" name="Step Size"]
    string settingsFreeblockModePreciseRotationStepSize = "Default";
    class FreeblockModePreciseRotation : EditorHelpers::EditorFunction
    {
        float inputPitch = 0.0f;
        float inputRoll = 0.0f;
        float stepSize = 1.0f;
        bool newInputToApply = false;

        bool Enabled() override { return settingsFreeblockModePreciseRotationEnabled; }

        void Init() override
        {
            if (Editor is null || !Enabled() || FirstPass)
            {
                inputPitch = 0.0f;
                inputRoll = 0.0f;
                newInputToApply = false;
                if (settingsFreeblockModePreciseRotationStepSize == "Default")
                {
                    stepSize = 1.0f;
                }
                else if (settingsFreeblockModePreciseRotationStepSize == "BiBiSlope")
                {
                    stepSize = Math::ToDeg(Math::Atan(4.0f / 32.0f));
                }
                else if (settingsFreeblockModePreciseRotationStepSize == "BiSlope")
                {
                    stepSize = Math::ToDeg(Math::Atan(8.0f / 32.0f));
                }
                else if (settingsFreeblockModePreciseRotationStepSize == "Slope2")
                {
                    stepSize = Math::ToDeg(Math::Atan(16.0f / 32.0f));
                }
            }
        }

        void RenderInterface() override
        {
            if (!Enabled()) return;
            UI::PushID("FreeblockModePreciseRotation::RenderInterface");
            if (UI::CollapsingHeader(Compatibility::FreeblockModePreciseRotationName() + "Precise Rotation"))
            {
                if (settingToolTipsEnabled)
                {
                    EditorHelpers::HelpMarker("Sets the rotational step size of the pitch and roll inputs to a game slope.");
                    UI::SameLine();
                }
                if (UI::BeginCombo("Step Size", settingsFreeblockModePreciseRotationStepSize))
                {
                    if (UI::Selectable("Default", false))
                    {
                        stepSize = 1.0f;
                        settingsFreeblockModePreciseRotationStepSize = "Default";
                    }
                    else if (UI::Selectable("BiBiSlope", false))
                    {
                        stepSize = Math::ToDeg(Math::Atan(4.0f / 32.0f));
                        settingsFreeblockModePreciseRotationStepSize = "BiBiSlope";
                    }
                    else if (UI::Selectable("BiSlope", false))
                    {
                        stepSize = Math::ToDeg(Math::Atan(8.0f / 32.0f));
                        settingsFreeblockModePreciseRotationStepSize = "BiSlope";
                    }
                    else if (UI::Selectable("Slope2", false))
                    {
                        stepSize = Math::ToDeg(Math::Atan(16.0f / 32.0f));
                        settingsFreeblockModePreciseRotationStepSize = "Slope2";
                    }
                    UI::EndCombo();
                }

                if (settingToolTipsEnabled)
                {
                    EditorHelpers::HelpMarker("Pitch of the block in degrees. Use the +/- to increment or enter any value.");
                    UI::SameLine();
                }
                float inputPitchResult = UI::InputFloat("Pitch (deg)", inputPitch, stepSize);
                if (inputPitchResult != inputPitch)
                {
                    inputPitch = inputPitchResult;
                    newInputToApply = true;
                }

                if (settingToolTipsEnabled)
                {
                    EditorHelpers::HelpMarker("Roll of the block in degrees. Use the +/- to increment or enter any value.");
                    UI::SameLine();
                }
                float inputRollResult = UI::InputFloat("Roll (deg)", inputRoll, stepSize);
                if (inputRollResult != inputRoll)
                {
                    inputRoll = inputRollResult;
                    newInputToApply = true;
                }
            }
            UI::PopID();
        }

        void Update(float) override
        {
            if (!Enabled() || Editor is null) return;
            if (Compatibility::FreeblockModePreciseRotationShouldBeActive(Editor))
            {
                if (newInputToApply)
                {
                    Editor.Cursor.Pitch = Math::ToRad(inputPitch);
                    Editor.Cursor.Roll = Math::ToRad(inputRoll);
                    newInputToApply = false;
                }
                inputPitch = Math::ToDeg(Editor.Cursor.Pitch);
                inputRoll = Math::ToDeg(Editor.Cursor.Roll);
            }
        }
    }
}
