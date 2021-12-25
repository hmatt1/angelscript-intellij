CTrackMania@ GetTmApp() {
    return cast<CTrackMania>(GetApp());
}

CSmArenaClient@ GetCurrentPlayground() {
    if (GetTmApp().CurrentPlayground is null) return null;
    return cast<CSmArenaClient>(GetTmApp().CurrentPlayground);
}