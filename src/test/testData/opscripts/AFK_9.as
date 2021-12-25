// --- Consts

const string PluginVersion = "2.1.2";
const string JSONVersion = "2.1.2";

const int C_Invalid = -123;
const uint C_MatchFoundTimeout = 15000;

// === CLASSES ===

// Queue System

class Queue {
    int QueueID;
    string Name;
    QueueStats@ Stats = QueueStats();
    string Status;
    int64 LastPlayerStatusCheck;

    string GetTitle() {
        string Addition;
        if (!(Status == "enabled" || Status == "")) {
            Addition = " \\$999(" + Status + ")";
        }
        return Name + Addition;
    }
}

class QueueTemplate {
    int QueueID;
    string Name;

    QueueTemplate(int id, const string &in name)
    {
        QueueID = id;
        Name = name;
    }
}

class QueueStats {
    QueueRanking@ CurrentRanking = QueueRanking();
    array<StatsMatch@> PlayerMatches;

    array<ProgressionPoint@> RankProgression;
    array<ProgressionPoint@> PointProgression;
    
    array<Division@> Divisions;
    Division@ CurrentDivision;

    uint64 WaitingTimeHighscore = 60000;
    int64 LastKnownMatchTime = 0;

    QueueLeaderboard@ Leaderboard = QueueLeaderboard();

    void RefreshDivisionRanking() {
        bool CheckRanking = (CurrentDivision !is null);
        int PrevPosition = 0;
        if (CheckRanking) {
            PrevPosition = CurrentDivision.Position;
        }

        // Iterate through divisions and check if user is in, always prefer higher division position
        for (uint i = 0; i < Divisions.Length; i++) {
            if (Divisions[i].RuleType == DivisionRuleType::PointsRange) {
                if (CurrentRanking.Points >= Divisions[i].MinPoints && CurrentRanking.Points <= Divisions[i].MaxPoints) {
                    if (CurrentDivision is null || Divisions[i].Position > CurrentDivision.Position) @CurrentDivision = Divisions[i];
                }
            } else if (Divisions[i].RuleType == DivisionRuleType::MinimumPoints) {
                if (CurrentRanking.Points >= Divisions[i].MinPoints) {
                    if (CurrentDivision is null || Divisions[i].Position > CurrentDivision.Position) @CurrentDivision = Divisions[i];
                }
            } else if (Divisions[i].RuleType == DivisionRuleType::MinimumRankAndPoints) {
                if (CurrentRanking.Points >= Divisions[i].MinPoints && CurrentRanking.Rank >= Divisions[i].MinRank) {
                    if (CurrentDivision is null || Divisions[i].Position > CurrentDivision.Position) @CurrentDivision = Divisions[i];
                }
            } else if (Divisions[i].RuleType == DivisionRuleType::VictoryCount) {
                if (CurrentRanking.Wins >= Divisions[i].MinVictories && CurrentRanking.Wins <= Divisions[i].MaxVictories) {
                    if (CurrentDivision is null || Divisions[i].Position > CurrentDivision.Position) @CurrentDivision = Divisions[i];
                }
            } else {
                if (CurrentRanking.Rank <= Divisions[i].MinRank) {
                    if (CurrentDivision is null || Divisions[i].Position > CurrentDivision.Position) @CurrentDivision = Divisions[i];
                }
            }
        }

        // User is in no division? Create placeholder
        if (CurrentDivision is null) {

            // What went wrong? Let's analyze:
            string LogString = "\nCurrent Points: " + CurrentRanking.Points + "\nCurrent Rank: " + CurrentRanking.Rank + "\nDivisions:\n";
            for (uint i = 0; i < Divisions.Length; i++) {
                LogString += Divisions[i].SerializeString();
            }
            Error(ErrorType::Error, "RefreshDivisionRanking", "Current division Invalid! Creating placeholder.", LogString);
            
            // Placeholder
            Division@ div = Division();
            div.DivisionID = "unknown";
            div.Position = 0;
            div.RuleType = DivisionRuleType::PointsRange;
            div.MinPoints = -100000;
            div.MaxPoints = 100000;
            @CurrentDivision = div;
        }

        // Check for rankup / rankdown
        if (CheckRanking) {
            if (PrevPosition < CurrentDivision.Position) startnew(PlayRankUpSound);
            if (PrevPosition > CurrentDivision.Position) startnew(PlayRankDownSound);
        }
    }

    void CreateDefaultDivisions(bool Royal = false) {
        Divisions.RemoveRange(0, Divisions.Length);
        if (!Royal) {
            const uint[] BorderPoints = {299, 599, 999, 1299, 1599, 1999, 2299, 2599, 2999, 3299, 3599, 3999, 10000};
            for (uint i = 0; i < BorderPoints.Length; i++) {
                Division@ div = Division();
                div.DivisionID = "unknown";
                div.Position = i + 1;
                div.RuleType = DivisionRuleType::PointsRange;
                if (i == 0) {
                    div.MinPoints = 0;
                } else {
                    div.MinPoints = BorderPoints[i-1];
                }
                div.MaxPoints = BorderPoints[i] - 1;
                Divisions.InsertLast(div);
            }
        } else {
            const uint[] BorderWins = {1, 10, 100, 1000};
            for (uint i = 0; i < BorderWins.Length; i++) {
                Division@ div = Division();
                div.DivisionID = "unknown";
                div.Position = i + 1;
                div.RuleType = DivisionRuleType::PointsRange;
                if (i == 0) {
                    div.MinPoints = 0;
                } else {
                    div.MinPoints = BorderWins[i-1];
                }
                div.MaxPoints = BorderWins[i] - 1;
                Divisions.InsertLast(div);
            }
        }
    }

    void SaveMatchForStats(Match@ match) {
        if (match.Status != "COMPLETED") {
            Error(ErrorType::Error, "SaveMatchForStats", "To-be saved match has to be completed!", "");
            return;
        }
        StatsMatch@ MatchSave = StatsMatch();
        int UserTeam = -1;

        // Check match MVP
        string ParticipantsResponse = SendNadeoRequest(Net::HttpMethod::Get, "https://club.trackmania.nadeo.club/api/matches/" + match.LID + "/participants");
        Json::Value ParticipantsResult = ResponseToJSON(ParticipantsResponse, Json::Type::Array);
        if (ParticipantsResult.GetType() != Json::Type::Null) {
            try {
                for (uint i = 0; i < ParticipantsResult.Length; i++) {
                    if (ParticipantsResult[i]["participant"] == GetMainUserInfo().WebServicesUserId) {
                        MatchSave.MVP = bool(ParticipantsResult[i]["mvp"]);
                        UserTeam = int(ParticipantsResult[i]["team_position"]);
                        break;
                    }
                }
            } catch {
                Error(ErrorType::Error, "SaveMatchForStats", "Something went wrong parsing the match participants result!", ParticipantsResponse);
            }
        } else {
            Error(ErrorType::Error, "SaveMatchForStats", "Couldn't parse match participants result!", ParticipantsResponse);
        }

        // Check Match team result
        string TeamResultResponse = SendNadeoRequest(Net::HttpMethod::Get, "https://club.trackmania.nadeo.club/api/matches/" + match.LID + "/teams");
        Json::Value TeamResultJSON = ResponseToJSON(TeamResultResponse, Json::Type::Array);
        if (TeamResultJSON.GetType() != Json::Type::Null) {
            try {
                for (uint i = 0; i < TeamResultJSON.Length; i++) {
                    if (TeamResultJSON[i]["position"] == UserTeam) {
                        MatchSave.TeamResult = TeamResultJSON[i]["rank"];
                        break;
                    }
                }
            } catch {
                Error(ErrorType::Error, "SaveMatchForStats", "Something went wrong parsing the match teams result!", TeamResultResponse);
            }
        } else {
            Error(ErrorType::Error, "SaveMatchForStats", "Couldn't parse match teams result!", TeamResultResponse);
        }
        
        MatchSave.LID = match.LID;
        MatchSave.Maps = match.Maps;
        MatchSave.TimeStamp = match.StartDate;
        MatchSave.PointsChange = C_Invalid;

        PlayerMatches.InsertAt(0,MatchSave);

        // @TODO save progression points for this match with current things
        startnew(RefreshPointsProgression, this);
    }

    QueueStats() {
        CreateDefaultDivisions();
    }
}

enum DivisionRuleType {
    PointsRange,
    MinimumRank,
    MinimumPoints,
    MinimumRankAndPoints,
    VictoryCount
}

class Division {
    string DivisionID;
    int Position;
    DivisionRuleType RuleType;
    int MinPoints;
    int MaxPoints;
    int MinRank;
    int MinVictories;
    int MaxVictories;

    string SerializeString() {
        string ReturnedValue = "DivisionID: " + DivisionID + "\n";
        ReturnedValue += "Position: " + Position + "\n";
        ReturnedValue += "RuleType: " + RuleType + "\n";
        ReturnedValue += "MinPoints: " + MinPoints + "\n";
        ReturnedValue += "MaxPoints: " + MaxPoints + "\n";
        ReturnedValue += "MinRank: " + MinRank + "\n";
        return ReturnedValue;
    }
}

class ProgressionPoint {
    int64 TimeStamp;
    int DataValue;
}

class QueueRanking {
    int Points = 0;
    int Rank = 0;
    int Wins = 0;
    int Cardinal = 0;
}

class QueueLeaderboard {
    bool NewPageRequested;
    bool LastPageEmpty;
    array<LeaderboardPlayer@> PlayerLeaderboard;
    uint CurrentPage;
    uint64 LastRequestStamp;
    uint FailedRequestsCount = 0;

    void RequestNextPage() {
        LastRequestStamp = Time::Now;

        // Get Leaderboard JSON
        string LeaderboardPageResponse = SendJSONRequest(Net::HttpMethod::Get, "https://trackmania.io/api/top/matchmaking/" + G_QueueState.CurrentQueue.QueueID + "/" + CurrentPage);
        Json::Value LeaderboardPage = ResponseToJSON(LeaderboardPageResponse, Json::Type::Object);
        if (LeaderboardPage.GetType() != Json::Type::Null && LeaderboardPage.HasKey("ranks")) {
            try {
                if (LeaderboardPage["ranks"].Length == 0) LastPageEmpty = true;
                for (uint i = 0; i < LeaderboardPage["ranks"].Length; i++) {
                    PlayerLeaderboard.InsertLast(LeaderboardPlayer(LeaderboardPage["ranks"][i]["rank"], LeaderboardPage["ranks"][i]["score"], Player(LeaderboardPage["ranks"][i]["player"]["id"], LeaderboardPage["ranks"][i]["player"]["name"])));
                }
                CurrentPage++;
            } catch {
                Error(ErrorType::Error, "RequestNextPage", "Cannot read rank values", LeaderboardPageResponse);
                FailedRequestsCount++;
            }
            // Yield twice : Leaderboard will be drawn, scroll cursor will be higher so we dont insta-request the next page
            yield();yield();
            NewPageRequested = false;
        } else {
            Error(ErrorType::Warn, "RequestNextPage", "Invalid leaderboard page response!", LeaderboardPageResponse);
            FailedRequestsCount++;
            uint64 WaitingTime = Time::Now + uint(Math::Pow(2, FailedRequestsCount)) * 1000;
            while (Time::Now < WaitingTime) yield();
            NewPageRequested = false;
        }
    }
}

class LeaderboardPlayer {
    int Rank;
    int Points;
    Player@ Player;

    LeaderboardPlayer(int rank, int points, Player@ player) {
        Rank = rank;
        Points = points;
        @Player = player;
    }
}

class Player {
    string AccountID;
    string DisplayName;

    Player(const string &in accountID, const string &in displayName) {
        AccountID = accountID;
        DisplayName = displayName;
    }
}

class MatchParticipant {
    LeaderboardPlayer@ Player;
    uint TeamID;

    MatchParticipant(LeaderboardPlayer@ player, uint team) {
        @Player = player;
        TeamID = team;
    }
}

class Match {
    string Name;
    string LID = "";
    uint64 StartDate;
    uint64 EndDate;
    string JoinLink;
    string Status;
    string ServerStatus;
    array<Map@> Maps;
    array<MatchParticipant@> Players;

    uint teamNum = 0;

    void RefreshFromJSON(Json::Value JSON, bool ApplyMaps = false) {
        try {
            LID = JSON["live_id"];
            if (JSON["name"].GetType() != Json::Type::Null) Name = JSON["name"];
            if (JSON["start_date"].GetType() != Json::Type::Null) StartDate = JSON["start_date"];
            if (JSON["end_date"].GetType() != Json::Type::Null) EndDate = JSON["end_date"];
            if (JSON["join_link"].GetType() != Json::Type::Null) JoinLink = JSON["join_link"];
            if (JSON["status"].GetType() != Json::Type::Null) Status = JSON["status"];
            if (JSON["server_status"].GetType() != Json::Type::Null) ServerStatus = JSON["server_status"];
        } catch {
            Error(ErrorType::Error, "Match status", "Couldn't apply new values!", Json::Write(JSON));
        }
        
        if (ApplyMaps) {
            try {
                Json::Value MapArray = JSON["game_settings"]["maps"];
                if (MapArray.Length <= 0) {
                    Error(ErrorType::Warn, "Match map array", "Map Array is empty!", Json::Write(JSON));
                    return;
                }
                Maps.RemoveRange(0, Maps.Length);
                for (uint i = 0; i < MapArray.Length; i++) {
                    Maps.InsertLast(Map(MapArray[i]["file"], G_DataState.GetMapNameFromURL(MapArray[i]["file"])));
                }
            } catch {
                Error(ErrorType::Warn, "Match map array", "Something went wrong whilst fetchting maps from match!", Json::Write(JSON));
            }
        }
    }

    void SetupPlayerData() {
        // require match state to be initialized and stuff
        if (LID == "") {
            Error(ErrorType::Error, "Match initial data", "Cannot setup initial match data when match is not initalized!", "");
            return;
        }
        
        // Get players including their MM ranks from TM.io
        string MatchStatusResponse = SendJSONRequest(Net::HttpMethod::Get, "https://trackmania.io/api/match/" + LID);
        Json::Value MatchStatus = ResponseToJSON(MatchStatusResponse, Json::Type::Object);

        uint teams = 0;
        if (MatchStatus.GetType() != Json::Type::Null && MatchStatus.HasKey("players")) {
            try {
                if (MatchStatus["players"].GetType() == Json::Type::Array) {
                    Players.RemoveRange(0, Players.Length);
                    for (uint i = 0; i < MatchStatus["players"].Length; i++) {
                        int rank = C_Invalid;
                        int points = C_Invalid;
                        try {
                            if (MatchStatus["players"][i]["matchmaking"]["typeid"] == G_QueueState.CurrentQueue.QueueID) {
                                rank = MatchStatus["players"][i]["matchmaking"]["rank"];
                                points = MatchStatus["players"][i]["matchmaking"]["score"];
                            }
                        } catch {
                            Error(ErrorType::Log, "Match players info", "Rank / score of a player couldnt be set!", "");
                        }
                        int playerTeam = 0;
                        try {
                            playerTeam = MatchStatus["players"][i]["team"];
                        } catch {
                            Error(ErrorType::Log, "Match players info", "Team of a player couldnt be set!", "");
                        }
                        try {
                            Players.InsertLast(MatchParticipant(LeaderboardPlayer(rank, points, Player(MatchStatus["players"][i]["player"]["id"], MatchStatus["players"][i]["player"]["name"])), MatchStatus["players"][i]["team"]));
                        } catch {
                            Error(ErrorType::Log, "Match players info", "Player couldnt be added to list!", "");
                        }
                        teams = Math::Max(teams, playerTeam);
                    }
                }
            } catch {
                Error(ErrorType::Error, "Match players info", "Something went wrong while fetching the match participants!", MatchStatusResponse);
            }
        } else {
            Error(ErrorType::Warn, "Trackmania.io match info", "Trackmania.io didnt know the players of the match :/", MatchStatusResponse);
        }

        teamNum = teams + 1;
    }
}

class StatsMatch {
    string LID;
    int64 TimeStamp;
    array<Map@> Maps;
    int TeamResult;
    bool MVP;
    int PointsChange;
}

class Map {
    string FileLink;
    string Name;

    Map(const string &in url, const string &in name) {
        FileLink = url;
        Name = name;
    }
}

enum ErrorType {
    Warn,
    Error,
    Log,
    UserWarning,
    Info
}

// --- Plugin State

enum QueueStatus {
    NotInQueue,
    Pending,
    SkillGapCanceled,
    Queued,
    MatchFound,
    MatchAccepted,
    MatchReady,
    Canceled,
    CanceledUser,
    Banned,
    Joining,
    InMatch,
    MatchCompleted,
    StartingQueue,
    Unknown
}

class PartyState {
    NadeoSquad@ m_NadeoSquad;
    PluginSquad@ m_PluginSquad;

    Squad@ CurrentSquad;

    string PlayWith;
    uint64 LastSquadRefreshStamp;

    PartyState() {
        SquadMember@ MainPlayer = SquadMember(Player(GetMainUserInfo().WebServicesUserId, GetMainUserInfo().Name), true);

        @m_NadeoSquad = NadeoSquad();
        m_NadeoSquad.Members.InsertLast(MainPlayer);
        @m_PluginSquad = PluginSquad();
        m_PluginSquad.Members.InsertLast(MainPlayer);
        if (Setting_UseSquads) {
            @CurrentSquad = m_NadeoSquad;
        } else {
            @CurrentSquad = m_PluginSquad;
        }
    }

    void SwitchSquadMethod() {
        if (Setting_UseSquads) {
            // Leave Nadeo Squad if we were in one
            
            @CurrentSquad = m_PluginSquad;
        } else {
            // Refresh Nadeo Squad state

            m_NadeoSquad.GetCurrent();
            @CurrentSquad = m_NadeoSquad;
        }
        Setting_UseSquads = !Setting_UseSquads;
    }

    void RefreshPlayWith() {
        Json::Value Players = Json::Object();
        Json::Value PlayWithArray = Json::Array();
        if (CurrentSquad.Exists) {
            for (uint i = 0; i < CurrentSquad.Members.Length; i++) {
                if (CurrentSquad.Members[i].Player.AccountID != GetMainUserInfo().WebServicesUserId) PlayWithArray.Add(CurrentSquad.Members[i].Player.AccountID);
            }
        }
        Players["play_with"] = PlayWithArray;
        Players["code"] = G_DataState.PartyCode;
        PlayWith = Json::Write(Players);
    }
}

class Squad {
    array<SquadMember@> Members;
    array<Player@> InvitedPlayers;
    string Name;
    uint MaxSize = 3;

    bool Exists;

    void Leave() {
        Error(ErrorType::Error, "LeaveSquad", "Tried leaving a non-Nadeo Squad", "How did you get here????");
    }

    void Create() {
        Error(ErrorType::Error, "LeaveSquad", "Tried creating a non-Nadeo Squad", "How did you get here????");
    }

    void InvitePlayer(Player@ Player) {}
    void KickMember(Player@ player) {}

    void CancelInvitation(Player@ Player) {
        Error(ErrorType::Error, "CancelInvitation", "Tried canceling an invitation of a non-Nadeo Squad", "How did you get here????");
    }

    void AddMember(Player@ player) {
        if (Members.Length >= MaxSize) {
            Error(ErrorType::UserWarning, "AddMember", "Squad is already full!", "There would be too many members.");
            return;
        }
        Members.InsertLast(SquadMember(player));
        G_QueueState.Party.RefreshPlayWith();
    }

    void RemoveMember(Player@ player) {
        for (uint i = 0; i < Members.Length; i++) {
            if (player.AccountID == Members[i].Player.AccountID) {
                if (Members[i].Player.AccountID == GetMainUserInfo().WebServicesUserId) {
                    Error(ErrorType::UserWarning, "KickMember", "You cannot remove yourself!", "Bruh");
                    return;
                }
                if (Members[i].IsLeader) {
                    Error(ErrorType::UserWarning, "KickMember", "You cannot remove the leader!", "If you are the leader yourself, leave instead!");
                    return;
                }
                Members.RemoveAt(i);
            }
        }
        G_QueueState.Party.RefreshPlayWith();
    }    
}

class PluginSquad : Squad {

    PluginSquad() {
        Exists = true;
    }

    void InvitePlayer(Player@ Player) override {
        AddMember(Player);
    }

    void KickMember(Player@ Player) override {
        RemoveMember(Player);
    }
    
}

class NadeoSquad : Squad {
    uint64 CreationTimestamp;
    uint64 UpdateTimestamp;
    string SquadID;

    NadeoSquad() {
        GetCurrent();
    }

    NadeoSquad(CSquad@ Squad) {
        Exists = (Squad !is null);
        SquadID = Squad.Id;
        CreationTimestamp = Squad.CreationTimeStamp;
        UpdateTimestamp = Squad.UpdateTimeStamp;
        Name = Squad.Name;
        MaxSize = Squad.Size;
        InvitedPlayers.RemoveRange(0,InvitedPlayers.Length);
        for (uint i = 0; i < Squad.InvitationList.Length; i++) {
            InvitedPlayers.InsertLast(Player(Squad.InvitationList[i].AccountId, Squad.InvitationList[i].DisplayName));
        }
        // improve performance down the road
        array<SquadMember@> newMembers;
        if (G_QueueState.Party.m_NadeoSquad !is null) Members = G_QueueState.Party.m_NadeoSquad.Members;
        for (uint i = 0; i < Members.Length; i++) {
            for (uint j = 0; j < Squad.MemberList.Length; j++) {
                if (Members[i].Player.AccountID == Squad.MemberList[j].AccountId) {
                    newMembers.InsertLast(Members[i]);
                    break;
                }
            }
        }
        Members = newMembers;
        for (uint j = 0; j < Squad.MemberList.Length; j++) {
            bool found = false;
            for (uint i = 0; i < Members.Length; i++) {
                if (Members[i].Player.AccountID == Squad.MemberList[j].AccountId) {
                    found = true;
                    break;
                }
            }
            if (!found) Members.InsertLast(SquadMember(Player(Squad.MemberList[j].AccountId, Squad.MemberList[j].DisplayName)));
        }
        for (uint i = 0; i < Members.Length; i++) {
            Members[i].IsLeader = (Members[i].Player.AccountID == Squad.LeaderAccountId);
        }
        G_QueueState.Party.RefreshPlayWith();
    }

    void GetCurrent() {
        startnew(GetCurrentNadeoSquad);
    }
    bool GetCurrentInProgress;

    void Create() override {
        startnew(CreateNadeoSquad);
    }
    bool CreateInProgress;

    void Leave() {
        startnew(LeaveNadeoSquad);
    }
    bool LeaveInProgress;

    void KickMember(Player@ Player) override {
        startnew(KickNadeoPlayer, Player);
    }
    bool KickMemberInProgress;

    void InvitePlayer(Player@ Player) override {
        startnew(InviteNadeoPlayer, Player);
    }
    bool InviteMemberInProgress;

    void CancelInvitation(Player@ Player) override {
        startnew(CancelNadeoInvitation, Player);
    }
    bool CancelInvitationInProgress;
}

class SquadMember {
    Player@ Player;
    bool IsLeader;

    vec3 GraphColor = hsv2rgb(vec3(Math::Rand(0.0,1.0), 0.6, 1.0));
    float[] TMIOScoreProgression = {C_Invalid};

    SquadMember(Player@ player) {
        @Player = player;
        startnew(RefreshSquadMemberProgression, this);
    }

    SquadMember(Player@ player, bool isLeader) {
        @Player = player;
        startnew(RefreshSquadMemberProgression, this);
        IsLeader = isLeader;
    }
}

void RefreshSquadMemberProgression(ref@ a) {
    SquadMember@ Member = cast<SquadMember>(a);
    if (Member is null) {
        Error(ErrorType::Warn, "RefreshSquadMemberProgression", "Passed ref cast is null!", "");
        return;
    }

    Member.TMIOScoreProgression = GetPointsHistory(Member.Player.AccountID);
}

class SquadInvitation {
    string SquadID;
    Player@ Inviter;
    uint Timestamp;

    SquadInvitation(const string &in squadID, Player@ inviter, uint timestamp) {
        SquadID = squadID;
        @Inviter = inviter;
        Timestamp = timestamp;
    }

    void Accept() {
        startnew(AcceptNadeoInvitation, StringContainer(SquadID));
        DeleteFromQueue();
    }

    void Decline() {
        startnew(DeclineNadeoInvitation, StringContainer(SquadID));
        DeleteFromQueue();
    }

    void DeleteFromQueue() {
        int Index = G_DataState.SquadInvitations.FindByRef(this);
        if (Index >= 0) {
            G_DataState.SquadInvitations.RemoveAt(Index);
        } else {
            Error(ErrorType::Error, "SquadInvitation.DeleteFromQueue", "Cannot remove invitation from internal array!", "" + Index);
        }
    }
}

class UplayFriend {
    Player@ UplayPlayer;
    string Presence;
    string Relationship;
    string PlatformType;
    string WebServicesUserId;

    UplayFriend(CFriend@ Friend) {
        string AccountID = Friend.AccountId;
        string DisplayName = Friend.DisplayName;
        @UplayPlayer = Player(AccountID, DisplayName);
        Presence = Friend.Presence;
        Relationship = Friend.Relationship;
        PlatformType = Friend.PlatformType;
        WebServicesUserId = Friend.WebServicesUserId;
    }
}

class RecentTeammate {
    Player@ Player;
    int64 LastQueueStamp;
    
    RecentTeammate(Player@ player, int64 lastStamp) {
        @Player = player;
        LastQueueStamp = lastStamp;
    }
}

class QueueState {
    bool Ready = false;

    bool IsInQueue = false;
    QueueStatus Status;
    string StatusString;
    int BonkCounter;

    bool AutoRequeue = false;
    bool InputRequired = false;

    Match@ CurrentMatch;
    bool Absent;

    PartyState@ Party;

    array<Queue@> Queues;
    Queue@ CurrentQueue;

    uint64 LastHeartbeat;
    uint64 LastHeartbeatSent;
    uint64 QueueTimeStart;

    uint64 MatchFoundTime;

    void SetStatus(QueueStatus newStatus) {
        Status = newStatus;
        switch (Status) {
            case QueueStatus::NotInQueue :
                StatusString = "Not in Queue";
                break;
            case QueueStatus::Pending :
                StatusString = "Pending for partners";
                break;
            case QueueStatus::SkillGapCanceled :
                StatusString = "\\$f99Canceled (skill gap)";
                break;
            case QueueStatus::Queued :
                StatusString = "Queued";
                break;
            case QueueStatus::MatchFound :
                StatusString = "Match found";
                break;
            case QueueStatus::MatchAccepted :
                StatusString = "Waiting for players";
                break;
            case QueueStatus::MatchReady :
                StatusString = "Match ready!";
                break;
            case QueueStatus::Canceled :
                StatusString = "Canceled";
                break;
            case QueueStatus::CanceledUser :
                StatusString = "Canceled by user";
                break;
            case QueueStatus::Banned :
                StatusString = "Banned";
                break;
            case QueueStatus::Joining :
                StatusString = "Joining";
                break;
            case QueueStatus::InMatch :
                StatusString = "In match";
                break;
            case QueueStatus::MatchCompleted :
                StatusString = "Match completed";
                break;
            case QueueStatus::StartingQueue :
                StatusString = "Starting queue...";
                break;
            default:
                StatusString = "Unknown";
        }
    }

    string GetStatusBarString() {

        // Party size
        string ReturnedValue = "\\$eee " + Icons::Users + " " + G_QueueState.Party.CurrentSquad.Members.Length;

        // Timer
        ReturnedValue += "  ";
        if (QueueTimeStart > 0) {
            // Time highscore color code
            if (Time::Now - QueueTimeStart > CurrentQueue.Stats.WaitingTimeHighscore) {
                ReturnedValue += CreateColorCode(hsv2rgb(vec3(0.175, Math::Abs(((Time::Now - QueueTimeStart) % 6000) - 3000) / 7500.0, 1.0)));
            } else {
                ReturnedValue += "\\$eee";
            }

            // Hourglass symbol
            int HourGlassValue = (Time::Stamp / 2) % 3;
            ReturnedValue += (HourGlassValue == 0 ? Icons::HourglassStart : (HourGlassValue == 1 ? Icons::HourglassHalf : Icons::HourglassEnd));

            // Timer
            ReturnedValue += Time::Format(Time::Now - QueueTimeStart, false);
        } else {
            // Display empty timer
            ReturnedValue += "\\$aaa" + Icons::Hourglass + Time::Format(0, false);
        }

        // Connection icon
        ReturnedValue += "  ";
        if (QueueTimeStart > 0) {
            if (Time::Now - Math::Max(LastHeartbeat,LastHeartbeatSent) < 10000) {
                ReturnedValue += CreateColorCode(hsv2rgb(vec3(0.33333 - Math::Abs(Time::Now - LastHeartbeat) / 30000.0, 0.8, 1.0)));
            } else {
                // No heartbeats in 10s. Sadge
                ReturnedValue += "\\$d00";
            }
        } else {
            ReturnedValue += "\\$aaa";
        }
        ReturnedValue += " " + (LastHeartbeat > LastHeartbeatSent ? Icons::Download : Icons::Upload);

        return ReturnedValue;
    }

    void AddQueue(Queue@ q) {
        if (Queues.Length == 0) @CurrentQueue = q;

        // Get and save divisions for the new queue

        string DivisionBordersResponse = SendNadeoRequest(Net::HttpMethod::Get, "https://matchmaking.trackmania.nadeo.club/api/matchmaking/" + q.QueueID + "/division/display-rules");
        Json::Value DivisionBorders = ResponseToJSON(DivisionBordersResponse, Json::Type::Object);

        if (DivisionBorders.GetType() != Json::Type::Null && DivisionBorders.HasKey("divisions")) {
            try {
                q.Stats.Divisions.RemoveRange(0,q.Stats.Divisions.Length);
                for (uint i = 0; i < DivisionBorders["divisions"].Length; i++) {
                    Division@ div = Division();
                    div.DivisionID = DivisionBorders["divisions"][i]["id"];
                    div.Position = DivisionBorders["divisions"][i]["position"];
                    
                    if (DivisionBorders["divisions"][i]["display_rule_type"] == "points_range") {
                        div.RuleType = DivisionRuleType::PointsRange;
                    } else if (DivisionBorders["divisions"][i]["display_rule_type"] == "victory_count") {
                        div.RuleType = DivisionRuleType::VictoryCount;
                    } else if (DivisionBorders["divisions"][i]["display_rule_type"] == "minimum_points") {
                        div.RuleType = DivisionRuleType::MinimumPoints;
                    } else if (DivisionBorders["divisions"][i]["display_rule_type"] == "minimum_rank") {
                        div.RuleType = DivisionRuleType::MinimumRank;
                    } else if (DivisionBorders["divisions"][i]["display_rule_type"] == "minimum_rank_and_points") {
                        div.RuleType = DivisionRuleType::MinimumRankAndPoints;
                    } else {
                        q.Stats.CreateDefaultDivisions();
                        break;
                    }
                    
                    if (DivisionBorders["divisions"][i]["display_rule_minimum_points"].GetType() == Json::Type::Number) div.MinPoints = DivisionBorders["divisions"][i]["display_rule_minimum_points"];
                    if (DivisionBorders["divisions"][i]["display_rule_maximum_points"].GetType() == Json::Type::Number) div.MaxPoints = DivisionBorders["divisions"][i]["display_rule_maximum_points"];
                    if (DivisionBorders["divisions"][i]["display_rule_minimum_rank"].GetType() == Json::Type::Number) div.MinRank = DivisionBorders["divisions"][i]["display_rule_minimum_rank"];
                    if (DivisionBorders["divisions"][i]["display_rule_minimum_victories"].GetType() == Json::Type::Number) div.MinVictories = DivisionBorders["divisions"][i]["display_rule_minimum_victories"];
                    if (DivisionBorders["divisions"][i]["display_rule_maximum_victories"].GetType() == Json::Type::Number) div.MaxVictories = DivisionBorders["divisions"][i]["display_rule_maximum_victories"];
                    q.Stats.Divisions.InsertLast(div);
                }
            } catch {
                Error(ErrorType::Error, "AddQueue", "Something went wrong when parsing the division info response! Recreating default divisions...", DivisionBordersResponse);
                q.Stats.CreateDefaultDivisions();
            }
        } else {
            Error(ErrorType::Error, "AddQueue", "Invalid division JSON received! Falling back to default.", DivisionBordersResponse);
        }

        // Division

        q.Stats.CurrentRanking = RefreshQueueRanking(q.QueueID);
        q.Stats.RefreshDivisionRanking();
        
        // @TODO
        // Now get the past matches n stuff by merging data from TM.io and the saved JSON
        // Progression, Matches
        RefreshPlayerStatus(q);
        // We know this queue exists, now get the current state
        
        // and finally, together with the stats, slot it in
        Queues.InsertLast(q);
    }

    void RefreshPlayerStatus(Queue@ q) {
        if (q.LastPlayerStatusCheck > Time::Stamp - 30) {
            Error(ErrorType::UserWarning, "RefreshPlayerStatus", "Too many requests!", "You can only refresh the maintenance status every 30 seconds. Please wait " + (30 + q.LastPlayerStatusCheck - Time::Stamp) + " more seconds!");
            return;
        }

        string PlayerStatusResponse = SendNadeoRequest(Net::HttpMethod::Get, "https://matchmaking.trackmania.nadeo.club/api/matchmaking/" + q.QueueID + "/player-status");
        Json::Value PlayerStatus = ResponseToJSON(PlayerStatusResponse, Json::Type::Object);

        if (PlayerStatus.GetType() != Json::Type::Null) {
            try {
                if (PlayerStatus.HasKey("current_heartbeat") && PlayerStatus["current_heartbeat"].GetType() == Json::Type::Object) {
                    if (GetStatusFromString(PlayerStatus["current_heartbeat"]["status"]) == QueueStatus::Canceled) {
                        Error(ErrorType::Log, "PlayerStatus", "Canceled player status. Not queueing.", PlayerStatusResponse);
                    } else if (GetStatusFromString(PlayerStatus["current_heartbeat"]["status"]) == QueueStatus::NotInQueue) {
                        G_QueueState.SetStatus(GetStatusFromString(PlayerStatus["current_heartbeat"]["status"]));
                    } else {
                        startnew(StartQueue, q);
                    }
                }
                if (PlayerStatus.HasKey("matchmaking_status") && PlayerStatus["matchmaking_status"].GetType() == Json::Type::String) {
                    q.Status = PlayerStatus["matchmaking_status"];
                }
            } catch {
                Error(ErrorType::Error, "AddQueue", "Something went wrong when getting the current heartbeat / penalty!", PlayerStatusResponse);
            }
        } else {
            Error(ErrorType::Warn, "AddQueue", "Invalid player status JSON received", PlayerStatusResponse);
        }

        q.LastPlayerStatusCheck = Time::Stamp;
    }
    
    void RefreshCurrentMatchStatus(const string &in LID, bool RefreshMaps = false) {
        string MatchStatusResponse = SendNadeoRequest(Net::HttpMethod::Get, "https://club.trackmania.nadeo.club/api/matches/" + LID);
        Json::Value MatchStatusResult = ResponseToJSON(MatchStatusResponse, Json::Type::Object);
        if (MatchStatusResult.GetType() != Json::Type::Null && MatchStatusResult.HasKey("live_id")) {
            if (G_QueueState.CurrentMatch is null) {
                Error(ErrorType::Error, "Match info", "CurrentMatch is null!", MatchStatusResponse);
                return;
            }
            try {
                G_QueueState.CurrentMatch.RefreshFromJSON(MatchStatusResult, RefreshMaps);
            } catch {
                Error(ErrorType::Error, "Match status", "Couldn't apply refreshed match status!", MatchStatusResponse);
            }
        } else {
            Error(ErrorType::Warn, "Match info", "Invalid response from server!", MatchStatusResponse);
        }
    }

    bool IncreaseBonkCounter() {
        BonkCounter++;

        if (BonkCounter > 1) {
            Error(ErrorType::UserWarning, "BonkCounter", "You failed to accept 2 matches!", "As a result, you have been stopped from queueing");
            ExitQueue();
            BonkCounter = 0;
            return true;
        } else {
            return false;
        }
    }

    QueueState() {
        @Party = PartyState();
        SetStatus(QueueStatus::NotInQueue);
    }
}

// UI System

class UIState {

    // UI values
    string LoadingString = "Loading...";
    bool InviteMenuVisible = false;
    bool ResizeMainWindow = true;
    bool ShowMatchLeaveUI = false;

    // UI data
    ColorScheme@ UserColor = ColorScheme();
    ColorScheme@ RankColor = ColorScheme();
    vec4 TabBarBottom = vec4(0.161,0.392,0.659, 1.0);

    array<Tab@> Tabs;
    array<Tab@> InviteTabs;

    // UI resources
    Resources::Font@ Bold;
    array<Resources::Texture@> T3v3Textures;
    array<Resources::Texture@> RoyalTextures;
    array<Resources::Texture@> RoyalPreviews;

    // Sounds
    dictionary SoundSamples;

    // Colors
    ColorScheme@ Red = ColorScheme(vec4(0.647,0.176,0.157, 1.0), vec4(0.98,0.275,0.251, 1.0), vec4(0.98,0.027,0.059, 1.0));
    ColorScheme@ Green = ColorScheme(vec4(0.157,0.647,0.176, 1.0), vec4(0.251,0.98,0.275, 1.0), vec4(0.059,0.98,0.027, 1.0));
    ColorScheme@ Yellow = ColorScheme(vec4(0.85,0.69,0.08, 1.0), vec4(1.,0.812,0.129, 1.0), vec4(0.902,0.71,0.027, 1.0));
    ColorScheme@ Blue = ColorScheme();

    ColorScheme@ Gray = ColorScheme();

    UIState() {
        // Load tabs
        Tabs.InsertLast(QueueTab());
        Tabs.InsertLast(PartyTab());
        Tabs.InsertLast(StatsTab());
        Tabs.InsertLast(LeaderboardTab());
        Tabs.InsertLast(HistoryTab());
        Tabs.InsertLast(SettingsTab());

        // Load invite tabs
        InviteTabs.InsertLast(TMIOSearchTab());
        InviteTabs.InsertLast(FriendsTab());
        InviteTabs.InsertLast(RecentMembersTab());

        // Load resources
        @Bold = Resources::GetFont("DroidSans-Bold.ttf");
        for (uint i = 0; i <= 13; i++) {
            Resources::Texture@ tex = Resources::GetTexture("Textures/3v3/" + i + ".png");
            if (tex is null) {
                Error(ErrorType::Error, "GetTexture", "Couldn't find the image 3v3/ " + i + ".png!", "");
            }
            T3v3Textures.InsertLast(tex);
        }
        // its panic button hotfix time heya
        for (uint i = 0; i <= 4; i++) {
            Resources::Texture@ tex = Resources::GetTexture("Textures/royal/" + i + ".png");
            if (tex is null) {
                Error(ErrorType::Error, "GetTexture", "Couldn't find the image royal/" + i + ".png!", "");
            }
            RoyalTextures.InsertLast(tex);
        }
        for (uint i = 0; i <= 4; i++) {
            Resources::Texture@ tex = Resources::GetTexture("Textures/royal/previews/" + i + ".png");
            if (tex is null) {
                Error(ErrorType::Error, "GetTexture", "Couldn't find the image royal/previews/" + i + ".png!", "");
            }
            RoyalPreviews.InsertLast(tex);
        }
        Gray.SetColor(vec4(0.3,0.3,0.3,1.0));

        // Load sound samples
        SoundSamples["InvitationNotification"] = @Resources::GetAudioSample("Sounds/InvitationNotification.wav");
        SoundSamples["MatchFound"] = @Resources::GetAudioSample("Sounds/MatchFound.wav");
        SoundSamples["PlayButtonSelect"] = @Resources::GetAudioSample("Sounds/InvitationNotification.wav");
        SoundSamples["Race3"] = @Resources::GetAudioSample("Sounds/Race3.wav");
        SoundSamples["RaceWooshStart"] = @Resources::GetAudioSample("Sounds/RaceWooshStart.wav");
        SoundSamples["RankDown"] = @Resources::GetAudioSample("Sounds/RankDown.wav");
        SoundSamples["RankUp"] = @Resources::GetAudioSample("Sounds/RankUp.wav");
    }
}

class ColorScheme {

    // These are the default colors
    vec3 Color3;
    vec4 Color4;
    vec4 ColorHover;
    vec4 ColorActive;

    void SetColor(vec3 c) {
        SetColor(vec4(c.x,c.y,c.z,0.6));
    }

    void SetColor(vec4 c) {
        Color3 = vec3(c.x,c.y,c.z);
        Color4 = c;
        ColorHover = vec4(c.x + 0.075, c.y + 0.075, c.z + 0.075, c.w + 0.1);
        ColorActive = vec4(c.x + 0.16, c.y + 0.16, c.z + 0.16, c.w + 0.2);
    }

    ColorScheme() {
        // Set default colors
        Color3 = vec3(0.161,0.392,0.659);
        Color4 = vec4(0.161,0.392,0.659, 1.0);
        ColorHover = vec4(0.251,0.592,0.98, 1.0);
        ColorActive = vec4(0.027, 0.533, 0.98, 1.0);
    }

    ColorScheme(vec4 Normal, vec4 Hover, vec4 Active) {
        Color3 = vec3(Normal.x, Normal.y, Normal.z);
        Color4 = Normal;
        ColorHover = Hover;
        ColorActive = Active;
    }
}

class Tab {
    string Label;

    void Render() {
        UI::Text("you lost the game");
    }
}

class QueueTab : Tab {
    QueueTab() {
        Label = Icons::PlayCircle + " Queue";
    }
    
    void Render() override {
        // Player preview
        UI::BeginChild("AFKQueueTabPlayers", vec2(UI::GetWindowSize().x, UI::GetWindowSize().y - 28));

        if (G_QueueState.Status == QueueStatus::InMatch) {
            if (G_QueueState.Absent && G_UIState.ShowMatchLeaveUI) {
                RenderLeaveView();
            } else {
                RenderMatchView();
            }
        } else {
            RenderSquadView();
        }

        UI::EndChild();

        // Button bar
        RenderButtonBar();
    }

    void RenderMatchView() {
        RenderMatchTitle();
        RenderMatchParticipants();
    }

    void RenderLeaveView() {
        RenderMatchTitle();
        vec2 pos_orig = UI::GetCursorPos();

        string LeaveMatchString = "Leave Match?";
        vec2 LeaveMatchSize = Draw::MeasureString(LeaveMatchString, G_UIState.Bold);
        UI::SetCursorPos(vec2((UI::GetWindowSize().x - LeaveMatchSize.x) / 2, UI::GetCursorPos().y + 10));
        BoldText(LeaveMatchString);

        bool[] Buttons = {false, false};
        Buttons = RenderTwoButtons(Icons::SignOutAlt + " Leave", Icons::Hourglass + " Stay", G_UIState.Blue, G_UIState.Gray);
        if (Buttons[0]) {
            startnew(LeaveMatch);
        }
        if (Buttons[1]) {
            G_UIState.ShowMatchLeaveUI = false;
        }
    }

    void RenderMatchParticipants() {
        if (G_QueueState.CurrentMatch.teamNum == 0) return;

        UI::Columns(G_QueueState.CurrentMatch.teamNum, "AFKQueueTabPlayersView", true);
        uint currentColumn = 0;
        for (uint i = 0; i < G_QueueState.CurrentMatch.Players.Length; i++) {
            while (G_QueueState.CurrentMatch.Players[i].TeamID != currentColumn % G_QueueState.CurrentMatch.teamNum) {
                UI::NextColumn();
                currentColumn++;
            }
            BoldText(G_QueueState.CurrentMatch.Players[i].Player.Player.DisplayName);
            UI::Text("Points: " + G_QueueState.CurrentMatch.Players[i].Player.Points);
            UI::SetCursorPos(vec2(UI::GetCursorPos().x, UI::GetCursorPos().y + 10));
        }
        UI::Columns(1);
    }

    void RenderMatchTitle() {
        vec2 pos_orig = UI::GetCursorPos();

        string MatchTitle = G_QueueState.CurrentMatch.Name + " (" + G_QueueState.CurrentMatch.Status + ")";
        int Duration = Time::Stamp - G_QueueState.CurrentMatch.StartDate;
        string MatchDuration = "Duration: " + (Duration > 1500 ? "\\$fcc" : "\\$cfc") + Time::Format(Duration * 1000, false);

        vec2 SquadNameSize = Draw::MeasureString(MatchTitle, G_UIState.Bold);
        UI::SetCursorPos(vec2((UI::GetWindowSize().x - SquadNameSize.x) / 2, UI::GetCursorPos().y + 10));
        BoldText(MatchTitle);

        vec2 MatchDurationSize = Draw::MeasureString(MatchDuration);
        UI::SetCursorPos(vec2((UI::GetWindowSize().x - MatchDurationSize.x) / 2, UI::GetCursorPos().y));
        UI::Text(MatchDuration);

        UI::SetCursorPos(vec2(pos_orig.x, UI::GetCursorPos().y + 6));
    }

    void RenderSquadView() {
        RenderSquadTitle();

        UI::Columns(G_QueueState.Party.CurrentSquad.Members.Length, "AFKQueueTabPlayersView", false);
        for (uint i = 0; i < G_QueueState.Party.CurrentSquad.Members.Length; i++) {
            UI::BeginChild("AFKQueueTabPlayers" + i);

            RenderPlayerView(G_QueueState.Party.CurrentSquad.Members[i]);

            UI::EndChild();
            UI::NextColumn();
        }
        UI::Columns(1);
    }

    void RenderSquadTitle() {
        vec2 pos_orig = UI::GetCursorPos();

        vec2 SquadNameSize = Draw::MeasureString(G_QueueState.Party.CurrentSquad.Name, G_UIState.Bold);
        UI::PushStyleColor(UI::Col::Text, vec4(0.7,0.7,0.7,1.0));
        UI::SetCursorPos(vec2((UI::GetWindowSize().x - SquadNameSize.x) / 2, UI::GetWindowSize().y / 6 - 6));
        BoldText(G_QueueState.Party.CurrentSquad.Name);
        UI::PopStyleColor(1);

        UI::SetCursorPos(pos_orig);
    }

    void RenderPlayerView(SquadMember@ member) {
        vec2 pos_orig = UI::GetCursorPos();

        vec2 PlayerNameSize = Draw::MeasureString(member.Player.DisplayName, G_UIState.Bold);

        UI::SetCursorPos(vec2(-2,0));
        UI::PushStyleColor(UI::Col::FrameBg, vec4(0,0,0,0));
        UI::PushStyleColor(UI::Col::PlotLines, vec4(member.GraphColor.x, member.GraphColor.y, member.GraphColor.z ,0.2));
        UI::PushStyleColor(UI::Col::PlotLinesHovered, vec4(member.GraphColor.x, member.GraphColor.y, member.GraphColor.z ,0.3));
        UI::PushStyleColor(UI::Col::Text, vec4(0,0,0,0));
        UI::PushStyleColor(UI::Col::PopupBg, vec4(0,0,0,0));
        UI::SetNextItemWidth(UI::GetWindowSize().x + 4);
        if (member.TMIOScoreProgression[0] != C_Invalid) UI::PlotLines("", member.TMIOScoreProgression, 0, UI::GetWindowSize().y);
        UI::PopStyleColor(5);

        UI::SetCursorPos(vec2((UI::GetWindowSize().x - PlayerNameSize.x) / 2, UI::GetWindowSize().y / 2 - 14));
        BoldText(member.Player.DisplayName);

        UI::SetCursorPos(pos_orig);
    }

    void RenderButtonBar() {
        bool[] Buttons = {false, false};
        switch (G_QueueState.Status) {
            case QueueStatus::SkillGapCanceled :
            case QueueStatus::NotInQueue :
            case QueueStatus::MatchCompleted :
            case QueueStatus::Banned :
            case QueueStatus::CanceledUser :
                RenderPartyCode();
                if (RenderOneButton(Icons::Play + " Enter Queue", (Setting_ColoredUI ? G_UIState.UserColor : null)) && !G_QueueState.IsInQueue) {
                    if (G_QueueState.CurrentQueue.Status == "under_maintenance") {
                        Error(ErrorType::Info, "Starting Queue Button", "This queue is under maintenance!", "Starting a maintenance status check...");
                        startnew(PlayerStatusCheck, G_QueueState.CurrentQueue);
                        break;
                    }
                    G_QueueState.IsInQueue = true;
                    startnew(QueueLoop);
                }
                break;
            case QueueStatus::Pending :
            case QueueStatus::Queued :
            case QueueStatus::Canceled :
            case QueueStatus::StartingQueue :
                RenderPartyCode();
                if (RenderOneButton(Icons::Stop + " Exit Queue", (Setting_ColoredUI ? G_UIState.Red : null)) && G_QueueState.IsInQueue) {
                    G_QueueState.IsInQueue = false;
                    ExitQueue();
                }
                break;
            case QueueStatus::MatchFound :
                Setting_AutoAccept = RenderSettingChoice(Setting_AutoAccept, "Auto-Accept");
                if (!Setting_AutoAccept) {
                    Buttons = RenderTwoButtons(Icons::Check + " Accept", Icons::Times + " Cancel", G_UIState.Green, G_UIState.Red);
                    if (Buttons[0]) {
                        startnew(SendAccept);
                        G_QueueState.SetStatus(QueueStatus::MatchAccepted);
                    }
                    if (Buttons[1]) {
                        G_QueueState.IsInQueue = false;
                        ExitQueue();
                    }
                } else if (G_QueueState.InputRequired) {
                    if (RenderOneButton("PLEASE PROVIDE INPUT", G_UIState.Green)) {
                        startnew(SendAccept);
                        startnew(PlayMatchFoundInputReceivedSound);
                        G_QueueState.InputRequired = false;
                        G_QueueState.SetStatus(QueueStatus::MatchAccepted);
                    }
                }
                break;
            case QueueStatus::MatchAccepted :
            case QueueStatus::MatchReady :
                break;
            case QueueStatus::Joining :
                Buttons = RenderTwoButtons(Icons::Play + " Join manually", Icons::Clipboard, G_UIState.Blue, G_UIState.Yellow);
                if (Buttons[0]) {
                    JoinServer();
                }
                if (Buttons[1]) {
                    CopyMatchID();
                }
                break;
            case QueueStatus::InMatch :
                G_QueueState.AutoRequeue = RenderSettingChoice(G_QueueState.AutoRequeue, "Auto-Requeue");
                Buttons = RenderTwoButtons(Icons::Clipboard + " Copy MatchID", Icons::Play, G_UIState.Yellow, G_UIState.Blue);
                if (Buttons[0]) {
                    CopyMatchID();
                }
                if (Buttons[1]) {
                    JoinServer();
                }
                break;
        }
    }

    // - Layout: Center label
    void RenderLabel(const string &in Label) {
        vec2 pos_orig = UI::GetCursorPos();

        vec2 LabelSize = Draw::MeasureString(Label, G_UIState.Bold);
        UI::SetCursorPos(vec2((UI::GetWindowSize().x - LabelSize.x) / 2, UI::GetCursorPos().y));
        BoldText(Label);

        UI::SetCursorPos(pos_orig);
    }

    // - Layout: One main button
    bool RenderOneButton(const string &in Label, ColorScheme@ Color) {
        vec2 pos_orig = UI::GetCursorPos();
        bool ReturnedValue;

        vec2 ButtonSize = Draw::MeasureString(Label + "__");

        if (Color !is null) {
            UI::PushStyleColor(UI::Col::Button, Color.Color4);
            UI::PushStyleColor(UI::Col::ButtonHovered, Color.ColorHover);
            UI::PushStyleColor(UI::Col::ButtonActive, Color.ColorActive);
        }

        UI::SetCursorPos(vec2((UI::GetWindowSize().x - ButtonSize.x) / 2, UI::GetWindowSize().y - 24));
        ReturnedValue = UI::Button(Label);

        if (Color !is null) UI::PopStyleColor(3);

        UI::SetCursorPos(pos_orig);
        return ReturnedValue;
    }

    // - Layout: Two Buttons
    bool[] RenderTwoButtons(const string &in LabelA, const string &in LabelB, ColorScheme@ ColorA, ColorScheme@ ColorB) {
        vec2 pos_orig = UI::GetCursorPos();
        bool[] ReturnedValue = {false,false};

        vec2 ButtonASize = Draw::MeasureString(LabelA + "__");
        vec2 TotalSize = Draw::MeasureString(LabelA + "__" + LabelB + "__");

        if (ColorA !is null) {
            UI::PushStyleColor(UI::Col::Button, ColorA.Color4);
            UI::PushStyleColor(UI::Col::ButtonHovered, ColorA.ColorHover);
            UI::PushStyleColor(UI::Col::ButtonActive, ColorA.ColorActive);
        }

        UI::SetCursorPos(vec2((UI::GetWindowSize().x - TotalSize.x) / 2 - 2, UI::GetWindowSize().y - 24));
        ReturnedValue[0] = UI::Button(LabelA);

        if (ColorA !is null) UI::PopStyleColor(3);

        if (ColorB !is null) {
            UI::PushStyleColor(UI::Col::Button, ColorB.Color4);
            UI::PushStyleColor(UI::Col::ButtonHovered, ColorB.ColorHover);
            UI::PushStyleColor(UI::Col::ButtonActive, ColorB.ColorActive);
        }

        UI::SetCursorPos(vec2((UI::GetWindowSize().x - TotalSize.x) / 2 + ButtonASize.x + 4, UI::GetWindowSize().y - 24));
        ReturnedValue[1] = UI::Button(LabelB);

        if (ColorB !is null) UI::PopStyleColor(3);

        UI::SetCursorPos(pos_orig);
        return ReturnedValue;
    }

    // - Setting checkbox
    bool RenderSettingChoice(bool Value, const string &in Label) {
        bool newValue;
        vec2 pos_orig = UI::GetCursorPos();
        UI::SetCursorPos(vec2(0, UI::GetWindowSize().y - 24));
        newValue = UI::Checkbox(Label, Value);
        UI::SetCursorPos(pos_orig);
        return newValue;
    }

    void RenderPartyCode() {
        vec2 pos_orig = UI::GetCursorPos();
        if (G_QueueState.IsInQueue) {
            UI::Text(G_DataState.PartyCode);
        } else {
            UI::SetCursorPos(vec2(pos_orig.x, pos_orig.y - 2));
            UI::SetNextItemWidth(82);
            G_DataState.PartyCode = UI::InputText("Party Code", G_DataState.PartyCode);
            UI::SetCursorPos(vec2(UI::GetWindowSize().x - Draw::MeasureString("_______Code").x, pos_orig.y - 2));
            if (UI::Button(Icons::PlusSquare + " Code")) {
                startnew(GenerateNewPartyCode);
            }
        }
        UI::SetCursorPos(pos_orig);
    }

}

class PartyTab : Tab {
    PartyTab() {
        Label = Icons::UserCircle + " Party";
    }

    void Render() override {
        RenderSquadChoice();
        
        if (!G_QueueState.Party.CurrentSquad.Exists && Setting_UseSquads) {
            RenderSquadCreation();
        } else {
            if (Setting_UseSquads) RenderLeaveButton();
            if (UI::Button(Icons::Users + "  " + (Setting_UseSquads ? "Invite" : "Add") + " Players")) {
                startnew(GetFriendList);
                G_UIState.InviteMenuVisible = true;
            }
            RenderSquadMembers();
        }
        RenderInvitations();
    }

    void RenderSquadChoice() {
        vec2 pos_orig = UI::GetCursorPos();
        string UseSquadsString = "Use Squads";
        vec2 CheckboxLabelSize = Draw::MeasureString(UseSquadsString);
        string SizeString = UseSquadsString + "XXIXX";
        vec2 CheckboxSize = Draw::MeasureString(SizeString);
    
        UI::SetCursorPos(vec2(UI::GetWindowSize().x - CheckboxSize.x, pos_orig.y + 4));
        UI::Text(UseSquadsString);
        UI::SetCursorPos(vec2(UI::GetWindowSize().x - CheckboxSize.x + CheckboxLabelSize.x + 6, pos_orig.y));
        if (UI::Checkbox("", Setting_UseSquads) != Setting_UseSquads) G_QueueState.Party.SwitchSquadMethod();
        UI::SetCursorPos(pos_orig);
    }

    void RenderSquadCreation() {
        UI::BeginChild("AFKSquadCreation", vec2(UI::GetWindowSize().x - 16, (UI::GetWindowSize().y - UI::GetCursorPos().y) / 2));
        if (G_QueueState.Party.m_NadeoSquad.GetCurrentInProgress) {
            string SquadRefreshString = "Loading...";
            vec2 SquadRefreshSize = Draw::MeasureString(SquadRefreshString, G_UIState.Bold);
            UI::SetCursorPos((UI::GetWindowSize() - SquadRefreshSize) / 2.0);
            BoldText(SquadRefreshString);
        } else if (G_QueueState.Party.m_NadeoSquad.CreateInProgress) {
            string SquadCreationString = "Creating Squad...";
            vec2 SquadCreationSize = Draw::MeasureString(SquadCreationString, G_UIState.Bold);
            UI::SetCursorPos((UI::GetWindowSize() - SquadCreationSize) / 2.0);
            BoldText(SquadCreationString);
        } else {
            UI::SetNextItemWidth(UI::GetWindowSize().x / 2.0);
            BoldText("Create Squad:");
            UI::SetCursorPos(vec2(UI::GetWindowSize().x / 4.0 - 36, UI::GetWindowSize().y / 2.0 - 8));
            bool pressed = UI::Button(Icons::PlusCircle);
            UI::SetCursorPos(vec2(UI::GetWindowSize().x / 4.0, UI::GetWindowSize().y / 2.0 - 8));
            UI::SetNextItemWidth(UI::GetWindowSize().x / 2.0);
            bool StartCreation = false;
            G_DataState.SquadCreationName = UI::InputText("Squad Name", G_DataState.SquadCreationName, StartCreation, UI::InputTextFlags::EnterReturnsTrue);
            if (StartCreation || pressed) {
                G_QueueState.Party.CurrentSquad.Create();
            }
        }
        UI::EndChild();
    }

    void RenderSquadMembers() {
        UI::BeginChild("AFKSquadMembers", vec2(UI::GetWindowSize().x, (UI::GetWindowSize().y - UI::GetCursorPos().y) / 2));
        if (UI::BeginTable("SquadMembers", 2, UI::TableFlags::ScrollY)) {
            UI::TableSetupScrollFreeze(0, 1);
            UI::TableSetupColumn(" ", UI::TableColumnFlags::WidthFixed, 30);
            UI::TableSetupColumn("Members", UI::TableColumnFlags::WidthStretch);
            UI::TableHeadersRow();

            for (uint i = 0; i < G_QueueState.Party.CurrentSquad.Members.Length; i++) {
                UI::PushID("SquadMember" + i);
                if (G_QueueState.Party.CurrentSquad.Members[i].Player.AccountID != GetMainUserInfo().WebServicesUserId) {
                    UI::TableNextRow();
                    
                    UI::TableSetColumnIndex(0);
                    UI::PushStyleColor(UI::Col::Button, G_UIState.Red.Color4);
                    UI::PushStyleColor(UI::Col::ButtonHovered, G_UIState.Red.ColorHover);
                    UI::PushStyleColor(UI::Col::ButtonActive, G_UIState.Red.ColorActive);
                    if (!G_QueueState.Party.CurrentSquad.Members[i].IsLeader && UI::Button(Icons::Times)) {
                        G_QueueState.Party.CurrentSquad.KickMember(G_QueueState.Party.CurrentSquad.Members[i].Player);
                        UI::PopStyleColor(3);
                        UI::PopID();
                        break;
                    }
                    UI::PopStyleColor(3);

                    UI::TableSetColumnIndex(1);
                    UI::Text(G_QueueState.Party.CurrentSquad.Members[i].Player.DisplayName);
                } else {
                    UI::TableNextRow();
                    UI::TableSetColumnIndex(1);
                    UI::Text("\\$999" + G_QueueState.Party.CurrentSquad.Members[i].Player.DisplayName);
                }
                UI::PopID();
            }

            for (uint i = 0; i < G_QueueState.Party.CurrentSquad.InvitedPlayers.Length; i++) {
                UI::PushID("InvitedMember" + i);
                UI::TableNextRow();

                UI::TableSetColumnIndex(0);
                UI::PushStyleColor(UI::Col::Button, G_UIState.Red.Color4);
                UI::PushStyleColor(UI::Col::ButtonHovered, G_UIState.Red.ColorHover);
                UI::PushStyleColor(UI::Col::ButtonActive, G_UIState.Red.ColorActive);
                if (UI::Button(Icons::UserTimes) && !G_QueueState.Party.m_NadeoSquad.InviteMemberInProgress) {
                    G_QueueState.Party.CurrentSquad.CancelInvitation(G_QueueState.Party.CurrentSquad.InvitedPlayers[i]);
                    UI::PopStyleColor(3);
                    UI::PopID();
                    break;
                }
                UI::PopStyleColor(3);

                UI::TableSetColumnIndex(1);
                UI::Text(G_QueueState.Party.CurrentSquad.InvitedPlayers[i].DisplayName + " \\$999(Invited)");
                UI::PopID();
            }

            if (RenderRefreshButton()) {
                if (G_QueueState.Party.LastSquadRefreshStamp + 60000 < Time::Now) {
                    startnew(GetCurrentNadeoSquad);
                } else {
                    Error(ErrorType::Info, "RefreshNadeoSquadButton", "You can't refresh yet!", "Please wait " + Math::Floor((G_QueueState.Party.LastSquadRefreshStamp + 60000 - Time::Now) / 1000) + " more seconds until you can refresh. Refreshing a Nadeo squad state manually should only be used when the squad isnt showing correctly for you.");
                }
            }

            UI::EndTable();
        }
        UI::EndChild();
    }

    void RenderInvitations() {
        UI::BeginChild("AFKSquadInvitations", vec2(UI::GetWindowSize().x, UI::GetWindowSize().y - UI::GetCursorPos().y));

        Setting_ReceiveNotifications = UI::Checkbox("Receive Squad Invitations through this Plugin\n(and NOT the native menu in the live tab)", Setting_ReceiveNotifications);
        if (UI::IsItemHovered()) {
            UI::BeginTooltip();
            UI::Text("Remember: Only the plugin OR the native Matchmaking menu can receive invitations.");
            UI::Text("This is a limitation on how the invites are managed in this game.");
            UI::Text("If you just want to queue normally with your Uplay friends, it's perfectly fine to disable this and use Nadeo's own menu.");
            UI::EndTooltip();
        }
        
        if (Setting_ReceiveNotifications) {
            if (UI::BeginTable("SquadInvites", 2, UI::TableFlags::ScrollY)) {
                UI::TableSetupScrollFreeze(0, 1);
                UI::TableSetupColumn(" ", UI::TableColumnFlags::WidthFixed, 72);
                UI::TableSetupColumn("Invitations", UI::TableColumnFlags::WidthStretch);
                UI::TableHeadersRow();

                for (uint i = 0; i < G_DataState.SquadInvitations.Length; i++) {
                    UI::TableNextRow();
                    UI::PushID("SquadInvite" + i);

                    UI::TableSetColumnIndex(0);
                        UI::PushStyleColor(UI::Col::Button, G_UIState.Red.Color4);
                        UI::PushStyleColor(UI::Col::ButtonHovered, G_UIState.Red.ColorHover);
                        UI::PushStyleColor(UI::Col::ButtonActive, G_UIState.Red.ColorActive);
                        if (UI::Button(Icons::Times)) {
                            G_DataState.SquadInvitations[i].Decline();
                            UI::PopStyleColor(3);
                            UI::PopID();
                            break;
                        }
                        UI::PushStyleColor(UI::Col::Button, G_UIState.Green.Color4);
                        UI::PushStyleColor(UI::Col::ButtonHovered, G_UIState.Green.ColorHover);
                        UI::PushStyleColor(UI::Col::ButtonActive, G_UIState.Green.ColorActive);
                        UI::SameLine();
                        if (UI::Button(Icons::Check)) {
                            G_DataState.SquadInvitations[i].Accept();
                            UI::PopStyleColor(6);
                            UI::PopID();
                            break;
                        }
                        UI::PopStyleColor(6);

                        UI::TableSetColumnIndex(1);
                        UI::Text(G_DataState.SquadInvitations[i].Inviter.DisplayName + " \\$999 invited " + Time::Format((Time::Stamp - G_DataState.SquadInvitations[i].Timestamp) * 1000, false) + " ago");

                    UI::PopID();
                }

                UI::EndTable();
            }
        }

        if (G_DataState.NotificationsAvailable) {
            UI::Text("\\$999Notifications are available.");
        }

        UI::EndChild();
    }

    void RenderLeaveButton() {
        vec2 pos_orig = UI::GetCursorPos();
        if (G_QueueState.Party.m_NadeoSquad.LeaveInProgress) {
            string ProgressString = "Closing Squad...";
            vec2 ProgressSize = Draw::MeasureString(ProgressString);
            UI::SetCursorPos(vec2((UI::GetWindowSize().x - ProgressSize.x) / 2.0, pos_orig.y));
            BoldText(ProgressString);
        } else {
            string LeaveString = Icons::WindowClose + " Leave Squad";
            vec2 LeaveSize = Draw::MeasureString(LeaveString  + "__");
            UI::SetCursorPos(vec2((UI::GetWindowSize().x - LeaveSize.x) / 2.0, pos_orig.y));
            UI::PushStyleColor(UI::Col::Button, G_UIState.Red.Color4);
            UI::PushStyleColor(UI::Col::ButtonHovered, G_UIState.Red.ColorHover);
            UI::PushStyleColor(UI::Col::ButtonActive, G_UIState.Red.ColorActive);
            if (UI::Button(LeaveString)) {
                G_QueueState.Party.CurrentSquad.Leave();
            }
            UI::PopStyleColor(3);
        }
        UI::SetCursorPos(pos_orig);
    }

}

class StatsTab : Tab {
    StatsTab() {
        Label = Icons::ChartLine + " Stats";
    }

    void Render() override {
        // I have decided that Trackmania.io stats tracking is better because it saves the point progression more accurately.
        // If I get back to this, you will be able to customize the timeframe of past matches as tracked by Trackmania.io
        
        RenderLabel("View your stats on Trackmania.io:");
        if (RenderOneButton(Icons::ExternalLinkAlt + "  View", (Setting_ColoredUI ? G_UIState.UserColor : null))) {
            OpenBrowserURL("https://trackmania.io/#/player/" + GetMainUserInfo().WebServicesUserId);
        }
    }

    void RenderLabel(const string &in Label) {
        vec2 pos_orig = UI::GetCursorPos();

        vec2 LabelSize = Draw::MeasureString(Label, G_UIState.Bold);
        UI::SetCursorPos(vec2((UI::GetWindowSize().x - LabelSize.x) / 2, UI::GetWindowSize().y / 2 - 14));
        BoldText(Label);

        UI::SetCursorPos(pos_orig);
    }

    // - Layout: One main button
    bool RenderOneButton(const string &in Label, ColorScheme@ Color) {
        vec2 pos_orig = UI::GetCursorPos();
        bool ReturnedValue;

        vec2 ButtonSize = Draw::MeasureString(Label + "__");

        if (Color !is null) {
            UI::PushStyleColor(UI::Col::Button, Color.Color4);
            UI::PushStyleColor(UI::Col::ButtonHovered, Color.ColorHover);
            UI::PushStyleColor(UI::Col::ButtonActive, Color.ColorActive);
        }

        UI::SetCursorPos(vec2((UI::GetWindowSize().x - ButtonSize.x) / 2, UI::GetWindowSize().y / 2 + 14));
        ReturnedValue = UI::Button(Label);

        if (Color !is null) UI::PopStyleColor(3);

        UI::SetCursorPos(pos_orig);
        return ReturnedValue;
    }
}

class LeaderboardTab : Tab {
    LeaderboardTab() {
        Label = Icons::Trophy + " Top";
    }

    void Render() override {
        if (UI::BeginTable("LeaderboardTop", 3, UI::TableFlags::ScrollY)) {
            UI::TableSetupScrollFreeze(0, 1);
            UI::TableSetupColumn("Rank", UI::TableColumnFlags::WidthFixed, 32);
            UI::TableSetupColumn("Points", UI::TableColumnFlags::WidthFixed, 40);
            UI::TableSetupColumn("Player", UI::TableColumnFlags::WidthStretch);
            
            UI::TableHeadersRow();

            UI::ListClipper Clipper(G_QueueState.CurrentQueue.Stats.Leaderboard.PlayerLeaderboard.Length);

            while (Clipper.Step()) {
                for (int i = Clipper.DisplayStart; i < Clipper.DisplayEnd; i++) {
                    UI::TableNextRow();

                    UI::TableSetColumnIndex(0);
                    UI::Text("" + G_QueueState.CurrentQueue.Stats.Leaderboard.PlayerLeaderboard[i].Rank);
                    UI::TableSetColumnIndex(1);
                    UI::Text("" + G_QueueState.CurrentQueue.Stats.Leaderboard.PlayerLeaderboard[i].Points);
                    UI::TableSetColumnIndex(2);
                    UI::Text("" + G_QueueState.CurrentQueue.Stats.Leaderboard.PlayerLeaderboard[i].Player.DisplayName);
                }
            }

            if (G_QueueState.CurrentQueue.Stats.Leaderboard.LastPageEmpty) {
                UI::TableNextRow();
                UI::TableSetColumnIndex(2);
                UI::Text("End of Leaderboard (last page was empty)");
            } else if (!G_QueueState.CurrentQueue.Stats.Leaderboard.NewPageRequested && (UI::GetScrollY() >= UI::GetScrollMaxY() - 24)) {
                // Start request
                G_QueueState.CurrentQueue.Stats.Leaderboard.NewPageRequested = true;
                startnew(RequestNextLeaderboardPage);
            } else if (G_QueueState.CurrentQueue.Stats.Leaderboard.NewPageRequested) {
                UI::TableNextRow();
                UI::TableSetColumnIndex(2);
                UI::Text("Loading...");
            }

            if (RenderRefreshButton()) {
                if (G_QueueState.CurrentQueue.Stats.Leaderboard.LastRequestStamp + 300000 < Time::Now) {
                    G_QueueState.CurrentQueue.Stats.Leaderboard.CurrentPage = 0;
                    G_QueueState.CurrentQueue.Stats.Leaderboard.PlayerLeaderboard = {};
                } else {
                    Error(ErrorType::Info, "RefreshButton", "You can't refresh yet!", "Please wait " + Math::Floor((G_QueueState.CurrentQueue.Stats.Leaderboard.LastRequestStamp + 300000 - Time::Now) / 1000) + " more seconds until you can refresh. The Trackmania.io Leaderboard refreshes every few minutes and is not real-time.");
                }
            }

            UI::EndTable();
        }
        
    }
}

class HistoryTab : Tab {
    HistoryTab() {
        Label = Icons::Book + " History";
    }

    void Render() override {

        if (UI::BeginTable("MatchHistory", 4, UI::TableFlags::ScrollY)) {
            UI::TableSetupScrollFreeze(0, 1);
            UI::TableSetupColumn("Result", UI::TableColumnFlags::WidthFixed, 64);
            UI::TableSetupColumn("Date", UI::TableColumnFlags::WidthFixed, UI::GetWindowSize().x * 0.3);
            UI::TableSetupColumn("Map", UI::TableColumnFlags::WidthFixed, UI::GetWindowSize().x * 0.3);
            UI::TableSetupColumn("Action", UI::TableColumnFlags::WidthStretch);
            UI::TableHeadersRow();

            UI::ListClipper Clipper(G_QueueState.CurrentQueue.Stats.PlayerMatches.Length);

            while (Clipper.Step()) {
                for (int i = Clipper.DisplayStart; i < Clipper.DisplayEnd; i++) {
                    UI::TableNextRow();
                    UI::PushID("MatchHistory" + i);

                    UI::TableSetColumnIndex(0);
                    if (G_QueueState.CurrentQueue.Stats.PlayerMatches[i].TeamResult == 1) {
                        UI::Text("\\$afa" + Icons::Trophy);
                    } else {
                        BoldText("\\$ccc" + GetPlacementFromRank(G_QueueState.CurrentQueue.Stats.PlayerMatches[i].TeamResult));
                    }
                    if (G_QueueState.CurrentQueue.Stats.PlayerMatches[i].MVP) {
                        UI::SameLine();
                        UI::Text(Icons::Star);
                    }
                    UI::TableSetColumnIndex(1);
                    UI::Text("" + Time::FormatString("%x %X",G_QueueState.CurrentQueue.Stats.PlayerMatches[i].TimeStamp));
                    UI::TableSetColumnIndex(2);
                    string MapString = "";
                    if (G_QueueState.CurrentQueue.Stats.PlayerMatches[i].Maps.Length < 1) {
                        MapString = "???";
                    } else {
                        MapString = G_QueueState.CurrentQueue.Stats.PlayerMatches[i].Maps[0].Name;
                        if (G_QueueState.CurrentQueue.Stats.PlayerMatches[i].Maps.Length > 1) MapString += ", \\$888... (" + (G_QueueState.CurrentQueue.Stats.PlayerMatches[i].Maps.Length - 1) + ")";
                    }
                    UI::Text(MapString);
                    UI::TableSetColumnIndex(3);
                    if (UI::Button(Icons::ExternalLinkAlt + " TM.io")) {
                        OpenBrowserURL("https://trackmania.io/#/match/" + G_QueueState.CurrentQueue.Stats.PlayerMatches[i].LID);
                    }
                    UI::PopID();
                }
            }
            
            UI::EndTable();
        }
    }
}

class SettingsTab : Tab {
    SettingsTab() {
        Label = Icons::Wrench + " Settings";
    }

    void Render() override {
        UI::PushStyleColor(UI::Col::Separator, vec4(0.3, 0.3, 0.3, 0.6));

        BoldText("Sounds");
        Setting_SoundVolume = UI::SliderFloat("Notification Volume", Setting_SoundVolume, 0, 100);
        if (UI::Button(Icons::Bell + " Test sound")) startnew(PlayInfoSound);

        UI::Separator();

        BoldText("UI");
        Setting_ColoredUI = UI::Checkbox("Use custom colors", Setting_ColoredUI);
        if (UI::IsItemHovered()) {
            UI::BeginTooltip();
            UI::Text("Enable this to have the menu tabs colored after your Matchmaking rank!");
            UI::Text("The \"Enter Queue\" button is also colored after your Trails color in the TM Profile settings.");
            UI::EndTooltip();
        }
        
        UI::Separator();

        BoldText("Notifications");
        UI::SetCursorPos(vec2(UI::GetCursorPos().x, UI::GetCursorPos().y + 2));
        UI::Text("Play invitiation sounds for: ");
        UI::SetCursorPos(vec2(UI::GetCursorPos().x + Draw::MeasureString("Play invitiation sounds for: _____").x, UI::GetCursorPos().y - 26));
        UI::SetNextItemWidth(UI::GetWindowSize().x - UI::GetCursorPos().x - 32);
        if (UI::BeginCombo("", G_DataState.NotificationSettings[Setting_ShowInviteNotif])) {
            // probably not the best way to get rid of an unsigned / signed mismatch, but I cant have a uint type setting xd
            for (int i = 0; uint(i) < G_DataState.NotificationSettings.Length; i++) {
                if (UI::Selectable(G_DataState.NotificationSettings[i], i == Setting_ShowInviteNotif)) {
                    Setting_ShowInviteNotif = i;
                }
            }
            UI::EndCombo();
        }

        Setting_HideWarn = UI::Checkbox("Hide silent warning popups", Setting_HideWarn);
        if (UI::IsItemHovered()) {
            UI::BeginTooltip();
            UI::Text("These popups should only concern you if they repeatedly happen every ~5s or so.");
            UI::Text("You can mute them if you want (but don't complain about stuff stopping to work without you noticing!)");
            UI::EndTooltip();
        }

        //@TODO decide pepega
        // Hey. If you read this, hope you're having fun with the plugin!
        // While I do all my plugin stuff and work in my free time, a lot of effort went into this and
        // I have been almost overworking myself at some point.
        // I was asked recently why I wouldn't pay some TM twitch subs I got gifted myself
        // - Well, I don't feel like I got the money to spend it on twitch subs for example.
        // Everthing I do here has been and is non-profit and you should never have to pay me to use plugins like this.
        // Already the pressure of people "wanting to get something in return for the money" and potentially jump into burn-out cause of that
        // keeps me from doing it. But I have been thinking lately of a way to support what I do, fully optional, in case you like what I do.
        // I'd wholeheartedly appreciate any support, let it be a paypal donation, a giftsub on twitch or whatever.
        // It motivates me to do more awesome stuff like this. Thank you.
        /*
        UI::Separator();
        BoldText("Support Me!");
        if (UI::Button(Icons::Brands::Paypal + " Paypal Donation (fully optional)")) {
            //<paypal.me link or smth idk>
        }
        */

        UI::PopStyleColor(1);
    }
}

class TMIOSearchTab : Tab {
    TMIOSearchTab() {
        Label = Icons::Search + " TM.io Search";
    }

    void Render() override {
        // Search bar
        bool StartSearch = false;
        G_DataState.TMIOSearchString = UI::InputText("Search", G_DataState.TMIOSearchString, StartSearch, UI::InputTextFlags::EnterReturnsTrue | (G_DataState.TMIOSearchResultsValid ? 0 : UI::InputTextFlags::ReadOnly));
        if (StartSearch) startnew(TMIOSearch);

        // Search results

        if (!G_DataState.TMIOSearchResultsValid) {
            string SearchingString = "Searching...";
            vec2 SearchingSize = Draw::MeasureString(SearchingString);
            UI::SetCursorPos((UI::GetWindowSize() - SearchingSize) / 2);
            UI::Text(SearchingString);
            return;
        }
        
        if (UI::BeginTable("TMIOSearchResults", 3, UI::TableFlags::ScrollY)) {
            UI::TableSetupScrollFreeze(0,1);
            UI::TableSetupColumn(" ", UI::TableColumnFlags::WidthFixed, 30);
			UI::TableSetupColumn("Name", UI::TableColumnFlags::WidthStretch);
			UI::TableSetupColumn("Points", UI::TableColumnFlags::WidthFixed, UI::GetWindowSize().x * 0.3);
			UI::TableHeadersRow();

            UI::ListClipper Clipper(G_DataState.TMIOSearchResults.Length);
            while (Clipper.Step()) {

                for (int i = Clipper.DisplayStart; i < Clipper.DisplayEnd; i++) {
                    UI::TableNextRow();
                    UI::PushID("TMIOUser" + i);

                    // Button Column
                    UI::TableSetColumnIndex(0);
                    bool UserInParty = false;
                    bool UserLocked = false;
                    bool UserInvited = false;

                    for (uint j = 0; j < G_QueueState.Party.CurrentSquad.Members.Length; j++) {
			    		if (G_DataState.TMIOSearchResults[i].Player.AccountID == G_QueueState.Party.CurrentSquad.Members[j].Player.AccountID) {
                            UserInParty = true;
                            if (G_QueueState.Party.CurrentSquad.Members[j].IsLeader || G_QueueState.Party.CurrentSquad.Members[j].Player.AccountID == GetMainUserInfo().WebServicesUserId) UserLocked = true;
                            break;
                        }
			    	}

                    for (uint j = 0; j < G_QueueState.Party.CurrentSquad.InvitedPlayers.Length; j++) {
                        if (G_DataState.TMIOSearchResults[i].Player.AccountID == G_QueueState.Party.CurrentSquad.InvitedPlayers[j].AccountID) {
                            UserInvited = true;
                            break;
                        }
                    }

                    // Decide button color
                    if (UserLocked) {
                        UI::PushStyleColor(UI::Col::Button, G_UIState.Gray.Color4);
                        UI::PushStyleColor(UI::Col::ButtonHovered, G_UIState.Gray.ColorHover);
                        UI::PushStyleColor(UI::Col::ButtonActive, G_UIState.Gray.ColorActive);
                    } else if (UserInParty) {
                        UI::PushStyleColor(UI::Col::Button, G_UIState.Red.Color4);
                        UI::PushStyleColor(UI::Col::ButtonHovered, G_UIState.Red.ColorHover);
                        UI::PushStyleColor(UI::Col::ButtonActive, G_UIState.Red.ColorActive);
                    } else if (UserInvited) {
                        UI::PushStyleColor(UI::Col::Button, G_UIState.Blue.Color4);
                        UI::PushStyleColor(UI::Col::ButtonHovered, G_UIState.Blue.ColorHover);
                        UI::PushStyleColor(UI::Col::ButtonActive, G_UIState.Blue.ColorActive);
                    } else {
                        UI::PushStyleColor(UI::Col::Button, G_UIState.Green.Color4);
                        UI::PushStyleColor(UI::Col::ButtonHovered, G_UIState.Green.ColorHover);
                        UI::PushStyleColor(UI::Col::ButtonActive, G_UIState.Green.ColorActive);
                    }

                    // Decide button label / action
                    if (UserInParty) {
                        if (UI::Button(Icons::UserTimes) && !G_QueueState.Party.m_NadeoSquad.KickMemberInProgress) {
                            G_QueueState.Party.CurrentSquad.KickMember(G_DataState.TMIOSearchResults[i].Player);
                        }
                    } else {
                        if (UI::Button(Icons::UserPlus) && !G_QueueState.Party.m_NadeoSquad.InviteMemberInProgress && !UserInvited) {
                            G_QueueState.Party.CurrentSquad.InvitePlayer(G_DataState.TMIOSearchResults[i].Player);
                        }
                    }

                    UI::PopStyleColor(3);

                    // Name
                    UI::TableSetColumnIndex(1);
                    UI::Text(G_DataState.TMIOSearchResults[i].Player.DisplayName);

                    // Ranking
                    UI::TableSetColumnIndex(2);
                    if (G_DataState.TMIOSearchResults[i].Points != C_Invalid || G_DataState.TMIOSearchResults[i].Rank != C_Invalid)
                        UI::Text("" + G_DataState.TMIOSearchResults[i].Points + " \\$999(#" + G_DataState.TMIOSearchResults[i].Rank + ")");

                    UI::PopID();
                }
            }

            UI::EndTable();
        }
    }
}

class FriendsTab : Tab {
    FriendsTab() {
        Label = Icons::UserCircle + " Uplay Friends";
    }

    void Render() override {
        if (!G_DataState.FriendListValid) {
            string SearchingString = "Loading...";
            vec2 SearchingSize = Draw::MeasureString(SearchingString);
            UI::SetCursorPos((UI::GetWindowSize() - SearchingSize) / 2);
            UI::Text(SearchingString);
            return;
        }

        if (UI::BeginTable("UplayFriendsList", 3, UI::TableFlags::ScrollY)) {
            UI::TableSetupScrollFreeze(0,1);
            UI::TableSetupColumn(" ", UI::TableColumnFlags::WidthFixed, 30);
			UI::TableSetupColumn("Friend", UI::TableColumnFlags::WidthStretch);
			UI::TableSetupColumn("Relationship", UI::TableColumnFlags::WidthFixed, UI::GetWindowSize().x * 0.3);
			UI::TableHeadersRow();

            UI::ListClipper Clipper(G_DataState.UplayFriends.Length);
            while (Clipper.Step()) {
                
                for (int i = Clipper.DisplayStart; i < Clipper.DisplayEnd; i++) {
                    UI::TableNextRow();
                    UI::PushID("UplayFriend" + i);

                    // Button Column
                    UI::TableSetColumnIndex(0);
                    bool UserInParty = false;
                    bool UserLocked = false;
                    bool UserInvited = false;

                    for (uint j = 0; j < G_QueueState.Party.CurrentSquad.Members.Length; j++) {
			    		if (G_DataState.UplayFriends[i].UplayPlayer.AccountID == G_QueueState.Party.CurrentSquad.Members[j].Player.AccountID) {
                            UserInParty = true;
                            if (G_QueueState.Party.CurrentSquad.Members[j].IsLeader || G_QueueState.Party.CurrentSquad.Members[j].Player.AccountID == GetMainUserInfo().Name) UserLocked = true;
                            break;
                        }
			    	}

                    for (uint j = 0; j < G_QueueState.Party.CurrentSquad.InvitedPlayers.Length; j++) {
                        if (G_DataState.UplayFriends[i].UplayPlayer.AccountID == G_QueueState.Party.CurrentSquad.InvitedPlayers[j].AccountID) {
                            UserInvited = true;
                            break;
                        }
                    }

                    // Decide button color
                    if (UserLocked) {
                        UI::PushStyleColor(UI::Col::Button, G_UIState.Gray.Color4);
                        UI::PushStyleColor(UI::Col::ButtonHovered, G_UIState.Gray.ColorHover);
                        UI::PushStyleColor(UI::Col::ButtonActive, G_UIState.Gray.ColorActive);
                    } else if (UserInParty) {
                        UI::PushStyleColor(UI::Col::Button, G_UIState.Red.Color4);
                        UI::PushStyleColor(UI::Col::ButtonHovered, G_UIState.Red.ColorHover);
                        UI::PushStyleColor(UI::Col::ButtonActive, G_UIState.Red.ColorActive);
                    } else if (UserInvited) {
                        UI::PushStyleColor(UI::Col::Button, G_UIState.Blue.Color4);
                        UI::PushStyleColor(UI::Col::ButtonHovered, G_UIState.Blue.ColorHover);
                        UI::PushStyleColor(UI::Col::ButtonActive, G_UIState.Blue.ColorActive);
                    } else {
                        UI::PushStyleColor(UI::Col::Button, G_UIState.Green.Color4);
                        UI::PushStyleColor(UI::Col::ButtonHovered, G_UIState.Green.ColorHover);
                        UI::PushStyleColor(UI::Col::ButtonActive, G_UIState.Green.ColorActive);
                    }

                    // Decide button label / action
                    if (UserInParty) {
                        if (UI::Button(Icons::UserTimes) && !G_QueueState.Party.m_NadeoSquad.KickMemberInProgress) {
                            G_QueueState.Party.CurrentSquad.KickMember(G_DataState.UplayFriends[i].UplayPlayer);
                        }
                    } else {
                        if (UI::Button(Icons::UserPlus) && !G_QueueState.Party.m_NadeoSquad.InviteMemberInProgress && !UserInvited) {
                            G_QueueState.Party.CurrentSquad.InvitePlayer(G_DataState.UplayFriends[i].UplayPlayer);
                        }
                    }

                    UI::PopStyleColor(3);

                    // Name
                    string PresenceString = "";
                    UI::TableSetColumnIndex(1);
                    if (G_DataState.UplayFriends[i].Presence == "Online") {
                        PresenceString += "\\$3A5" + Icons::Circle;
                    } else if (G_DataState.UplayFriends[i].Presence == "DoNotDisturb") {
                        PresenceString += "\\$E44" + Icons::Circle;
                    } else if (G_DataState.UplayFriends[i].Presence == "Away") {
                        PresenceString += "\\$FA1" + Icons::Circle;
                    } else {
                        PresenceString += "\\$777" + Icons::Circle;
                    }

                    UI::Text(PresenceString + " \\$fff" + G_DataState.UplayFriends[i].UplayPlayer.DisplayName);

                    // Relationship
                    UI::TableSetColumnIndex(2);
                    UI::Text(G_DataState.UplayFriends[i].Relationship + " \\$aaa(" + G_DataState.UplayFriends[i].PlatformType + ")");

                    UI::PopID();
                }
            }

            UI::EndTable();
        }
    }
}

class RecentMembersTab : Tab {
    RecentMembersTab() {
        Label = Icons::ClipboardList + " Recent";
    }

    void Render() override {
        if (UI::BeginTable("RecentTeammatesList", 3, UI::TableFlags::ScrollY)) {
            UI::TableSetupScrollFreeze(0,1);
            UI::TableSetupColumn(" ", UI::TableColumnFlags::WidthFixed, 30);
			UI::TableSetupColumn("Player", UI::TableColumnFlags::WidthStretch);
			UI::TableSetupColumn("Last queue", UI::TableColumnFlags::WidthFixed, UI::GetWindowSize().x * 0.3);
			UI::TableHeadersRow();

            UI::ListClipper Clipper(G_DataState.RecentMembers.Length);
            while (Clipper.Step()) {
                
                for (int i = Clipper.DisplayStart; i < Clipper.DisplayEnd; i++) {
                    UI::TableNextRow();
                    UI::PushID("RecentMember" + i);

                    // Button Column
                    UI::TableSetColumnIndex(0);
                    bool UserInParty = false;
                    bool UserLocked = false;
                    bool UserInvited = false;

                    for (uint j = 0; j < G_QueueState.Party.CurrentSquad.Members.Length; j++) {
			    		if (G_DataState.RecentMembers[i].Player.AccountID == G_QueueState.Party.CurrentSquad.Members[j].Player.AccountID) {
                            UserInParty = true;
                            if (G_QueueState.Party.CurrentSquad.Members[j].IsLeader || G_QueueState.Party.CurrentSquad.Members[j].Player.AccountID == GetMainUserInfo().Name) UserLocked = true;
                            break;
                        }
			    	}

                    for (uint j = 0; j < G_QueueState.Party.CurrentSquad.InvitedPlayers.Length; j++) {
                        if (G_DataState.RecentMembers[i].Player.AccountID == G_QueueState.Party.CurrentSquad.InvitedPlayers[j].AccountID) {
                            UserInvited = true;
                            break;
                        }
                    }

                    // Decide button color
                    if (UserLocked) {
                        UI::PushStyleColor(UI::Col::Button, G_UIState.Gray.Color4);
                        UI::PushStyleColor(UI::Col::ButtonHovered, G_UIState.Gray.ColorHover);
                        UI::PushStyleColor(UI::Col::ButtonActive, G_UIState.Gray.ColorActive);
                    } else if (UserInParty) {
                        UI::PushStyleColor(UI::Col::Button, G_UIState.Red.Color4);
                        UI::PushStyleColor(UI::Col::ButtonHovered, G_UIState.Red.ColorHover);
                        UI::PushStyleColor(UI::Col::ButtonActive, G_UIState.Red.ColorActive);
                    } else if (UserInvited) {
                        UI::PushStyleColor(UI::Col::Button, G_UIState.Blue.Color4);
                        UI::PushStyleColor(UI::Col::ButtonHovered, G_UIState.Blue.ColorHover);
                        UI::PushStyleColor(UI::Col::ButtonActive, G_UIState.Blue.ColorActive);
                    } else {
                        UI::PushStyleColor(UI::Col::Button, G_UIState.Green.Color4);
                        UI::PushStyleColor(UI::Col::ButtonHovered, G_UIState.Green.ColorHover);
                        UI::PushStyleColor(UI::Col::ButtonActive, G_UIState.Green.ColorActive);
                    }

                    // Decide button label / action
                    if (UserInParty) {
                        if (UI::Button(Icons::UserTimes) && !G_QueueState.Party.m_NadeoSquad.KickMemberInProgress) {
                            G_QueueState.Party.CurrentSquad.KickMember(G_DataState.RecentMembers[i].Player);
                        }
                    } else {
                        if (UI::Button(Icons::UserPlus) && !G_QueueState.Party.m_NadeoSquad.InviteMemberInProgress && !UserInvited) {
                            G_QueueState.Party.CurrentSquad.InvitePlayer(G_DataState.RecentMembers[i].Player);
                        }
                    }

                    UI::PopStyleColor(3);
                    UI::TableSetColumnIndex(1);

                    // Player name
                    UI::Text(G_DataState.RecentMembers[i].Player.DisplayName);

                    // Last match Timestamp
                    UI::TableSetColumnIndex(2);
                    UI::Text("" + Time::FormatString("%x %X",G_DataState.RecentMembers[i].LastQueueStamp));
                    

                    UI::PopID();
                }
            }

            UI::EndTable();
        }
    }
}

// Data System

class DataState {
    bool FriendListValid;
    uint64 LastFriendListRefresh;
    array<UplayFriend@> UplayFriends;

    string TMIOSearchString;
    bool TMIOSearchResultsValid = true;
    array<LeaderboardPlayer@> TMIOSearchResults;

    array<RecentTeammate@> RecentMembers;

    string SquadCreationName = GetMainUserInfo().Name + "'s Squad";

    array<SquadInvitation@> SquadInvitations;
    string PartyCode = "";
    
    string[] FoundMatchMessages = {
        "LETS GOOOO",
        "Ready to get sniped? PepeLaugh",
        "PauseChamp",
        "I hope this didn't ruin a run..",
        "DinkDonk",
        "Posture Check",
        "Stay hydrated!",
        "Sending acceleration penalties...",
        "Building Terrain...",
        "Do not read this line! You can read the one above tho."
    };

    uint64 LastActivityTick;
    uint LastActivityType;

    string[] NotificationSettings = {
        "Everyone",
        "Friends only",
        "No-one"
    };
    bool NotificationsAvailable;

    string[] StatsSettings = {
        "All",
        "Past month",
        "Past week",
        "Past 24 hours",
        "Today"
    };

    void AddRecentMembers() {
        for (uint i = 0; i < G_QueueState.Party.CurrentSquad.Members.Length; i++) {
            if (G_QueueState.Party.CurrentSquad.Members[i].Player.AccountID != GetMainUserInfo().WebServicesUserId) {
                bool found = false;
                for (uint j = 0; j < RecentMembers.Length; j++) {
                    if (G_QueueState.Party.CurrentSquad.Members[i].Player.AccountID == RecentMembers[j].Player.AccountID) {
                        RecentMembers[j].LastQueueStamp = Time::Stamp;
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    RecentMembers.InsertLast(RecentTeammate(G_QueueState.Party.CurrentSquad.Members[i].Player, Time::Stamp));
                }
            }
        }
        if (RecentMembers.Length > 1) RecentMembers.Sort(CompareRecentMembers);
        while (RecentMembers.Length > 10) RecentMembers.RemoveLast();
    }

    string GetMapNameFromURL(const string &in URL) {
		string[] Directories = URL.Split("/");
        if (Directories.get_Length() <= 0) {
            Error(ErrorType::Error, "Map name resolver", "Cannot split URL!", URL);
            return URL;
        }
		return Directories[Directories.get_Length() - 1].Replace(".Map.Gbx","").Replace("_"," ");
    }

    DataState() {
        startnew(GetFriendList);
    }
}

// -- Coroutine argument containers

class StringContainer {
    string s;

    StringContainer(const string &in str) {
        s = str;
    }
}

// --- Globals

QueueState@ G_QueueState;
UIState@ G_UIState;
DataState@ G_DataState;

// --- Settings

[Setting name="Use Squads" description="Use Nadeo's invite-based Squads, allowing you to play with non-plugin players." hidden]
bool Setting_UseSquads = true;

[Setting name="Notification Volume" drag min="0" max="100" description="Drag this slider to change the volume of notification sounds."]
float Setting_SoundVolume = 30.0f;

[Setting name="Use custom UI colors" description="Enable this to have the menu tabs colored after your Matchmaking rank!"]
bool Setting_ColoredUI = true;

[Setting name="Hide silent warning popups" description="These popups should only concern you if they repeatedly happen every ~5s or so. You can mute them if you want (but don't complain about stuff stopping to work without you noticing!)"]
bool Setting_HideWarn = false;

[Setting name="Auto-Accept" description="Automatically accept any incoming matches!"]
bool Setting_AutoAccept = true;

[Setting name="Show window" hidden]
bool Setting_WindowVisible = true;

[Setting name="Play sounds for invitations from" min="0" max="2" hidden]
int Setting_ShowInviteNotif = 0;

[Setting name="Show stats in the timeframe of" min="0" max="4" hidden]
int Setting_ShowPastStats = 0;

[Setting name="Receive Squadding Notifications" description="Receive Squadding Notifications through the Plugin and NOT the Nadeo menu (only one works)"]
bool Setting_ReceiveNotifications = false;

// === METHODS ===

void Main() {
    // Initialize states
    @G_QueueState = QueueState();
    @G_UIState = UIState();
    @G_DataState = DataState();

    // Fill initalized states with data
    InitializeQueues();
    InitializeUI();

    // Start notification loop
    startnew(NotificationLoop);

    // Loading done?
    if (G_QueueState.Queues.Length > 0) {
        G_QueueState.Ready = true;
    } else {
        G_UIState.LoadingString = "\\$f88Loading failed! Please check the log.";
    }
}

// --- Init

void InitializeQueues() {
    if (G_UIState !is null) G_UIState.LoadingString = "Loading Queues...";

    // Completely hardcode this now thanks to API update *sigh*
    array<QueueTemplate@> KnownQueues;
    KnownQueues.InsertLast(QueueTemplate(2, "Teams 3v3"));
    KnownQueues.InsertLast(QueueTemplate(3, "Royal"));

    for (uint i = 0; i < KnownQueues.Length; i++) {
        try {
            Queue@ NewQueue = Queue();
            NewQueue.QueueID = KnownQueues[i].QueueID;
            NewQueue.Name = KnownQueues[i].Name;
            G_QueueState.AddQueue(NewQueue);
        } catch {
            Error(ErrorType::Error, "InitializeQueues", "Unknown error while adding queue " + KnownQueues[i].Name + "!", "");
        }
    }
}

void InitializeUI() {
    if (G_UIState !is null) G_UIState.LoadingString = "Loading UI Data...";

    auto app = cast<CTrackMania>(GetApp());

    // Set user color
    if (app.ManiaPlanetScriptAPI.UserMgr.Users.Length >= 1) {
        G_UIState.UserColor.SetColor(hsv2rgb(vec3(app.ManiaPlanetScriptAPI.UserMgr.Users[0].Config.User_LightTrailHue, 0.7, 0.8)));
    }

    RefreshRankColor();
}

// Init loop: someone has a match currently!
void StartQueue(ref@ q) {
    Queue@ queue = cast<Queue>(q);
    if (queue is null) {
        Error(ErrorType::Error, "StartQueue", "It looks like you have a match in progress but I can't find it, please join it manually!", "");
        return;
    }
    
    while (!G_QueueState.Ready) yield();
    @G_QueueState.CurrentQueue = queue;
    G_QueueState.IsInQueue = true;
    startnew(QueueLoop);
}

// --- Main Loops

// Notification loop: Always run, just yield if you shouldnt check
void NotificationLoop() {
    while (true) {
        try {
            RefreshNotifications();
            yield();
        } catch {
            Error(ErrorType::Error, "InvitationLoop", "Something went wrong when checking notifications!", "");
        }
    }
}

// Queue Loop: Runs while queueing
void QueueLoop() {
    bool FirstHeartbeat = true;
    G_QueueState.SetStatus(QueueStatus::StartingQueue);
    G_QueueState.IsInQueue = true;
    G_QueueState.QueueTimeStart = Time::Now;
    G_QueueState.Party.RefreshPlayWith();
    try {
        G_DataState.AddRecentMembers();
        //@DEBUG SaveStats();
    } catch {
        Error(ErrorType::Error, "QueueLoop", "Couldn't save stats to keep up with recent team members.", "");
    }
    while (true) {
        try {
            if (!G_QueueState.IsInQueue && !FirstHeartbeat) break;
            uint64 NextHeartbeat = Time::Now + 5000;
            SendHeartbeat();
            FirstHeartbeat = false;
            while (Time::Now < NextHeartbeat && G_QueueState.IsInQueue) yield();
        } catch {
            Error(ErrorType::Error, "QueueLoop", "Something went wrong in the queue communication!", "");
        }
    }
    G_QueueState.QueueTimeStart = 0;
}

// Match Loop: Runs while in match
void MatchLoop() {
    // Get initial match info
    G_QueueState.SetStatus(QueueStatus::InMatch);
    G_QueueState.Absent = false;
    G_UIState.ShowMatchLeaveUI = true;
    while (true) {
        try {
            if (G_QueueState.Status != QueueStatus::InMatch) break;
            uint64 NextRefresh = Time::Now + 12000;
            CheckRoyalMatchLeft();
            G_QueueState.RefreshCurrentMatchStatus(G_QueueState.CurrentMatch.LID);
            ParseCurrentMatchStatus();
            while (Time::Now < NextRefresh && G_QueueState.Status == QueueStatus::InMatch) yield();
        } catch {
            Error(ErrorType::Error, "MatchLoop", "Something went wrong in the match status check!", "");
        }
    }
}

// --- Loop tasks

void RefreshNotifications() {
    auto app = cast<CTrackMania>(GetApp());

    G_DataState.NotificationsAvailable = cast<CGameWebServicesNotificationManagerScript>(app.ManiaPlanetScriptAPI.WSNotificationMgr).Notification_IsAvailable(GetMainUserId());

    if (Setting_ReceiveNotifications) {
        while (cast<CGameWebServicesNotificationManagerScript>(app.ManiaPlanetScriptAPI.WSNotificationMgr).Notification_IsAvailable(GetMainUserId())) {
            CWebServicesTaskResult_WSNotificationScript@ nextNotificationResult = cast<CGameWebServicesNotificationManagerScript>(app.ManiaPlanetScriptAPI.WSNotificationMgr).Notification_PopNext(GetMainUserId());
            while (nextNotificationResult.IsProcessing) yield();
            if (nextNotificationResult.HasSucceeded) {
                if (nextNotificationResult.Notification.Type == "SquadInvitationReceived") {
                    CNotification_SquadInvitationReceived@ squadInvitationResult = cast<CNotification_SquadInvitationReceived>(nextNotificationResult.Notification);
                    string SquadID = squadInvitationResult.SquadId;
                    Player@ Inviter = Player(squadInvitationResult.InviterAccountId, squadInvitationResult.InviterDisplayName);
                    NotifyInvitation(Inviter);
                    G_DataState.SquadInvitations.InsertLast(SquadInvitation(SquadID, Inviter, squadInvitationResult.TimeStamp));
                } else if (nextNotificationResult.Notification.Type == "SquadInvitationCanceled") {
                    CNotification_SquadInvitationCanceled@ squadCanceledResult = cast<CNotification_SquadInvitationCanceled>(nextNotificationResult.Notification);
                    string SquadID = squadCanceledResult.SquadId;
                    for (uint i = 0; i < G_DataState.SquadInvitations.Length; i++) {
                        if (G_DataState.SquadInvitations[i].SquadID == SquadID && G_DataState.SquadInvitations[i].Inviter.AccountID == squadCanceledResult.CancelerAccountId) {
                            G_DataState.SquadInvitations[i].DeleteFromQueue();
                            break;
                        }
                    }
                    startnew(RefreshNadeoSquad);
                } else if (nextNotificationResult.Notification.Type == "SquadInvitationCanceledForExitingPlayer") {
                    CNotification_SquadInvitationCanceledForExitingPlayer@ squadCanceledForExitingPlayerResult = cast<CNotification_SquadInvitationCanceledForExitingPlayer>(nextNotificationResult.Notification);
                    string SquadID = squadCanceledForExitingPlayerResult.SquadId;
                    for (uint i = 0; i < G_DataState.SquadInvitations.Length; i++) {
                        if (G_DataState.SquadInvitations[i].SquadID == SquadID) {
                            G_DataState.SquadInvitations[i].DeleteFromQueue();
                        }
                    }
                    startnew(RefreshNadeoSquad);
                } else if (nextNotificationResult.Notification.Type == "SquadInvitationCanceledForFullSquad") {
                    CNotification_SquadInvitationCanceledForFullSquad@ squadCanceledForFullSquadResult = cast<CNotification_SquadInvitationCanceledForFullSquad>(nextNotificationResult.Notification);
                    string SquadID = squadCanceledForFullSquadResult.SquadId;
                    for (uint i = 0; i < G_DataState.SquadInvitations.Length; i++) {
                        if (G_DataState.SquadInvitations[i].SquadID == SquadID) {
                            G_DataState.SquadInvitations[i].DeleteFromQueue();
                        }
                    }
                    startnew(RefreshNadeoSquad);
                } else if (nextNotificationResult.Notification.Type == "SquadDeleted") {
                    CNotification_SquadDeleted@ squadDeletedResult = cast<CNotification_SquadDeleted>(nextNotificationResult.Notification);
                    string SquadID = squadDeletedResult.SquadId;
                    if (SquadID == G_QueueState.Party.m_NadeoSquad.SquadID) {
                        G_QueueState.Party.m_NadeoSquad.Exists = false;
                        G_QueueState.Party.m_NadeoSquad.Name = "";
                    }
                    for (uint i = 0; i < G_DataState.SquadInvitations.Length; i++) {
                        if (G_DataState.SquadInvitations[i].SquadID == SquadID) {
                            G_DataState.SquadInvitations[i].DeleteFromQueue();
                        }
                    }
                } else if (nextNotificationResult.Notification.Type == "SquadInvitationAccepted" || nextNotificationResult.Notification.Type == "SquadInvitationDeclined" || nextNotificationResult.Notification.Type == "SquadMemberRemoved" || nextNotificationResult.Notification.Type == "SquadMemberKicked"|| nextNotificationResult.Notification.Type == "SquadInvitationAdded") {
                    startnew(RefreshNadeoSquad);
                } else {
                    Error(ErrorType::Warn, "Notification_PopNext", "Unknown notification type! Please report this to Nsgr with the Log <3", nextNotificationResult.Notification.Type);
                }
            } else {
                Error(ErrorType::Error, "Notification_PopNext", nextNotificationResult.ErrorDescription, nextNotificationResult.ErrorCode);
            }
            cast<CGameWebServicesNotificationManagerScript>(app.ManiaPlanetScriptAPI.WSNotificationMgr).TaskResult_Release(nextNotificationResult.Id);
        }
    }   

}

void NotifyInvitation(Player@ player) {
    ShowInviteNotification(player.DisplayName);
    switch (Setting_ShowInviteNotif) {
        case 0:
            startnew(PlayInviteSound);
            break;
        case 1:
            for (uint i = 0; i < G_DataState.UplayFriends.Length; i++) {
                if (G_DataState.UplayFriends[i].UplayPlayer.AccountID == player.AccountID) {
                    startnew(PlayInviteSound);
                    return;
                }
            }
            break;
        case 2:
            break;
        default:
            Error(ErrorType::Error, "NotifyInvitation", "Invalid Setting for Notification privacy", "" + Setting_ShowInviteNotif);
            Setting_ShowInviteNotif = 2;
    }
}

void ShowInviteNotification(const string &in InviterName) {
    UI::ShowNotification("\\$2f7" + Icons::EnvelopeOpen + " New invitation from " + InviterName, 10000);
}

void SendHeartbeat() {
    G_QueueState.LastHeartbeatSent = Time::Now;
    string HeartbeatResponse = SendNadeoRequest(Net::HttpMethod::Post, "https://matchmaking.trackmania.nadeo.club/api/matchmaking/" + G_QueueState.CurrentQueue.QueueID + "/heartbeat", G_QueueState.Party.PlayWith);
    Json::Value HeartbeatResult = ResponseToJSON(HeartbeatResponse, Json::Type::Object);
    if (!G_QueueState.IsInQueue) {
        Error(ErrorType::Log, "Queue communication", "Match canceled between heartbeat send and receive...", HeartbeatResponse);
        return;
    }
    if (HeartbeatResult.GetType() != Json::Type::Null && HeartbeatResult.HasKey("status")) {
        G_QueueState.LastHeartbeat = Time::Now;
        QueueStatus ReceivedStatus = GetStatusFromString(HeartbeatResult["status"]);
        string BanInfoString = "BONK!";
        switch (ReceivedStatus) {
            case QueueStatus::Pending :
            case QueueStatus::Queued :
            case QueueStatus::MatchAccepted :
                break;
            case QueueStatus::Canceled :
                if (Time::Now > G_QueueState.MatchFoundTime + C_MatchFoundTimeout && G_QueueState.Status == QueueStatus::MatchFound) {
                    if (G_QueueState.IncreaseBonkCounter()) return;
                }
                break;
            case QueueStatus::SkillGapCanceled :
                G_QueueState.IsInQueue = false;
                break;
            case QueueStatus::Banned :
                G_QueueState.IsInQueue = false;
                if (HeartbeatResult.HasKey("ban_end_date") && HeartbeatResult["ban_end_date"].GetType() == Json::Type::Number) {
                    BanInfoString = "You ban ends in " + Time::Format((uint(HeartbeatResult["ban_end_date"]) - Time::Stamp) * 1000) + ".";
                }
                Error(ErrorType::UserWarning, "You are banned from the queue!", BanInfoString, HeartbeatResponse);
                break;
            case QueueStatus::MatchFound :
                if (G_QueueState.Status != QueueStatus::MatchFound) {
                    G_QueueState.MatchFoundTime = Time::Now;
                    G_QueueState.Status = QueueStatus::MatchFound;
                    startnew(FoundMatch);
                }
                break;
            case QueueStatus::MatchReady :
                if (G_QueueState.Status != QueueStatus::MatchReady && G_QueueState.Status != QueueStatus::MatchAccepted && G_QueueState.Status != QueueStatus::MatchAccepted) {
                    cast<CTrackMania>(GetApp()).ManiaPlanetScriptAPI.FlashWindow();
                    UI::ShowNotification("\\$2f7" + Icons::SignInAlt + " Match found!", G_DataState.FoundMatchMessages[Math::Rand(0, G_DataState.FoundMatchMessages.Length - 1)], TimeUntilAcceptTimeout());
                    startnew(PlayMatchFoundSound);
                }
                if (HeartbeatResult.HasKey("match_live_id") && HeartbeatResult["match_live_id"].GetType() != Json::Type::Null) {
                    G_QueueState.IsInQueue = false;
                    G_QueueState.MatchFoundTime = 0;
                    @G_QueueState.CurrentMatch = Match();
                    // Get initial match loop
                    while (G_QueueState.CurrentMatch.LID == "") {
                        G_QueueState.RefreshCurrentMatchStatus(HeartbeatResult["match_live_id"], true);
                        if (G_QueueState.CurrentMatch.LID == "") sleep(5000);
                    }
                    startnew(JoinMatch);
                    G_QueueState.CurrentMatch.SetupPlayerData();
                    return;
                }
                break;
            default:
                Error(ErrorType::Error, "Queue communication", "Unknown heartbeat status!", HeartbeatResponse);
        }
        G_QueueState.SetStatus(ReceivedStatus);
    } else {
        Error(ErrorType::Warn, "Queue communication", "Invalid response from server!", HeartbeatResponse);
    }
}

void FoundMatch() {
    cast<CTrackMania>(GetApp()).ManiaPlanetScriptAPI.FlashWindow();
    G_QueueState.InputRequired = false;
    if (Setting_AutoAccept) {
        if (Time::Now < GetMostRecentInputTick() + 10000) {
            UI::ShowNotification("\\$2f7" + Icons::SignInAlt + " Match found and accepted!", "PauseChamp", TimeUntilAcceptTimeout());
            startnew(SendAccept);
            startnew(PlayMatchFoundSound);
            return;
        } else {
            UI::ShowNotification("\\$2f7" + Icons::SignInAlt + " Match found, but are you AFK?", "PLEASE PROVIDE INPUT TO CONFIRM YOU ARE THERE", TimeUntilAcceptTimeout());
            startnew(PlayMatchFoundInputSound);
        }
    } else {
        UI::ShowNotification("\\$2f7" + Icons::SignInAlt + " Match found!", "Please Accept in the overlay!", TimeUntilAcceptTimeout());
        startnew(PlayMatchFoundInputSound);
        return;
    }
    G_QueueState.InputRequired = true;
    while (G_QueueState.Status == QueueStatus::MatchFound && Time::Now < G_QueueState.MatchFoundTime + C_MatchFoundTimeout + C_MatchFoundTimeout) {
        if (Time::Now < GetMostRecentInputTick() + 5000) {
            startnew(SendAccept);
            string NotificationString = "Received ";
            switch (G_DataState.LastActivityType) {
                case 0:
                    NotificationString += "keyboard";
                    break;
                case 1:
                    NotificationString += "mouse";
                    break;
                case 2:
                    NotificationString += "pad";
                    break;
                default:
                    NotificationString += "unknown";
            }
            NotificationString += " input!";
            UI::ShowNotification("\\$2f7" + Icons::SignInAlt + " Match accepted!", NotificationString, TimeUntilAcceptTimeout());
            startnew(PlayMatchFoundInputReceivedSound);
            G_QueueState.InputRequired = false;
            return;
        }
        yield();
    }
}

uint64 GetMostRecentInputTick() {
    uint64 MostRecentPadDelay = Time::Now;
    auto InputPort = cast<CTrackMania>(GetApp()).InputPort;
    for (uint i = 0; i < InputPort.Script_Pads.Length; i++) {
        MostRecentPadDelay = Math::Min(MostRecentPadDelay, InputPort.Script_Pads[i].IdleDuration);
    }
    return Math::Max(G_DataState.LastActivityTick, Time::Now - MostRecentPadDelay);
}

int TimeUntilAcceptTimeout() {
    return G_QueueState.MatchFoundTime + C_MatchFoundTimeout - Time::Now;
}

void SendAccept() {
    SendNadeoRequest(Net::HttpMethod::Post, "https://matchmaking.trackmania.nadeo.club/api/matchmaking/" + G_QueueState.CurrentQueue.QueueID + "/accept");
}

void SendCancel() {
    SendNadeoRequest(Net::HttpMethod::Post, "https://matchmaking.trackmania.nadeo.club/api/matchmaking/" + G_QueueState.CurrentQueue.QueueID + "/cancel");
}

void PlayerStatusCheck(ref@ q) {
    Queue@ queue = cast<Queue>(q);
    if (queue is null) {
        Error(ErrorType::Error, "PlayerStatusCheck", "No queue passed as argument!", "");
        return;
    }
    G_QueueState.RefreshPlayerStatus(queue);
}

void JoinMatch() {
    G_QueueState.SetStatus(QueueStatus::Joining);
    while (!IsInMatch()) {
        uint64 NextJoinAttempt = Time::Now + 5000;
        
        G_QueueState.RefreshCurrentMatchStatus(G_QueueState.CurrentMatch.LID);
        // wait until we know the server exists I guess
        if (G_QueueState.CurrentMatch.ServerStatus == "CREATED") JoinServer();
        while (Time::Now < NextJoinAttempt) yield();
    }
    startnew(MatchLoop);
}

void JoinServer() {
    auto app = cast<CTrackMania>(GetApp());
    if (app.ManiaPlanetScriptAPI.ActiveContext_InGameMenuDisplayed) {
        app.CurrentPlayground.Interface.ManialinkScriptHandler.CloseInGameMenu(CGameScriptHandlerPlaygroundInterface::EInGameMenuResult::Resume);
        sleep(250);
        if (app.ManiaPlanetScriptAPI.ActiveContext_InGameMenuDisplayed) {
            Error(ErrorType::UserWarning, "Please close the Pause menu!", "Softlock prevention: Please exit first!", "");
            return;
        }
    }
    if (!IsInMatch()) {
        app.ManiaPlanetScriptAPI.OpenLink(G_QueueState.CurrentMatch.JoinLink.Replace("#join=","#qjoin="), CGameManiaPlanetScriptAPI::ELinkType::ManialinkBrowser);
    }
}

bool IsInMatch() {
    auto ServerInfo = cast<CGameCtnNetServerInfo>(cast<CTrackManiaNetwork>(GetApp().Network).ServerInfo);
    return ServerInfo.ServerLogin != "" && ServerInfo.ServerLogin == G_QueueState.CurrentMatch.JoinLink.Replace("#qjoin=","").Replace("#join=","").Replace("@Trackmania","");
}

void CheckRoyalMatchLeft() {
    // @ROYAL
    if (G_QueueState.CurrentQueue.Stats.CurrentDivision.RuleType == DivisionRuleType::VictoryCount) {
        if (!IsInMatch()) {
            G_QueueState.Absent = true;
        } else {
            G_QueueState.Absent = false;
            G_UIState.ShowMatchLeaveUI = true;
        }
    }
}

void LeaveMatch() {
    G_QueueState.CurrentQueue.Stats.CurrentRanking = RefreshQueueRanking(G_QueueState.CurrentQueue.QueueID);
    G_QueueState.CurrentQueue.Stats.RefreshDivisionRanking();
    RefreshRankColor();
    G_QueueState.SetStatus(QueueStatus::MatchCompleted);
    @G_QueueState.CurrentMatch = null;
    G_QueueState.IsInQueue = false;
}

void ParseCurrentMatchStatus() {
    if (G_QueueState.CurrentMatch.Status == "COMPLETED") {
        G_QueueState.CurrentQueue.Stats.CurrentRanking = RefreshQueueRanking(G_QueueState.CurrentQueue.QueueID);
        G_QueueState.CurrentQueue.Stats.RefreshDivisionRanking();
        RefreshRankColor();
        G_QueueState.SetStatus(QueueStatus::MatchCompleted);
        G_QueueState.CurrentQueue.Stats.SaveMatchForStats(G_QueueState.CurrentMatch);
        @G_QueueState.CurrentMatch = null;

        if (G_QueueState.AutoRequeue) {
            G_QueueState.IsInQueue = true;
            startnew(QueueLoop);
            Error(ErrorType::Info, "", "Match ended!", "You have been automatically requeued!");
            G_QueueState.AutoRequeue = false;
        } else {
            G_QueueState.IsInQueue = false;
        }
    }
}

void RefreshPointsProgression(ref@ m) {
    if (cast<Match>(m) is null) {
        // will not be able to save that
    }
}

void ExitQueue() {
    G_QueueState.IsInQueue = false;
    startnew(SendCancel);
    G_QueueState.SetStatus(QueueStatus::CanceledUser);
}

void CopyMatchID() {
    if (G_QueueState.CurrentMatch !is null) IO::SetClipboard(G_QueueState.CurrentMatch.LID);
}

// --- UI

void RenderMenu() {
    if (UI::MenuItem(CreateColorCode(hsv2rgb(vec3(Math::Fract(Time::Now / 10000.0), 0.4, 1.0))) + Icons::Gamepad + "  \\$zAFK Queue Tool", "", Setting_WindowVisible)) {
        Setting_WindowVisible = !Setting_WindowVisible;
        if (G_UIState !is null) G_UIState.ResizeMainWindow = true;
    }
}

void RenderInterface() {
    if (!Setting_WindowVisible) return;
    if (G_UIState !is null && G_UIState.ResizeMainWindow) {
        UI::SetNextWindowSize(465,315, UI::Cond::Always);
        G_UIState.ResizeMainWindow = false;
    }
    if (UI::Begin(Icons::Gamepad + "  AFK Queue Tool \\$555 by Nsgr###AFKQueue2", Setting_WindowVisible, UI::WindowFlags(1 << 21) | UI::WindowFlags::NoCollapse)) {
        if (G_UIState is null || !G_QueueState.Ready) {
            string LoadingString = (G_UIState is null ? "Loading States..." : G_UIState.LoadingString);
            vec2 LoadingSize = Draw::MeasureString(LoadingString);
            UI::SetCursorPos((UI::GetWindowSize() - LoadingSize) / 2);
            BoldText(LoadingString);
            UI::End();
            return;
        }

        // Rank header
        RenderRankBar();

        // Main Menu
        bool ApplyStyle = Setting_ColoredUI;
        if (ApplyStyle) UI::PushStyleColor(UI::Col::TabActive, G_UIState.TabBarBottom);
        UI::BeginTabBar("AFKMainTabBar", UI::TabBarFlags::FittingPolicyResizeDown);
        vec2 tabSize = vec2(UI::GetWindowSize().x - 16, UI::GetWindowSize().y - UI::GetCursorPos().y - 36);

        if (ApplyStyle) {
            UI::PushStyleColor(UI::Col::Tab, G_UIState.RankColor.Color4);
            UI::PushStyleColor(UI::Col::TabHovered, G_UIState.RankColor.ColorHover);
            UI::PushStyleColor(UI::Col::TabActive, G_UIState.RankColor.ColorActive);
        }
        
        // Render Tabs
        for (uint i = 0; i < G_UIState.Tabs.Length; i++) {
            if (UI::BeginTabItem(G_UIState.Tabs[i].Label)) {
                UI::BeginChild("AFKTab" + i, tabSize);

                G_UIState.Tabs[i].Render();

                UI::EndChild();
                UI::EndTabItem();
            }
        }
        if (ApplyStyle) UI::PopStyleColor(3);
        UI::EndTabBar();
        if (ApplyStyle) UI::PopStyleColor(1);

        // "Status bar"
        UI::Separator();
        RenderStatusBar();
        UI::End();
    }
    
    if (!G_UIState.InviteMenuVisible) return;
    UI::SetNextWindowSize(400,250, UI::Cond::Appearing);
    if (UI::Begin(Icons::Envelope + " " + (Setting_UseSquads ? "Invite" : "Add") + " Players \\$555 to Party###AFKQueue2Invite", G_UIState.InviteMenuVisible, UI::WindowFlags(1 << 21) | UI::WindowFlags::NoCollapse)) {
        UI::BeginTabBar("AFKInviteCategory");

        for (uint i = 0; i < G_UIState.InviteTabs.Length; i++) {
            if (UI::BeginTabItem(G_UIState.InviteTabs[i].Label)) {
                G_UIState.InviteTabs[i].Render();
                UI::EndTabItem();
            }
        }

        UI::EndTabBar();
        UI::End();
    }
}

// --- UI Overlays

void RenderRankBar() {
    vec2 pos_orig = UI::GetCursorPos();
    pos_orig.y -= 2;

    // Draw rank image
    Resources::Texture@ RankImage;
    Resources::Texture@ HoverImage;
    vec2 RankSize = vec2(0,0);
    if (G_QueueState.CurrentQueue.Stats.CurrentDivision !is null) {
        //@ROYAL
        if (G_QueueState.CurrentQueue.Stats.CurrentDivision.RuleType == DivisionRuleType::VictoryCount) {
            @RankImage = G_UIState.RoyalTextures[G_QueueState.CurrentQueue.Stats.CurrentDivision.Position - 1];
            @HoverImage = G_UIState.RoyalPreviews[G_QueueState.CurrentQueue.Stats.CurrentDivision.Position - 1];
        } else {
            @RankImage = G_UIState.T3v3Textures[G_QueueState.CurrentQueue.Stats.CurrentDivision.Position];
            @HoverImage = RankImage;
        }
        RankSize = RankImage.GetSize();
        RankSize /= RankSize.y / 52;
        UI::SetCursorPos(pos_orig);
        UI::Image(RankImage, RankSize);
        if (UI::IsItemHovered()) {
            float HoverSize = UI::GetWindowSize().y;
            UI::BeginTooltip();
            UI::Image(HoverImage, vec2(HoverSize, HoverSize));
            UI::EndTooltip();
        }
    }

    // Draw ranking info texts
    string RankString = "\\$eeeRank: " + G_QueueState.CurrentQueue.Stats.CurrentRanking.Rank + " / " + G_QueueState.CurrentQueue.Stats.CurrentRanking.Cardinal;
    string PointsString = "";
    // @ROYAL
    if (G_QueueState.CurrentQueue.Stats.CurrentDivision.RuleType == DivisionRuleType::VictoryCount) {
        PointsString = "\\$eeeWins: " + G_QueueState.CurrentQueue.Stats.CurrentRanking.Wins + " \\$999(" + G_QueueState.CurrentQueue.Stats.CurrentRanking.Points + " pts.)";
    } else {
        PointsString = "\\$eeePoints: " + G_QueueState.CurrentQueue.Stats.CurrentRanking.Points;
    }

    UI::SetCursorPos(vec2(pos_orig.x + RankSize.x + 8, pos_orig.y + 7));
    UI::Text(PointsString);

    UI::SetCursorPos(vec2(pos_orig.x + RankSize.x + 8, pos_orig.y + 29));
    UI::Text(RankString);
    if (G_QueueState.Queues.Length > 0) {
        
        UI::SetCursorPos(vec2(3 * UI::GetWindowSize().x / 5, pos_orig.y + 6));
        UI::SetNextItemWidth(2 * UI::GetWindowSize().x / 5 - 24);
        UI::PushStyleColor(UI::Col::PopupBg, vec4(0.1,0.1,0.1,1.0));
        UI::PushStyleColor(UI::Col::Border, vec4(0.4,0.4,0.4,1.0));
        if (UI::BeginCombo("", G_QueueState.CurrentQueue.Name, UI::ComboFlags::NoArrowButton)) {
            for (uint i = 0; i < G_QueueState.Queues.Length; i++) {
                if (UI::Selectable(G_QueueState.Queues[i].GetTitle(), G_QueueState.Queues[i].QueueID == G_QueueState.CurrentQueue.QueueID) && !G_QueueState.IsInQueue) {
                    @G_QueueState.CurrentQueue = G_QueueState.Queues[i];
                    RefreshRankColor();
                }
            }
            UI::EndCombo();
        }
        UI::PopStyleColor(2);

        if (G_QueueState.Queues.Length > 1) {
            UI::SetCursorPos(vec2(UI::GetWindowSize().x - 48, pos_orig.y + 11));
            UI::Text(Icons::ChevronDown);
        }
    }

    // Set cursor for the rest
    pos_orig.y += 56;
    UI::SetCursorPos(pos_orig);
}

void RenderStatusBar() {
    vec2 pos_orig = UI::GetCursorPos();
    float lowestPossibleTextHeight = UI::GetWindowSize().y - 24;

    string VersionString = "\\$777v" + PluginVersion;
    vec2 textSize = Draw::MeasureString(VersionString);

    UI::SetCursorPos(vec2(pos_orig.x, lowestPossibleTextHeight));
    UI::Text(G_QueueState.GetStatusBarString()); UI::SameLine(); UI::PushFont(G_UIState.Bold); UI::Text(G_QueueState.StatusString); UI::PopFont();

    UI::SetCursorPos(vec2(UI::GetWindowSize().x - textSize.x - 8, lowestPossibleTextHeight));
    UI::Text(VersionString);

    UI::SetCursorPos(pos_orig);
}

bool RenderRefreshButton() {
    bool pressed;
    vec2 pos_orig = UI::GetCursorPos();
    UI::SetCursorPos(vec2(UI::GetWindowSize().x - 48, 22));
    UI::PushStyleColor(UI::Col::Button, vec4(G_UIState.Blue.Color3.x, G_UIState.Blue.Color3.y, G_UIState.Blue.Color3.z, 0));
    UI::PushStyleColor(UI::Col::ButtonHovered, vec4(G_UIState.Blue.Color3.x, G_UIState.Blue.Color3.y, G_UIState.Blue.Color3.z, 0.4));
    UI::PushStyleColor(UI::Col::ButtonActive, vec4(G_UIState.Blue.Color3.x, G_UIState.Blue.Color3.y, G_UIState.Blue.Color3.z, 0.7));
    pressed = UI::Button(Icons::Redo);
    UI::PopStyleColor(3);
    UI::SetCursorPos(pos_orig);
    return pressed;
}

// --- UI helpers

void BoldText(const string &in Text) {
    if (G_UIState !is null && G_UIState.Bold !is null) {
        UI::PushFont(G_UIState.Bold);
        UI::Text(Text);
        UI::PopFont();
    } else {
        UI::Text(Text);
    }
}

// --- UI Data

vec3 hsv2rgb(const vec3 &in c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = Math::Abs(Math::Fract(vec3(c.x,c.x,c.x) + vec3(K.x,K.y,K.z)) * 6.0 - vec3(K.w,K.w,K.w));
    return Math::Lerp(vec3(K.x,K.x,K.x), Math::Clamp(p - vec3(K.x,K.x,K.x), 0.0, 1.0), c.y) * c.z;
}

string CreateColorCode(const vec3 &in Input) {
    string ReturnedValue = "\\$";
    ReturnedValue += Text::Format("%x", uint8(Input.x * 15.0));
    ReturnedValue += Text::Format("%x", uint8(Input.y * 15.0));
    ReturnedValue += Text::Format("%x", uint8(Input.z * 15.0));
    return ReturnedValue;
}

// --- Sound

enum Sounds {
    MatchFound,
    MatchFoundAwaitInput,
    MatchFoundInputReceived,
    Warn,
    Error,
    Info,
    RankUp,
    RankDown,
    InvitationReceived
}

void PlaySound(Sounds soundType) {
    float Pitch = 1.0;
    string FileName = "Race3";
    switch (soundType) {
        case Sounds::MatchFound :
            Pitch = 1.0;
            FileName = "MatchFound";
            break;
        case Sounds::MatchFoundAwaitInput :
            Pitch = 0.5;
            FileName = "MatchFound";
            break;
        case Sounds::MatchFoundInputReceived :
            Pitch = 2.0;
            FileName = "PlayButtonSelect";
            break;
        case Sounds::Warn :
            Pitch = 1.8;
            FileName = "RaceWooshStart";
            break;
        case Sounds::Error :
            Pitch = 0.5;
            FileName = "Race3";
            break;
        case Sounds::Info :
            Pitch = 1.5;
            FileName = "Race3";
            break;
        case Sounds::RankUp :
            Pitch = 1.0;
            FileName = "RankUp";
            break;
        case Sounds::RankDown :
            Pitch = 1.0;
            FileName = "RankDown";
            break;
        case Sounds::InvitationReceived :
            Pitch = 1.0;
            FileName = "InvitationNotification";
            break;
    }

    Audio::Sample@ sample = cast<Audio::Sample>(G_UIState.SoundSamples[FileName]);
    if (sample is null) {
        Error(ErrorType::Warn, "PlaySound", "Audio sample could not be casted!", FileName);
        return;
    }
    Audio::Voice@ voice = Audio::Play(sample, Setting_SoundVolume / 100.0f);
}

// --- Network Base

string SendNadeoRequest(const Net::HttpMethod Method, const string &in URL, string Body = "") {
    dictionary@ Headers = dictionary();
    auto app = cast<CTrackMania>(GetApp());
    Headers["Accept"] = "application/json";
    Headers["Content-Type"] = "application/json";
    Headers["Authorization"] = "nadeo_v1 t=" + app.ManiaPlanetScriptAPI.Authentication_Token;
    return SendHTTPRequest(Method, URL, Body, Headers);
}

string SendJSONRequest(const Net::HttpMethod Method, const string &in URL, string Body = "") {
    dictionary@ Headers = dictionary();
    Headers["Accept"] = "application/json";
    Headers["Content-Type"] = "application/json";
    return SendHTTPRequest(Method, URL, Body, Headers);
}

string SendHTTPRequest(const Net::HttpMethod Method, const string &in URL, const string &in Body, dictionary@ Headers) {
    Net::HttpRequest req;
    req.Method = Method;
    req.Url = URL;
    @req.Headers = Headers;
    req.Body = Body;
    req.Start();
    while (!req.Finished()) {
        yield();
    }
    //@BETA
    //print(req.String());
    return req.String();
}

Json::Value ResponseToJSON(const string &in HTTPResponse, Json::Type ExpectedType) {
    Json::Value ReturnedObject;
    try {
        ReturnedObject = Json::Parse(HTTPResponse);
    } catch {
        Error(ErrorType::Error, "ResponseToJSON", "JSON Parsing of string failed!", HTTPResponse);
    }
    if (ReturnedObject.GetType() != ExpectedType) {
        Error(ErrorType::Warn, "ResponseToJSON", "Unexpected JSON Type returned", HTTPResponse);
        return ReturnedObject;
    }
    return ReturnedObject;
}

// --- Network Methods

float[] GetPointsHistory(const string &in AccountID) {
    float[] ReturnedValue = {C_Invalid};
    while (G_QueueState.CurrentQueue is null) yield();
    string MatchHistoryResponse = SendJSONRequest(Net::HttpMethod::Get, "https://trackmania.io/api/player/" + AccountID + "/matches/" + G_QueueState.CurrentQueue.QueueID + "/0");
    Json::Value MatchHistory = ResponseToJSON(MatchHistoryResponse, Json::Type::Object);
    if (MatchHistory.GetType() != Json::Type::Null && MatchHistory.HasKey("matches") && MatchHistory["matches"].Length > 1) {
        try {
            ReturnedValue = {};
            for (uint i = MatchHistory["matches"].Length; i > 0; i--) {
                ReturnedValue.InsertLast(MatchHistory["matches"][i-1]["afterscore"]);
            }
        } catch {
            ReturnedValue = {C_Invalid}; // need to set back in case error happened while array didnt have 2 elements yet
            Error(ErrorType::Error, "GetPointsHistory", "Cannot read past match deltas", MatchHistoryResponse);
        }
    }
    return ReturnedValue;
}

// --- Data

int64 MidnightTimestamp() {
    string LocalTimeString = GetApp().OSLocalTime; //HH:MM:SS
    string[] TimeParts = LocalTimeString.Split(":"); // [HH,MM,SS]
    int64 ReturnedValue = Time::Stamp - (Text::ParseInt(TimeParts[0]) * 3600) - (Text::ParseInt(TimeParts[1]) * 60) - (Text::ParseInt(TimeParts[2]));
    return ReturnedValue;
}

QueueStatus GetStatusFromString(const string &in status) {
    if (status == "") {
        return QueueStatus::NotInQueue;
    } else if (status == "pending") {
        return QueueStatus::Pending;
    } else if (status == "skill_gap_canceled") {
        return QueueStatus::SkillGapCanceled;
    } else if (status == "queued") {
        return QueueStatus::Queued;
    } else if (status == "match_found") {
        return QueueStatus::MatchFound;
    } else if (status == "match_accepted") {
        return QueueStatus::MatchAccepted;
    } else if (status == "match_ready") {
        return QueueStatus::MatchReady;
    } else if (status == "canceled") {
        return QueueStatus::Canceled;
    } else if (status == "banned") {
        return QueueStatus::Banned;
    } else {
        return QueueStatus::Unknown;
    }
}

void TMIOSearch() {
    G_DataState.TMIOSearchResultsValid = false;
    G_DataState.TMIOSearchResults.RemoveRange(0,G_DataState.TMIOSearchResults.Length);
    string SearchResponse = SendJSONRequest(Net::HttpMethod::Get, "https://trackmania.io/api/players/find?search=" + G_DataState.TMIOSearchString);
    Json::Value SearchResult = ResponseToJSON(SearchResponse, Json::Type::Array);
    array<LeaderboardPlayer@> Results;
    if (SearchResult.GetType() != Json::Type::Null) {
        try {
            for (uint i = 0; i < SearchResult.Length; i++) {
                try {
                    if (SearchResult[i]["matchmaking"].Length > 0) {
                        int rank = 0;
                        int score = 0;
                        for (uint j = 0; j < SearchResult[i]["matchmaking"].Length; j++) {
                            if (SearchResult[i]["matchmaking"][j]["typeid"] == G_QueueState.CurrentQueue.QueueID) {
                                rank = SearchResult[i]["matchmaking"][j]["rank"];
                                score = SearchResult[i]["matchmaking"][j]["score"];
                                break;
                            }
                        }
                        Results.InsertLast(LeaderboardPlayer(rank, score, Player(SearchResult[i]["player"]["id"], SearchResult[i]["player"]["name"])));
                    } else {
                        Results.InsertLast(LeaderboardPlayer(C_Invalid, C_Invalid, Player(SearchResult[i]["player"]["id"], SearchResult[i]["player"]["name"])));
                    }
                } catch {
                    Error(ErrorType::Warn, "TMIO Search", "Something went wrong while parsing a search result element!", SearchResponse);
                }
            }
        } catch {
            Error(ErrorType::Error, "TMIO Search", "Something went wrong while parsing the search results!", SearchResponse);
        }
    } else {
        Error(ErrorType::Warn, "TMIO Search", "Received empty / invalid search result", SearchResponse);
    }

    G_DataState.TMIOSearchResults = Results;
    G_DataState.TMIOSearchResultsValid = true;
}

MwId GetMainUserId() {
    auto app = cast<CTrackMania>(GetApp());
    if (app.ManiaPlanetScriptAPI.UserMgr.MainUser !is null) {
        return app.ManiaPlanetScriptAPI.UserMgr.MainUser.Id;
    }
    if (app.ManiaPlanetScriptAPI.UserMgr.Users.Length >= 1) {
        // unexpected case but Nadeo watches out for this for some weird reason, so let's handle it
        if (app.ManiaPlanetScriptAPI.UserMgr.Users.Length > 1) {
            string ErrorString = "User buffer length: " + app.ManiaPlanetScriptAPI.UserMgr.Users.Length + "\n";
            for (uint i = 0; i < app.ManiaPlanetScriptAPI.UserMgr.Users.Length; i++) {
                ErrorString += "User #" + i + "\nSystemName:" + app.ManiaPlanetScriptAPI.UserMgr.Users[i].SystemName + "\nDisplayName: " + app.ManiaPlanetScriptAPI.UserMgr.Users[i].DisplayName + "\nId: " + app.ManiaPlanetScriptAPI.UserMgr.Users[i].Id.GetName() + "\n";
            }
            Error(ErrorType::Warn, "UserMgr Users", "The game user list was not just one user!", ErrorString);
        }
        return app.ManiaPlanetScriptAPI.UserMgr.Users[0].Id;
    } else {
        Error(ErrorType::Error, "UserMgr Users", "The game user list is empty!", "MainUser null? :" + (app.ManiaPlanetScriptAPI.UserMgr.MainUser is null));
        return MwId();
    }
}

void GetFriendList() {
    if (Time::Now < G_DataState.LastFriendListRefresh + 10000) return;
    G_DataState.FriendListValid = false;
    G_DataState.LastFriendListRefresh = Time::Now;

    array<UplayFriend@> FriendList;
    auto app = cast<CTrackMania>(GetApp());
    
    CWebServicesTaskResult_FriendListScript@ friendListResult = app.ManiaPlanetScriptAPI.UserMgr.Friend_GetList(GetMainUserId());
    while (friendListResult.IsProcessing) yield();
    if (friendListResult.HasSucceeded) {
        MwFastBuffer<CFriend@> UplayFriendList = friendListResult.FriendList;
        for (uint i = 0; i < UplayFriendList.Length; i++) {
            FriendList.InsertLast(UplayFriend(UplayFriendList[i]));
        }
    } else {
        Error(ErrorType::Error, "Friend_GetList", friendListResult.ErrorDescription, friendListResult.ErrorCode);
    }
    app.ManiaPlanetScriptAPI.UserMgr.TaskResult_Release(friendListResult.Id);

    FriendList.Sort(CompareUplayFriends);

    G_DataState.UplayFriends = FriendList;
    G_DataState.FriendListValid = true;
}



void RefreshRankColor() {
    const vec3[] DivisionColors = {
        vec3(0,0,0),
        vec3(0.761, 0.506, 0.333),
        vec3(0.761, 0.506, 0.333),
        vec3(0.761, 0.506, 0.333),
        vec3(0.682, 0.690, 0.690),
        vec3(0.682, 0.690, 0.690),
        vec3(0.682, 0.690, 0.690),
        vec3(0.8745, 0.663, 0.086),
        vec3(0.8745, 0.663, 0.086),
        vec3(0.8745, 0.663, 0.086),
        vec3(0.502, 0.871, 0.035),
        vec3(0.502, 0.871, 0.035),
        vec3(0.502, 0.871, 0.035),
        vec3(0.502, 0.871, 0.0352)
    };

    const vec3[] RoyalColors = {
        vec3(0,0,0),
        vec3(0.761, 0.506, 0.333),
        vec3(0.682, 0.690, 0.690),
        vec3(0.8745, 0.663, 0.086),
        vec3(0.502, 0.871, 0.035),
        vec3(0.502, 0.871, 0.0352)
    };

    uint pos = G_QueueState.CurrentQueue.Stats.CurrentDivision.Position;

    // @ROYAL
    // YEP hardcode for royal types
    if (G_QueueState.CurrentQueue.Stats.CurrentDivision.RuleType == DivisionRuleType::VictoryCount) {
        for (uint i = 0; i < RoyalColors.Length; i++) {
            if (pos - 1 == i) {
                G_UIState.RankColor.SetColor(RoyalColors[i]);
                G_UIState.TabBarBottom = vec4(RoyalColors[i].x - 0.1, RoyalColors[i].y - 0.1, RoyalColors[i].z - 0.1, 0.7);
                return;
            }
        }
    } else {
        for (uint i = 0; i < DivisionColors.Length; i++) {
            if (pos == i) {
                G_UIState.RankColor.SetColor(DivisionColors[i]);
                G_UIState.TabBarBottom = vec4(DivisionColors[i].x - 0.1, DivisionColors[i].y - 0.1, DivisionColors[i].z - 0.1, 0.7);
                return;
            }
        }
    }
    
    G_UIState.RankColor.SetColor(G_UIState.Gray.Color3);
    return;
}

void RequestNextLeaderboardPage() {
    while (G_QueueState.CurrentQueue.Stats.Leaderboard.LastRequestStamp + 2000 > Time::Now) yield();
    G_QueueState.CurrentQueue.Stats.Leaderboard.RequestNextPage();
}

void RefreshNadeoSquad() {
    G_QueueState.Party.m_NadeoSquad.GetCurrent();
}

CTrackManiaPlayerInfo@ GetMainUserInfo() {
    auto app = cast<CTrackMania>(GetApp());
    return cast<CTrackManiaPlayerInfo>(cast<CTrackManiaNetwork>(app.Network).PlayerInfo);
}

void GenerateNewPartyCode() {
    string PartyCodeResponse = SendNadeoRequest(Net::HttpMethod::Post, "https://matchmaking.trackmania.nadeo.club/api/code");
    Json::Value PartyCodeJSON = ResponseToJSON(PartyCodeResponse, Json::Type::Object);

    if (PartyCodeJSON.GetType() == Json::Type::Object) {
        try {
            G_DataState.PartyCode = PartyCodeJSON["code"];
        } catch {
            Error(ErrorType::Error, "GenerateNewPartyCode", "Couldn't generate new party code!", PartyCodeResponse);
        }
    }
}

QueueRanking@ RefreshQueueRanking(uint QueueID) {
    QueueRanking@ Ranking = QueueRanking();

    string LeaderboardStatusResponse = SendNadeoRequest(Net::HttpMethod::Get, "https://matchmaking.trackmania.nadeo.club/api/matchmaking/" + QueueID + "/leaderboard/players?players[]=" + GetMainUserInfo().WebServicesUserId);
    Json::Value LeaderboardStatus = ResponseToJSON(LeaderboardStatusResponse, Json::Type::Object);

    if (LeaderboardStatus.GetType() != Json::Type::Null) {
        try {
            if (uint(LeaderboardStatus["matchmaking_id"]) == QueueID) {
                if (LeaderboardStatus["results"].Length == 1) {
                    Ranking.Rank = LeaderboardStatus["results"][0]["rank"];
                    Ranking.Points = LeaderboardStatus["results"][0]["score"];
                } else {
                    Error(ErrorType::Warn, "RefreshQueueRanking", "LeaderboardStatus returned a different amount of players than requested!\n" + (LeaderboardStatus["results"].Length != 0 ? "(Got rankings for " + LeaderboardStatus["results"].Length + " players)!" : "This can happen if you have never queued up for a mode."), LeaderboardStatusResponse);
                }
            } else {
                Error(ErrorType::Error, "RefreshQueueRanking", "LeaderboardStatus returned a different matchmaking ID than requested!", LeaderboardStatusResponse);
            }
            Ranking.Cardinal = LeaderboardStatus["cardinal"];
        } catch {
            Error(ErrorType::Error, "RefreshQueueRanking", "Something went wrong while processing the Leaderboard Status!", "Queue ID: " + QueueID + "\n" + LeaderboardStatusResponse);
        }
    } else {
        Error(ErrorType::Warn, "RefreshQueueRanking", "Leaderboard Status returned a bad response!", LeaderboardStatusResponse);
    }

    string ProgressionStatusResponse = SendNadeoRequest(Net::HttpMethod::Get, "https://matchmaking.trackmania.nadeo.club/api/matchmaking/" + QueueID + "/progression/players?players[]=" + GetMainUserInfo().WebServicesUserId);
    Json::Value ProgressionStatus = ResponseToJSON(ProgressionStatusResponse, Json::Type::Object);

    if (ProgressionStatus.GetType() != Json::Type::Null) {
        try {
            if (ProgressionStatus.HasKey("progressions") && ProgressionStatus["progressions"].GetType() == Json::Type::Array) {
                if (ProgressionStatus["progressions"].Length == 1) {
                    Ranking.Wins = ProgressionStatus["progressions"][0]["progression"];
                } else {
                    Error(ErrorType::Warn, "RefreshQueueRanking", "ProgressionStatus returned a different amount of players than requested!\n" + (ProgressionStatus["results"].Length != 0 ? "(Got rankings for " + ProgressionStatus["progressions"].Length + " players)!" : "This can happen if you have never queued up for a mode."), ProgressionStatusResponse);
                }
            } else {
                Error(ErrorType::Error, "RefreshQueueRanking", "\"progressions\" not found in JSON", ProgressionStatusResponse);
            }
        } catch {
            Error(ErrorType::Error, "RefreshQueueRanking", "Something went wrong while processing the Progression Status!", "Queue ID: " + QueueID + "\n" + ProgressionStatusResponse);
        }
    } else {
        Error(ErrorType::Warn, "RefreshQueueRanking", "Progression Status returned a bad response!", LeaderboardStatusResponse);
    }

    return Ranking;
}

// --- Yieldable Nadeo Refreshes

void GetCurrentNadeoSquad() {
    G_QueueState.Party.m_NadeoSquad.GetCurrentInProgress = true;
    G_QueueState.Party.LastSquadRefreshStamp = Time::Now;
    auto app = cast<CTrackMania>(GetApp());
    CWebServicesTaskResult_SquadScript@ currentSquadResult = app.ManiaPlanetScriptAPI.UserMgr.Squad_GetCurrent(GetMainUserId());
    while (currentSquadResult.IsProcessing) yield();

    if (currentSquadResult.HasSucceeded) {
        G_QueueState.Party.m_NadeoSquad = NadeoSquad(currentSquadResult.Squad);
    } else {
        if (currentSquadResult.ErrorCode != "C-BD-04-01" && currentSquadResult.ErrorCode != "0x00000194") {
            Error(ErrorType::Error, "Squad_GetCurrent", "Cannot get the current Nadeo Squad!", "Error Code: " + currentSquadResult.ErrorCode + "\nDescription: " + currentSquadResult.ErrorDescription);
        } else {
            G_QueueState.Party.m_NadeoSquad.Exists = false;
            Error(ErrorType::Log, "Squad_GetCurrent", currentSquadResult.ErrorDescription, currentSquadResult.ErrorCode);
        }
    }
    app.ManiaPlanetScriptAPI.UserMgr.TaskResult_Release(currentSquadResult.Id);
    G_QueueState.Party.m_NadeoSquad.GetCurrentInProgress = false;
}

void LeaveNadeoSquad() {
    G_QueueState.Party.m_NadeoSquad.LeaveInProgress = true;
    auto app = cast<CTrackMania>(GetApp());
    CWebServicesTaskResult_SquadScript@ currentSquadResult = app.ManiaPlanetScriptAPI.UserMgr.Squad_Leave(GetMainUserId(), G_QueueState.Party.m_NadeoSquad.SquadID);
    while (currentSquadResult.IsProcessing) yield();
    if (currentSquadResult.HasSucceeded) {
        G_QueueState.Party.m_NadeoSquad.Exists = false;
        G_QueueState.Party.m_NadeoSquad.Name = "";
        array<SquadMember@> newMembers;
        for (uint i = 0; i < G_QueueState.Party.m_NadeoSquad.Members.Length; i++) {
            if (G_QueueState.Party.m_NadeoSquad.Members[i].Player.AccountID == GetMainUserInfo().WebServicesUserId) {
                newMembers.InsertLast(G_QueueState.Party.m_NadeoSquad.Members[i]);
                break;
            }
        }
        G_QueueState.Party.m_NadeoSquad.Members = newMembers;
        G_QueueState.Party.RefreshPlayWith();
    } else {
        Error(ErrorType::Error, "Squad_Leave", currentSquadResult.ErrorDescription, currentSquadResult.ErrorCode);
        startnew(GetCurrentNadeoSquad);
    }
    app.ManiaPlanetScriptAPI.UserMgr.TaskResult_Release(currentSquadResult.Id);
    G_QueueState.Party.m_NadeoSquad.LeaveInProgress = false;
}

void CreateNadeoSquad() {
    G_QueueState.Party.m_NadeoSquad.CreateInProgress = true;
    auto app = cast<CTrackMania>(GetApp());
    CWebServicesTaskResult_SquadScript@ createSquadResult = app.ManiaPlanetScriptAPI.UserMgr.Squad_Create(GetMainUserId(), G_DataState.SquadCreationName, 3);
    while (createSquadResult.IsProcessing) yield();
    if (createSquadResult.HasSucceeded) {
        G_QueueState.Party.m_NadeoSquad = NadeoSquad(createSquadResult.Squad);
    } else {
        Error(ErrorType::Error, "Squad_Create", createSquadResult.ErrorDescription, createSquadResult.ErrorCode);
    }
    app.ManiaPlanetScriptAPI.UserMgr.TaskResult_Release(createSquadResult.Id);
    G_QueueState.Party.m_NadeoSquad.CreateInProgress = false;
}

void KickNadeoPlayer(ref@ p) {
    G_QueueState.Party.m_NadeoSquad.KickMemberInProgress = true;

    Player@ Player = cast<Player>(p);
    if (Player is null) {
        Error(ErrorType::Error, "KickNadeoPlayer", "Player is null!", "");
        return;
    }

    auto app = cast<CTrackMania>(GetApp());
    CWebServicesTaskResult_SquadScript@ removeMemberResult = app.ManiaPlanetScriptAPI.UserMgr.Squad_RemoveMember(GetMainUserId(), G_QueueState.Party.m_NadeoSquad.SquadID, Player.AccountID);
    while (removeMemberResult.IsProcessing) yield();
    if (removeMemberResult.HasSucceeded) {
        G_QueueState.Party.m_NadeoSquad = NadeoSquad(removeMemberResult.Squad);
    } else {
        Error(ErrorType::Error, "Squad_RemoveMember", removeMemberResult.ErrorDescription, removeMemberResult.ErrorCode);
    }
    app.ManiaPlanetScriptAPI.UserMgr.TaskResult_Release(removeMemberResult.Id);
    G_QueueState.Party.m_NadeoSquad.KickMemberInProgress = false;
}

void InviteNadeoPlayer(ref@ p) {
    G_QueueState.Party.m_NadeoSquad.InviteMemberInProgress = true;

    Player@ Player = cast<Player>(p);
    if (Player is null) {
        Error(ErrorType::Error, "InviteNadeoPlayer", "Player is null!", "");
        return;
    }

    auto app = cast<CTrackMania>(GetApp());
    CWebServicesTaskResult_SquadScript@ invitePlayerResult = app.ManiaPlanetScriptAPI.UserMgr.Squad_Invite(GetMainUserId(), G_QueueState.Party.m_NadeoSquad.SquadID, Player.AccountID);
    while (invitePlayerResult.IsProcessing) yield();
    if (invitePlayerResult.HasSucceeded) {
        G_QueueState.Party.m_NadeoSquad = NadeoSquad(invitePlayerResult.Squad);
    } else {
        Error(ErrorType::Error, "Squad_Invite", invitePlayerResult.ErrorDescription, invitePlayerResult.ErrorCode);
    }
    app.ManiaPlanetScriptAPI.UserMgr.TaskResult_Release(invitePlayerResult.Id);
    G_QueueState.Party.m_NadeoSquad.InviteMemberInProgress = false;
}

void CancelNadeoInvitation(ref@ p) {
    G_QueueState.Party.m_NadeoSquad.CancelInvitationInProgress = true;

    Player@ Player = cast<Player>(p);
    if (Player is null) {
        Error(ErrorType::Error, "CancelNadeoInvitation", "Player is null!", "");
        return;
    }

    auto app = cast<CTrackMania>(GetApp());
    CWebServicesTaskResult_SquadScript@ cancelInvitationResult = app.ManiaPlanetScriptAPI.UserMgr.Squad_CancelInvitation(GetMainUserId(), G_QueueState.Party.m_NadeoSquad.SquadID, Player.AccountID);
    while (cancelInvitationResult.IsProcessing) yield();
    if (cancelInvitationResult.HasSucceeded) {
        G_QueueState.Party.m_NadeoSquad = NadeoSquad(cancelInvitationResult.Squad);
    } else {
        Error(ErrorType::Error, "Squad_CancelInvitation", cancelInvitationResult.ErrorDescription, cancelInvitationResult.ErrorCode);
    }
    app.ManiaPlanetScriptAPI.UserMgr.TaskResult_Release(cancelInvitationResult.Id);
    G_QueueState.Party.m_NadeoSquad.CancelInvitationInProgress = false;
}

void AcceptNadeoInvitation(ref@ s) {
    if (cast<StringContainer>(s) is null) {
        Error(ErrorType::Error, "AcceptNadeoInvitation", "SquadID is null!", "");
        return;
    }
    string SquadID = cast<StringContainer>(s).s;

    auto app = cast<CTrackMania>(GetApp());
    CWebServicesTaskResult_SquadScript@ acceptInvitationResult = app.ManiaPlanetScriptAPI.UserMgr.Squad_AcceptInvitation(GetMainUserId(), SquadID);
    while (acceptInvitationResult.IsProcessing) yield();
    if (acceptInvitationResult.HasSucceeded) {
        G_QueueState.Party.m_NadeoSquad = NadeoSquad(acceptInvitationResult.Squad);
    } else {
        Error(ErrorType::Error, "Squad_AcceptInvitation", acceptInvitationResult.ErrorDescription, acceptInvitationResult.ErrorCode);
    }
    app.ManiaPlanetScriptAPI.UserMgr.TaskResult_Release(acceptInvitationResult.Id);

    Setting_UseSquads = false;
    G_QueueState.Party.SwitchSquadMethod();
}

void DeclineNadeoInvitation(ref@ s) {
    if (cast<StringContainer>(s) is null) {
        Error(ErrorType::Error, "DeclineNadeoInvitation", "SquadID is null!", "");
        return;
    }
    string SquadID = cast<StringContainer>(s).s;
    
    auto app = cast<CTrackMania>(GetApp());
    CWebServicesTaskResult_SquadScript@ declineInvitationResult = app.ManiaPlanetScriptAPI.UserMgr.Squad_DeclineInvitation(GetMainUserId(), SquadID);
    while (declineInvitationResult.IsProcessing) yield();
    if (declineInvitationResult.HasSucceeded) {
        G_QueueState.Party.m_NadeoSquad = NadeoSquad(declineInvitationResult.Squad);
    } else {
        Error(ErrorType::Error, "Squad_AcceptInvitation", declineInvitationResult.ErrorDescription, declineInvitationResult.ErrorCode);
    }
    app.ManiaPlanetScriptAPI.UserMgr.TaskResult_Release(declineInvitationResult.Id);
}

// --- Control Flow

void Error(ErrorType errType, const string &in context, const string &in message, const string &in log) {
    if (errType == ErrorType::Warn) {
        warn("[!] WARN [!]");
        warn("CONTEXT: " + context);
        warn("MESSAGE: " + message);
        warn("LOG: " + log);
        if (!Setting_HideWarn) UI::ShowNotification("\\$000" + Icons::ExclamationTriangle + " Warning in " + context, "\\$444" + message, vec4(1.0, 1.0, 0.0, 0.27), 7500);
    } else if (errType == ErrorType::Error) {
        error("[!] ERROR [!]");
        error("CONTEXT: " + context);
        error("MESSAGE: " + message);
        error("LOG: " + log);
        UI::ShowNotification(Icons::Times + " Error in " + context, message, vec4(1.0, 0.0, 0.0, 0.27), 15000);
    } else if (errType == ErrorType::UserWarning) {
        UI::ShowNotification(Icons::ExclamationTriangle + " " + message, log, vec4(0.6, 0.6, 1.0, 0.27), 6000);
    } else if (errType == ErrorType::Info) {
        UI::ShowNotification(Icons::Info + " " + message, log, vec4(0.6, 0.6, 1.0, 0.27), 6000);
    } else if (errType == ErrorType::Log) {
        print("\\$888" + context + ": " + message + " (" + log + ")");
    }
}

void PlayWarnSound() {
    PlaySound(Sounds::Warn);
}

void PlayErrorSound() {
    PlaySound(Sounds::Error);
}

void PlayInfoSound() {
    PlaySound(Sounds::Info);
}

void PlayInviteSound() {
    PlaySound(Sounds::InvitationReceived);
}

void PlayMatchFoundSound() {
    PlaySound(Sounds::MatchFound);
}

void PlayMatchFoundInputSound() {
    PlaySound(Sounds::MatchFoundAwaitInput);
}

void PlayMatchFoundInputReceivedSound() {
    PlaySound(Sounds::MatchFoundInputReceived);
}

void PlayRankUpSound() {
    PlaySound(Sounds::RankUp);
}

void PlayRankDownSound() {
    PlaySound(Sounds::RankDown);
}

// --- Input plugin functions

bool OnKeyPress(bool down, VirtualKey key) {
    if (G_DataState is null) return false;
    G_DataState.LastActivityTick = Time::Now;
    G_DataState.LastActivityType = 0;
    return false;
}

bool OnMouseButton(bool down, int button, int x, int y) {
    if (G_DataState is null) return false;
    G_DataState.LastActivityTick = Time::Now;
    G_DataState.LastActivityType = 1;
    return false;
}

void OnMouseMove(int x, int y) {
    if (G_DataState is null) return;
    G_DataState.LastActivityTick = Time::Now;
    G_DataState.LastActivityType = 1;
    return;
}

// --- Misc

string GetPlacementFromRank(int rank) {
    if (rank < 1) return "" + rank;
    switch (rank % 10) {
        case 1 :
            return "" + rank + "st";
        case 2 :
            return "" + rank + "nd";
        case 3 :
            return "" + rank + "rd";
    }
    return "" + rank + "th";
}

bool CompareUplayFriends(const UplayFriend@ &in a, const UplayFriend@ &in b) {
    if (a.Presence != b.Presence) return (a.Presence == "Online" || b.Presence == "Offline");
    else return a.UplayPlayer.DisplayName.ToLower() < b.UplayPlayer.DisplayName.ToLower();
}

bool CompareRecentMembers(const RecentTeammate@ &in a, const RecentTeammate@ &in b) {
    return a.LastQueueStamp < b.LastQueueStamp;
}

namespace Math {
    vec3 Fract(const vec3 &in c) {
        return vec3(Math::Fract(c.x),Math::Fract(c.y),Math::Fract(c.z));
    }

    vec3 Clamp(const vec3 &in c, const float min, const float max) {
        return vec3(Math::Clamp(c.x,min,max),Math::Clamp(c.y,min,max),Math::Clamp(c.z,min,max));
    }

    vec3 Abs(const vec3 &in c) {
        return vec3(Math::Abs(c.x),Math::Abs(c.y),Math::Abs(c.z));
    }

    float Fract(const float v) {
        return v - Math::Floor(v);
    }
}