
namespace EditorHelpers
{
    abstract class EditorFunction
    {
        bool FirstPass = true;
        CGameCtnEditorFree@ Editor { get const { return cast<CGameCtnEditorFree>(GetApp().Editor); } }

        bool Enabled(){ return false; }
        void Init(){}
        void RenderInterface(){}
        void Update(float){}
        bool OnKeyPress(bool down, VirtualKey key){return false;}
    }
}
