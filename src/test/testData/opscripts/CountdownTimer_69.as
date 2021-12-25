
namespace EditorHelpers
{
    class CountdownTimer
    {
        CountdownTimer()
        {
        }

        CountdownTimer(float maxTime)
        {
            MaxTime = maxTime;
        }

        float MaxTime = 5.0f;
        private float CurrentTime = 0.0f;
        void StartNew() { CurrentTime = MaxTime; }
        void Update(float dt) { CurrentTime = Math::Max(CurrentTime-dt, 0.0f); }
        bool Complete() { return CurrentTime == 0.0f; }
    }
}
