/*
 * author: Phlarx
 */

namespace CP {
	/**
	 * If true, then this plugin has detected that we are in game, on a map.
	 * If false, none of the other values are valid.
	 */
	bool inGame = false;
	
	/**
	 * If false, then at least one checkpoint tag is a non-standard value.
	 * Only applies to NEXT and MP4.
	 */
	bool strictMode = false;
	
	/**
	 * The ID of the map whose checkpoints have been counted.
	 */
	string curMapId = "";
	
	/**
	 * The number of checkpoints completed in the current lap.
	 */
	uint curCP = 0;
	
	/**
	 * The number of checkpoints detected for the current map.
	 */
	uint maxCP = 0;
	
	/**
	 * Internal values.
	 */
	uint preCPIdx = 0;
	
	/**
	 * Update should be called once per tick, within the plugin's Update(dt) function.
	 */
	void Update() {
#if TMNEXT
		auto playground = cast<CSmArenaClient>(GetApp().CurrentPlayground);
		
		if(playground is null
			|| playground.Arena is null
			|| playground.Map is null
			|| playground.GameTerminals.Length <= 0
			|| playground.GameTerminals[0].UISequence_Current != CGamePlaygroundUIConfig::EUISequence::Playing
			|| cast<CSmPlayer>(playground.GameTerminals[0].GUIPlayer) is null) {
			inGame = false;
			return;
		}
		
		auto player = cast<CSmPlayer>(playground.GameTerminals[0].GUIPlayer);
		auto scriptPlayer = cast<CSmPlayer>(playground.GameTerminals[0].GUIPlayer).ScriptAPI;
		
		if(scriptPlayer is null) {
			inGame = false;
			return;
		}
		
		if(hideCounterWithIFace) {
			if(playground.Interface is null || Dev::GetOffsetUint32(playground.Interface, 0x1C) == 0) {
				inGame = false;
				return;
			}
		}
		
		if(player.CurrentLaunchedRespawnLandmarkIndex == uint(-1)) {
			// sadly, can't see CPs of spectated players any more
			inGame = false;
			return;
		}
		
		MwFastBuffer<CGameScriptMapLandmark@> landmarks = playground.Arena.MapLandmarks;
		
		if(!inGame && (curMapId != playground.Map.IdName || GetApp().Editor !is null)) {
			// keep the previously-determined CP data, unless in the map editor
			curMapId = playground.Map.IdName;
			preCPIdx = player.CurrentLaunchedRespawnLandmarkIndex;
			curCP = 0;
			maxCP = 0;
			strictMode = true;
			
			array<int> links = {};
			for(uint i = 0; i < landmarks.Length; i++) {
				if(landmarks[i].Waypoint !is null && !landmarks[i].Waypoint.IsFinish && !landmarks[i].Waypoint.IsMultiLap) {
					// we have a CP, but we don't know if it is Linked or not
					if(landmarks[i].Tag == "Checkpoint") {
						maxCP++;
					} else if(landmarks[i].Tag == "LinkedCheckpoint") {
						if(links.Find(landmarks[i].Order) < 0) {
							maxCP++;
							links.InsertLast(landmarks[i].Order);
						}
					} else {
						// this waypoint looks like a CP, acts like a CP, but is not called a CP.
						if(strictMode) {
							warn("The current map, " + string(playground.Map.MapName) + " (" + playground.Map.IdName + "), is not compliant with checkpoint naming rules."
									+ " If the CP count for this map is inaccurate, please report this map on the GitHub issues page:"
									+ " https://github.com/Phlarx/tm-checkpoint-counter/issues");
						}
						maxCP++;
						strictMode = false;
					}
				}
			}
		}
		inGame = true;
		
		/* These are all always length zero, and so are useless:
		player.ScriptAPI.RaceWaypointTimes
		player.ScriptAPI.LapWaypointTimes
		player.ScriptAPI.CurrentLapWaypointTimes
		player.ScriptAPI.PreviousLapWaypointTimes
		player.ScriptAPI.Score.BestRaceTimes
		player.ScriptAPI.Score.PrevRaceTimes
		player.ScriptAPI.Score.BestLapTimes
		player.ScriptAPI.Score.PrevLapTimes
		*/
		
		if(preCPIdx != player.CurrentLaunchedRespawnLandmarkIndex && landmarks.Length > player.CurrentLaunchedRespawnLandmarkIndex) {
			preCPIdx = player.CurrentLaunchedRespawnLandmarkIndex;
			
			if(landmarks[preCPIdx].Waypoint is null || landmarks[preCPIdx].Waypoint.IsFinish || landmarks[preCPIdx].Waypoint.IsMultiLap) {
				// if null, it's a start block. if the other flags, it's either a multilap or a finish.
				// in all such cases, we reset the completed cp count to zero.
				curCP = 0;
			} else {
				curCP++;
			}
		}
		
#elif TURBO
		auto playground = cast<CTrackManiaRaceNew>(GetApp().CurrentPlayground);
		auto playgroundScript = cast<CTrackManiaRaceRules>(GetApp().PlaygroundScript);
		
		if(playground is null
			|| playgroundScript is null
			|| playground.GameTerminals.Length <= 0
			|| cast<CTrackManiaPlayer>(playground.GameTerminals[0].ControlledPlayer) is null) {
			inGame = false;
			return;
		}
		
		auto player = cast<CTrackManiaPlayer>(playground.GameTerminals[0].ControlledPlayer);
		
		if(player is null
			|| player.CurLap is null
			|| player.RaceState != CTrackManiaPlayer::ERaceState::Running) {
			inGame = false;
			return;
		}
		
		if(hideCounterWithIFace) {
			if(playground.Interface is null || Dev::GetOffsetUint32(playground.Interface, 0x1C) == 0) {
				inGame = false;
				return;
			}
		}
		
		/* Turbo doesn't support linked checkpoints, so this is sufficient */
		maxCP = playgroundScript.MapCheckpointPos.Length;
		
		inGame = true;
		
		/* Checkpoints gains the time value of each CP as it is passed */
		curCP = player.CurLap.Checkpoints.Length;
		
#elif MP4
		auto playground = cast<CTrackManiaRaceNew>(GetApp().CurrentPlayground);
		auto rootMap = GetApp().RootMap;
		
		if(playground is null
			|| rootMap is null
			|| playground.GameTerminals.Length <= 0
			|| cast<CTrackManiaPlayer>(playground.GameTerminals[0].GUIPlayer) is null) {
			inGame = false;
			return;
		}
		
		auto scriptPlayer = cast<CTrackManiaPlayer>(playground.GameTerminals[0].GUIPlayer).ScriptAPI;
		
		if(scriptPlayer is null
			|| scriptPlayer.CurLap is null
			|| scriptPlayer.RaceState != CTrackManiaPlayer::ERaceState::Running) {
			inGame = false;
			return;
		}
		
		if(hideCounterWithIFace) {
			if(playground.Interface is null || Dev::GetOffsetUint32(playground.Interface, 0x1C) == 0) {
				inGame = false;
				return;
			}
		}
		
		/* GetApp().PlaygroundScript.MapCheckpointPos.Length would be easier, but incorrect for linked CPs */
		
		if(!inGame && (curMapId != rootMap.IdName || GetApp().Editor !is null)) {
			// keep the previously-determined CP data, unless in the map editor
			curMapId = rootMap.IdName;
			maxCP = 0;
			strictMode = true;
			
			array<int> links = {};
			for(uint i = 0; i < rootMap.Blocks.Length; i++) {
				if(rootMap.Blocks[i].WaypointSpecialProperty !is null && rootMap.Blocks[i].BlockInfo !is null) {
					auto tag = rootMap.Blocks[i].WaypointSpecialProperty.Tag;
					auto type = rootMap.Blocks[i].BlockInfo.WaypointType;
					if(type == CGameCtnBlockInfo::EWayPointType::Checkpoint) {
						// we have a CP, but we don't know if it is Linked or not
						if(tag == "Checkpoint" || tag == "Goal") {
							maxCP++;
						} else if(tag == "LinkedCheckpoint") {
							if(links.Find(rootMap.Blocks[i].WaypointSpecialProperty.Order) < 0) {
								maxCP++;
								links.InsertLast(rootMap.Blocks[i].WaypointSpecialProperty.Order);
							}
						} else {
							// this waypoint looks like a CP, acts like a CP, but is not called a CP.
							if(strictMode) {
								warn("The current map, " + string(rootMap.MapName) + " (" + rootMap.IdName + "), is not compliant with checkpoint naming rules."
										+ " If the CP count for this map is inaccurate, please report this map on the GitHub issues page:"
										+ " https://github.com/Phlarx/tm-checkpoint-counter/issues");
							}
							maxCP++;
							strictMode = false;
						}
					}
				}
			}
			for(uint i = 0; i < rootMap.AnchoredObjects.Length; i++) {
				if(rootMap.AnchoredObjects[i].WaypointSpecialProperty !is null) {
					auto tag = rootMap.AnchoredObjects[i].WaypointSpecialProperty.Tag;
					auto type = rootMap.AnchoredObjects[i].ItemModel.WaypointType;
					if(type == CGameItemModel::EnumWaypointType::Checkpoint) {
						// we have a CP, but we don't know if it is Linked or not
						if(tag == "Checkpoint" || tag == "Goal") {
							maxCP++;
						} else if(tag == "LinkedCheckpoint") {
							if(links.Find(rootMap.AnchoredObjects[i].WaypointSpecialProperty.Order) < 0) {
								maxCP++;
								links.InsertLast(rootMap.AnchoredObjects[i].WaypointSpecialProperty.Order);
							}
						} else {
							// this waypoint looks like a CP, acts like a CP, but is not called a CP.
							if(strictMode) {
								warn("The current map, " + string(rootMap.MapName) + " (" + rootMap.IdName + "), is not compliant with checkpoint naming rules."
										+ " If the CP count for this map is inaccurate, please report this map on the GitHub issues page:"
										+ " https://github.com/Phlarx/tm-checkpoint-counter/issues");
							}
							maxCP++;
							strictMode = false;
						}
					}
				}
			}
		}
		inGame = true;
		
		/* Checkpoints gains the time value of each CP as it is passed */
		curCP = scriptPlayer.CurLap.Checkpoints.Length;
		
#endif
	}
}