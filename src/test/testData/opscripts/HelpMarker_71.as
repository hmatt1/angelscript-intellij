
namespace EditorHelpers
{
    string lastTipHover = "";
    CountdownTimer tipHoverTimer = CountdownTimer(0.5f);
    void HelpMarker(string desc)
    {
        UI::TextDisabled(Icons::QuestionCircle);
        if (UI::IsItemHovered())
        {
            if (desc != lastTipHover)
            {
                tipHoverTimer.StartNew();
                lastTipHover = desc;
            }
            else if (desc == lastTipHover && tipHoverTimer.Complete())
            {
                // X value used as width, Y value ignored because text continues to wrap.
                UI::SetNextWindowSize(300, 10);
                UI::BeginTooltip();
                UI::TextWrapped(desc);
                UI::EndTooltip();
            }
        }
        else if (desc == lastTipHover)
        {
            lastTipHover = "";
        }
    }
}
