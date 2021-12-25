CTrackMania@ getTmApp() {
    return cast<CTrackMania>(GetApp());
}

CGameCtnNetwork@ getNetwork() {
    return getTmApp().Network;
}

CGameNetServerInfo@ getServerInfo() {
    if (getNetwork() !is null) return getNetwork().ServerInfo;
    return null;
}

bool isServer() {
    return (getServerInfo() !is null && getServerInfo().ServerHostName != "");
}
