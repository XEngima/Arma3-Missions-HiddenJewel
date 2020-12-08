
















cl_Tvtcf_Server_CampaignEngine_IsRunning_PropIndex = 2; cl_Tvtcf_Server_CampaignEngine_IsCancelling_PropIndex = 3; cl_Tvtcf_Server_CampaignEngine_RunAsync = { _this call cl_Sqx_Services_Service_RunAsync }; cl_Tvtcf_Server_CampaignEngine_Cancel = { _this call cl_Sqx_Services_Service_Cancel };








cl_Tvtcf_Server_CampaignEngine_constructor = { params ["_class_fields", "_this"]; params ["_baseMarkersConfig", "_missionUnitsHandler", "_aiUnitsWestCount", "_aiUnitsEastCount", "_timeBetweenMissions", "_campaignLimitTime", "_campaignMode"]; 

    ([_class_fields, []] call cl_Sqx_Services_Service_Constructor);

    _class_fields set [4, _baseMarkersConfig];
    _class_fields set [7, _missionUnitsHandler];
    _class_fields set [10, _aiUnitsWestCount];
    _class_fields set [11, _aiUnitsEastCount];
    _class_fields set [12, _timeBetweenMissions];
    _class_fields set [13, _campaignLimitTime];
    _class_fields set [14, _campaignMode];
    _class_fields set [25, false];
    _class_fields set [26, ([[["Tvtcf_Common_ObjectiveChangeCollection",[]]], []] call cl_Tvtcf_Common_ObjectiveChangeCollection_constructor)];
    _class_fields set [27, []];

    _class_fields set [5, ([[["Tvtcf_Server_ServerActionHandler",[]]], []] call cl_Tvtcf_Server_ServerActionHandler_constructor)];

    ([_class_fields, []] call cl_Tvtcf_Server_CampaignEngine_ClearAllMapMarkers); _class_fields };



cl_Tvtcf_Server_CampaignEngine_SetCampaign = { params ["_class_fields", "_this"]; params ["_campaign"]; 
    ([_campaign, [(_class_fields select 14)]] call cl_Campaigns_Campaign_SetCampaignMode);
    _class_fields set [6, _campaign]; };



cl_Tvtcf_Server_CampaignEngine_ClearAllMapMarkers = { params ["_class_fields", "_this"];
    {
        _x setMarkerAlpha 0;
    } forEach allMapMarkers; };



cl_Tvtcf_Server_CampaignEngine_NotifyClientsAboutMissionStart = { params ["_class_fields", "_this"]; params ["_mission"]; 
    private ["_startMarkers", "_markers"];

    _startMarkers = [];
    _markers = [];

    {
        _startMarkers pushBack ([[["Tvtcf_Common_MarkerInfo",[]]], [_x, west]] call cl_Tvtcf_Common_MarkerInfo_constructor);
    } forEach ([_mission, [west]] call cl_Campaigns_Mission_GetInsertionAreaMarkers);

    {
        _startMarkers pushBack ([[["Tvtcf_Common_MarkerInfo",[]]], [_x, east]] call cl_Tvtcf_Common_MarkerInfo_constructor);
    } forEach ([_mission, [east]] call cl_Campaigns_Mission_GetInsertionAreaMarkers);

    {
        _markers pushBack ([[["Tvtcf_Common_MarkerInfo",[]]], [_x, west]] call cl_Tvtcf_Common_MarkerInfo_constructor);
    } forEach ([_mission, [west]] call cl_Campaigns_Mission_GetVisibleMarkers);

    {
        _markers pushBack ([[["Tvtcf_Common_MarkerInfo",[]]], [_x, east]] call cl_Tvtcf_Common_MarkerInfo_constructor);
    } forEach ([_mission, [east]] call cl_Campaigns_Mission_GetVisibleMarkers);

    _class_fields set [18, ([[["Tvtcf_Common_MissionMarkersInfo",[]]], [_startMarkers, _markers, ([_mission, [west]] call cl_Campaigns_Mission_GetSideHasReturnObjective), ([_mission, [east]] call cl_Campaigns_Mission_GetSideHasReturnObjective)]] call cl_Tvtcf_Common_MissionMarkersInfo_constructor)];

    [(_class_fields select 18)] call Tvtcf_Communication_PublicVariableHandler_BroadcastMissionMarkersInfo;
    ["ClientEventReciever.OnMissionSetup", [(_class_fields select 18)]] call Tvtcf_Communication_Remote_Invoke; };



cl_Tvtcf_Server_CampaignEngine_InsertSideWithNoPlayers = { params ["_class_fields", "_this"]; params ["_missionMarkersInfo"]; 
    private ["_markerInfos", "_marker"];

    {
        private _side = _x;
        private _playersCount = 0;

        {
            if (side group _x == _side) then {
                _playersCount = _playersCount + 1; };
        } forEach 
        call BIS_fnc_listPlayers;

        if (_playersCount == 0) then {


            _markerInfos = ([_missionMarkersInfo, [_side]] call cl_Tvtcf_Common_MissionMarkersInfo_GetStartMarkersBySide);

            if (count _markerInfos > 0) then {
                _marker = _markerInfos select 0; } else { 


                _marker = ([(_class_fields select 4), [_side, 1]] call compile ("_this call cl_" + (((_class_fields select 4) select 0) select 0) + "_GetMarkerName")); };


            private _switchableUnits = ([(_class_fields select 7), []] call cl_Tvtcf_Server_MissionUnitsHandler_GetSwitchableUnits);

            {
                if (side group _x == _side) then {
                    _x setPos getMarkerPos _marker; };
            } forEach 
            _switchableUnits; };
    } forEach 
    [west, east]; };



cl_Tvtcf_Server_CampaignEngine_NotifyAboutMissionBriefing = { params ["_class_fields", "_this"]; params ["_mission"]; 
    private ["_missionBriefing"];

    private _briefingInfoWest = ([_mission, [west]] call cl_Campaigns_Mission_GetBriefingInfo);
    private _briefingInfoEast = ([_mission, [east]] call cl_Campaigns_Mission_GetBriefingInfo);
    private _westPrimaryObjective = ([_mission, [west, 1]] call cl_Campaigns_Mission_GetMissionObjective);
    private _westSecondaryObjective = ([_mission, [west, 2]] call cl_Campaigns_Mission_GetMissionObjective);
    private _westReturnObjective = ([_mission, [west, 3]] call cl_Campaigns_Mission_GetMissionObjective);
    private _eastPrimaryObjective = ([_mission, [east, 1]] call cl_Campaigns_Mission_GetMissionObjective);
    private _eastSecondaryObjective = ([_mission, [east, 2]] call cl_Campaigns_Mission_GetMissionObjective);
    private _eastReturnObjective = ([_mission, [east, 3]] call cl_Campaigns_Mission_GetMissionObjective);

    _missionBriefing = ([[["Tvtcf_Common_MissionBriefing",[]]], [(_mission select 37), _briefingInfoWest, _westPrimaryObjective, _westSecondaryObjective, _westReturnObjective, _briefingInfoEast, _eastPrimaryObjective, _eastSecondaryObjective, _eastReturnObjective]] call cl_Tvtcf_Common_MissionBriefing_constructor);

    private _serverTime = call Tvtcf_Common_Functions_GetMissionTime;

    [_serverTime] call Tvtcf_Communication_PublicVariableHandler_BroadcastBriefingEndTime;

    [_missionBriefing] call Tvtcf_Communication_PublicVariableHandler_BroadcastMissionBriefing;
    ["ClientEventReciever.OnMissionBriefing", [_missionBriefing, _serverTime]] call Tvtcf_Communication_Remote_Invoke;

    _class_fields set [26, ([[["Tvtcf_Common_ObjectiveChangeCollection",[]]], []] call cl_Tvtcf_Common_ObjectiveChangeCollection_constructor)];
    [(_class_fields select 26)] call Tvtcf_Communication_PublicVariableHandler_BroadcastObjectiveChangeCollection; };



cl_Tvtcf_Server_CampaignEngine_InsertGroup = { params ["_class_fields", "_this"]; params ["_side", "_position"]; scopeName "InsertGroup";
    private ["_e"];
    _e = ["null"];

    private _group = grpNull;

    {
        if (side group _x == _side) then {
            _group = group _x; };
    } forEach 
    (([(_class_fields select 7), []] call cl_Tvtcf_Server_MissionUnitsHandler_GetSwitchableUnits));

    if (_side == west) then {

        if (!(_class_fields select 17)) then {

            if (!isNull _group) then {
                _e = ([(_class_fields select 15), [_group, _position]] call cl_Campaigns_Mission_InsertGroup);
                _class_fields set [8, units _group]; };


            _class_fields set [17, true];
            [true] call Tvtcf_Communication_PublicVariableHandler_BroadcastWestHasInserted;
            [_position] call Tvtcf_Communication_PublicVariableHandler_BroadcastWestInsertionPos;
            [(_class_fields select 8)] call Tvtcf_Communication_PublicVariableHandler_BroadcastInsertedWestlyUnits; }; } else { 




        if (!(_class_fields select 16)) then {

            if (!isNull _group) then {
                _e = ([(_class_fields select 15), [_group, _position]] call cl_Campaigns_Mission_InsertGroup);
                _class_fields set [9, units _group]; };


            _class_fields set [16, true];
            [true] call Tvtcf_Communication_PublicVariableHandler_BroadcastEastHasInserted;
            [_position] call Tvtcf_Communication_PublicVariableHandler_BroadcastEastInsertionPos;
            [(_class_fields select 9)] call Tvtcf_Communication_PublicVariableHandler_BroadcastInsertedEastlyUnits; }; };



    (_e) breakOut "InsertGroup"; };



cl_Tvtcf_Server_CampaignEngine_EndCurrentMission = { params ["_class_fields", "_this"];
    if (!((_class_fields select 15) isEqualTo ["null"])) then {
        ([(_class_fields select 15), []] call compile ("_this call cl_" + (((_class_fields select 15) select 0) select 0) + "_Cancel")); }; };




cl_Tvtcf_Server_CampaignEngine_ForceNextMission = { params ["_class_fields", "_this"];
    _class_fields set [25, true]; };



cl_Tvtcf_Server_CampaignEngine_OnAction = { params ["_class_fields", "_this"]; params ["_serverActionId", "_target", "_caller"]; 
    ([(_class_fields select 15), [_serverActionId, _target, _caller]] call compile ("_this call cl_" + (((_class_fields select 15) select 0) select 0) + "_OnAction")); };



cl_Tvtcf_Server_CampaignEngine_AllUnitsAreDead = { params ["_class_fields", "_this"]; scopeName "AllUnitsAreDead";
    if ((count (_class_fields select 9)) + (count (_class_fields select 8)) == 0) then {
        (false) breakOut "AllUnitsAreDead"; };


    {
        if (alive _x) then {
            (false) breakOut "AllUnitsAreDead"; };
    } forEach 
    (_class_fields select 8);

    {
        if (alive _x) then {
            (false) breakOut "AllUnitsAreDead"; };
    } forEach 
    (_class_fields select 9);

    (true) breakOut "AllUnitsAreDead"; };



cl_Tvtcf_Server_CampaignEngine_CheckAndNotifyObjectives = { params ["_class_fields", "_this"]; params ["_mission"]; 
    private ["_state"];



    if (!(_class_fields select 19)) then {
        _state = ([_mission, [west, 1]] call cl_Campaigns_Mission_CheckObjectiveState);

        if (_state != 1) then {

            ([(_class_fields select 26), [west, 1, _state]] call cl_Tvtcf_Common_ObjectiveChangeCollection_AddObjectiveChange);
            [(_class_fields select 26)] call Tvtcf_Communication_PublicVariableHandler_BroadcastObjectiveChangeCollection;
            ["ClientEventReciever.OnTaskStateChanged", [west, 1, _state]] call Tvtcf_Communication_Remote_Invoke;
            _class_fields set [19, true]; }; };



    if (!(_class_fields select 20)) then {

        _state = ([_mission, [west, 2]] call cl_Campaigns_Mission_CheckObjectiveState);

        if (_state != 1) then {
            ([(_class_fields select 26), [west, 2, _state]] call cl_Tvtcf_Common_ObjectiveChangeCollection_AddObjectiveChange);
            [(_class_fields select 26)] call Tvtcf_Communication_PublicVariableHandler_BroadcastObjectiveChangeCollection;
            ["ClientEventReciever.OnTaskStateChanged", [west, 2, _state]] call Tvtcf_Communication_Remote_Invoke;
            _class_fields set [20, true]; }; };



    if (!(_class_fields select 21)) then {

        _state = ([_mission, [west, 3]] call cl_Campaigns_Mission_CheckObjectiveState);

        if (_state == 4) then {
            [true] call Tvtcf_Communication_PublicVariableHandler_BroadcastWestHasReturned; };


        if (_state != 1) then {

            ([(_class_fields select 26), [west, 3, _state]] call cl_Tvtcf_Common_ObjectiveChangeCollection_AddObjectiveChange);
            [(_class_fields select 26)] call Tvtcf_Communication_PublicVariableHandler_BroadcastObjectiveChangeCollection;
            ["ClientEventReciever.OnTaskStateChanged", [west, 3, _state]] call Tvtcf_Communication_Remote_Invoke;
            _class_fields set [21, true]; }; };





    if (!(_class_fields select 22)) then {

        _state = ([_mission, [east, 1]] call cl_Campaigns_Mission_CheckObjectiveState);

        if (_state != 1) then {
            ([(_class_fields select 26), [east, 1, _state]] call cl_Tvtcf_Common_ObjectiveChangeCollection_AddObjectiveChange);
            [(_class_fields select 26)] call Tvtcf_Communication_PublicVariableHandler_BroadcastObjectiveChangeCollection;
            ["ClientEventReciever.OnTaskStateChanged", [east, 1, _state]] call Tvtcf_Communication_Remote_Invoke;
            _class_fields set [22, true]; }; };



    if (!(_class_fields select 23)) then {

        _state = ([_mission, [east, 2]] call cl_Campaigns_Mission_CheckObjectiveState);

        if (_state != 1) then {
            ([(_class_fields select 26), [east, 2, _state]] call cl_Tvtcf_Common_ObjectiveChangeCollection_AddObjectiveChange);
            [(_class_fields select 26)] call Tvtcf_Communication_PublicVariableHandler_BroadcastObjectiveChangeCollection;
            ["ClientEventReciever.OnTaskStateChanged", [east, 2, _state]] call Tvtcf_Communication_Remote_Invoke;
            _class_fields set [23, true]; }; };



    if (!(_class_fields select 24)) then {

        _state = ([_mission, [east, 3]] call cl_Campaigns_Mission_CheckObjectiveState);

        if (_state == 4) then {
            [true] call Tvtcf_Communication_PublicVariableHandler_BroadcastEastHasReturned; };


        if (_state != 1) then {
            ([(_class_fields select 26), [east, 3, _state]] call cl_Tvtcf_Common_ObjectiveChangeCollection_AddObjectiveChange);
            [(_class_fields select 26)] call Tvtcf_Communication_PublicVariableHandler_BroadcastObjectiveChangeCollection;
            ["ClientEventReciever.OnTaskStateChanged", [east, 3, _state]] call Tvtcf_Communication_Remote_Invoke;
            _class_fields set [24, true]; }; }; };









Tvtcf_Server_CampaignEngine_DeleteItemInArray = {  params ["_array", "_item"]; scopeName "DeleteItemInArray";
    private _removedSomething = true;
    private _removedItemsCount = 0;

    diag_log ("DELETEITEM: Before removal of " + str _item + ": " + str _array);

    while { _removedSomething } do {

        private _index = -1;
        _removedSomething = false;

        for "_i" from 0 to count _array - 1 do {
            scopeName "for_loop";

            if (_array # _i == _item) then {
                _index = _i;
                breakOut "for_loop"; }; };



        if (_index >= 0) then {
            _array deleteAt _index;
            _removedItemsCount = _removedItemsCount + 1;
            _removedSomething = true; }; };



    diag_log ("DELETEITEM: After removal of " + str _item + ": " + str _array);

    (_removedItemsCount) breakOut "DeleteItemInArray"; };



Tvtcf_Server_CampaignEngine_CloneArray = {  params ["_array"]; scopeName "CloneArray";
    private _clonedArray = [];

    {
        _clonedArray pushBack _x;
    } forEach _array;

    (_clonedArray) breakOut "CloneArray"; };



cl_Tvtcf_Server_CampaignEngine_SaveHistoryTokens = { params ["_class_fields", "_this"]; params ["_mission"]; 
    private ["_gainedTokensWest", "_lostTokensWest", "_gainedTokensEast", "_lostTokensEast"];

    private _earlierGainedTokensWest = ((_class_fields select 6) select 4);
    private _earlierGainedTokensEast = ((_class_fields select 6) select 5);
    private _earlierLostTokensWest = ((_class_fields select 6) select 6);
    private _earlierLostTokensEast = ((_class_fields select 6) select 7);

    if ((([_mission, [1]] call cl_Campaigns_Mission_GetActualSide)) == west) then {

        _gainedTokensWest = (_mission select 10) - _earlierGainedTokensWest;
        _lostTokensWest = (_mission select 11) - _earlierLostTokensWest;
        _gainedTokensEast = (_mission select 12) - _earlierGainedTokensEast;
        _lostTokensEast = (_mission select 13) - _earlierLostTokensEast; } else { 


        _gainedTokensWest = (_mission select 12) - _earlierGainedTokensWest;
        _lostTokensWest = (_mission select 13) - _earlierLostTokensWest;
        _gainedTokensEast = (_mission select 10) - _earlierGainedTokensEast;
        _lostTokensEast = (_mission select 11) - _earlierLostTokensEast; };


    diag_log ("TOKENS1: GainedTokensWest: " + str _gainedTokensWest);
    diag_log ("TOKENS1: GainedTokensEast: " + str _gainedTokensEast);
    diag_log ("TOKENS1: LostTokensWest: " + str _lostTokensWest);
    diag_log ("TOKENS1: LostTokensEast: " + str _lostTokensEast);

    diag_log ("TOKENS1: EarlierGainedTokensWest: " + str _earlierGainedTokensWest);
    diag_log ("TOKENS1: EarlierGainedTokensEast: " + str _earlierGainedTokensEast);
    diag_log ("TOKENS1: EarlierLostTokensWest: " + str _earlierLostTokensWest);
    diag_log ("TOKENS1: EarlierLostTokensEast: " + str _earlierLostTokensEast);


    {
        if (_x in _earlierGainedTokensWest) then {
            [_earlierGainedTokensWest, _x] call Tvtcf_Server_CampaignEngine_DeleteItemInArray; };


        if (!(_x in _earlierLostTokensWest)) then {
            _earlierLostTokensWest pushBack _x; };
    } forEach 
    _lostTokensWest;


    {
        if (_x in _earlierLostTokensWest) then {
            [_earlierLostTokensWest, _x] call Tvtcf_Server_CampaignEngine_DeleteItemInArray; };


        if (!(_x in _earlierGainedTokensWest)) then {
            _earlierGainedTokensWest pushBack _x; };
    } forEach 
    _gainedTokensWest;


    {
        if (_x in _earlierGainedTokensEast) then {
            [_earlierGainedTokensEast, _x] call Tvtcf_Server_CampaignEngine_DeleteItemInArray; };


        if (!(_x in _earlierLostTokensEast)) then {
            _earlierLostTokensEast pushBack _x; };
    } forEach 
    _lostTokensEast;


    {
        if (_x in _earlierLostTokensEast) then {
            [_earlierLostTokensEast, _x] call Tvtcf_Server_CampaignEngine_DeleteItemInArray; };


        if (!(_x in _earlierGainedTokensEast)) then {
            _earlierGainedTokensEast pushBack _x; };
    } forEach 
    _gainedTokensEast;

    diag_log ("TOKENS2: GainedTokensWest: " + str _gainedTokensWest);
    diag_log ("TOKENS2: GainedTokensEast: " + str _gainedTokensEast);
    diag_log ("TOKENS2: LostTokensWest: " + str _lostTokensWest);
    diag_log ("TOKENS2: LostTokensEast: " + str _lostTokensEast);

    diag_log ("TOKENS2: EarlierGainedTokensWest: " + str _earlierGainedTokensWest);
    diag_log ("TOKENS2: EarlierGainedTokensEast: " + str _earlierGainedTokensEast);
    diag_log ("TOKENS2: EarlierLostTokensWest: " + str _earlierLostTokensWest);
    diag_log ("TOKENS2: EarlierLostTokensEast: " + str _earlierLostTokensEast); };



cl_Tvtcf_Server_CampaignEngine_PrepareMission = { params ["_class_fields", "_this"]; params ["_mission"]; 
    private _westGroup = grpNull;
    private _eastGroup = grpNull;

    {
        if (side group _x == west) then {
            _westGroup = group _x; };

        if (side group _x == east) then {
            _eastGroup = group _x; };
    } forEach 
    (([(_class_fields select 7), []] call cl_Tvtcf_Server_MissionUnitsHandler_GetSwitchableUnits));

    if ((([_mission, [1]] call cl_Campaigns_Mission_GetActualSide)) == west) then {
        ([_mission, [(_class_fields select 4), (_class_fields select 5), _westGroup, _eastGroup, [((_class_fields select 6) select 4)] call Tvtcf_Server_CampaignEngine_CloneArray, [((_class_fields select 6) select 6)] call Tvtcf_Server_CampaignEngine_CloneArray, [((_class_fields select 6) select 5)] call Tvtcf_Server_CampaignEngine_CloneArray, [((_class_fields select 6) select 7)] call Tvtcf_Server_CampaignEngine_CloneArray, ([[["Campaigns_Network_Remote",["Tvtcf.Communication.CampaignRemote"]]], []] call cl_Campaigns_Network_Remote_constructor)]] call cl_Campaigns_Mission_Prepare); } else { 


        ([_mission, [(_class_fields select 4), (_class_fields select 5), _westGroup, _eastGroup, [((_class_fields select 6) select 5)] call Tvtcf_Server_CampaignEngine_CloneArray, [((_class_fields select 6) select 7)] call Tvtcf_Server_CampaignEngine_CloneArray, [((_class_fields select 6) select 4)] call Tvtcf_Server_CampaignEngine_CloneArray, [((_class_fields select 6) select 6)] call Tvtcf_Server_CampaignEngine_CloneArray, ([[["Campaigns_Network_Remote",["Tvtcf.Communication.CampaignRemote"]]], []] call cl_Campaigns_Network_Remote_constructor)]] call cl_Campaigns_Mission_Prepare); }; };




cl_Tvtcf_Server_CampaignEngine_MissionTimeIsUp = { params ["_class_fields", "_this"]; scopeName "MissionTimeIsUp";
    if ((_class_fields select 13) > 0) then {

        private _tickedTimeSec = floor diag_tickTime;
        private _campaignEndTimeSec = (_class_fields select 28) + (_class_fields select 13) * 60;

        (_tickedTimeSec >= _campaignEndTimeSec) breakOut "MissionTimeIsUp"; };


    (false) breakOut "MissionTimeIsUp"; };



cl_Tvtcf_Server_CampaignEngine_Run = { params ["_class_fields", "_this"];
    private ["_missionResultWest", "_missionResultEast"];

    private _accumulatedScoreWest = 0;
    private _accumulatedScoreEast = 0;

    sleep 3;

    ["ClientEventReciever.OnCampaignStart", []] call Tvtcf_Communication_Remote_Invoke;
    _class_fields set [28, floor diag_tickTime];



    _class_fields set [15,([(_class_fields select 6), []] call cl_Campaigns_Campaign_GetNextMissionToPlay)];
    _class_fields set [27, []];
    private _isFirstMission = true;

    while { !((_class_fields select 15) isEqualTo ["null"]) } do {

        _class_fields set [16, false];
        _class_fields set [17, false];
        _class_fields set [9, []];
        _class_fields set [8, []];
        _class_fields set [19, false];
        _class_fields set [20, false];
        _class_fields set [21, false];
        _class_fields set [22, false];
        _class_fields set [23, false];
        _class_fields set [24, false];

        [true] call Tvtcf_Communication_PublicVariableHandler_BroadcastMissionHasStarted;
        ["ClientEventReciever.OnMissionStarting", [_isFirstMission]] call Tvtcf_Communication_Remote_Invoke;


        private _westlyGroup = ([(_class_fields select 7), [west]] call cl_Tvtcf_Server_MissionUnitsHandler_GetGroupBySide);
        private _westlyAi = ([(_class_fields select 7), [west]] call cl_Tvtcf_Server_MissionUnitsHandler_GetAiUnitsBySide);
        private _westRespawnPos = getMarkerPos (([(_class_fields select 4), [west, 1]] call compile ("_this call cl_" + (((_class_fields select 4) select 0) select 0) + "_GetMarkerName")));

        for "_i" from (count _westlyAi) to (_class_fields select 10) - 1 do {

            private _aiUnit = _westlyGroup createUnit ["B_Soldier_F", _westRespawnPos, [], 0, "NONE"];
            ([(_class_fields select 7), [_aiUnit]] call cl_Tvtcf_Server_MissionUnitsHandler_AddAiUnit); };


        private _eastlyGroup = ([(_class_fields select 7), [east]] call cl_Tvtcf_Server_MissionUnitsHandler_GetGroupBySide);
        private _eastlyAi = ([(_class_fields select 7), [east]] call cl_Tvtcf_Server_MissionUnitsHandler_GetAiUnitsBySide);
        private _eastRespawnPos = getMarkerPos (([(_class_fields select 4), [east, 1]] call compile ("_this call cl_" + (((_class_fields select 4) select 0) select 0) + "_GetMarkerName")));

        for "_i" from (count _eastlyAi) to (_class_fields select 11) - 1 do {

            private _aiUnit = _eastlyGroup createUnit ["O_Soldier_F", _eastRespawnPos, [], 0, "NONE"];
            ([(_class_fields select 7), [_aiUnit]] call cl_Tvtcf_Server_MissionUnitsHandler_AddAiUnit); };


        ([_class_fields, [(_class_fields select 15)]] call cl_Tvtcf_Server_CampaignEngine_PrepareMission);

        ([_class_fields, [(_class_fields select 15)]] call cl_Tvtcf_Server_CampaignEngine_NotifyClientsAboutMissionStart);
        ([_class_fields, [(_class_fields select 15)]] call cl_Tvtcf_Server_CampaignEngine_NotifyAboutMissionBriefing);

        ([_class_fields, [(_class_fields select 18)]] call cl_Tvtcf_Server_CampaignEngine_InsertSideWithNoPlayers);

        private _remainingTime = ((_class_fields select 15) select 40);
        private _startTime = call Tvtcf_Common_Functions_GetMissionTime;

        private _endTime = _startTime + ((_class_fields select 15) select 38) * 60;

        ([(_class_fields select 15), []] call compile ("_this call cl_" + (((_class_fields select 15) select 0) select 0) + "_RunAsync"));
        ["ClientEventReciever.OnMissionTimeTick", [((_class_fields select 15) select 38)]] call Tvtcf_Communication_Remote_Invoke;

        while { ((_class_fields select 15) select 2) } do {

            private _elapsedTimeInMin = floor (((call Tvtcf_Common_Functions_GetMissionTime) - _startTime) / 60);

            if (_elapsedTimeInMin != ((_class_fields select 15) select 39)) then {

                ([(_class_fields select 15), [_elapsedTimeInMin]] call cl_Campaigns_Mission_SetTimeElapsed);
                ["ClientEventReciever.OnMissionTimeTick", [((_class_fields select 15) select 40)]] call Tvtcf_Communication_Remote_Invoke; };




            private _serverTime = call Tvtcf_Common_Functions_GetMissionTime;

            if (_serverTime > _endTime) then {
                ([(_class_fields select 15), [((_class_fields select 15) select 39)]] call cl_Campaigns_Mission_SetTimeElapsed);
                ([(_class_fields select 15), []] call compile ("_this call cl_" + (((_class_fields select 15) select 0) select 0) + "_Cancel")); };




            if (([_class_fields, []] call cl_Tvtcf_Server_CampaignEngine_AllUnitsAreDead)) then {

                ([(_class_fields select 15), []] call compile ("_this call cl_" + (((_class_fields select 15) select 0) select 0) + "_Cancel")); };


            sleep 1;

            _isFirstMission = false;
            ([_class_fields, [(_class_fields select 15)]] call cl_Tvtcf_Server_CampaignEngine_CheckAndNotifyObjectives); };



        ([_class_fields, [(_class_fields select 15)]] call cl_Tvtcf_Server_CampaignEngine_CheckAndNotifyObjectives);


        ([_class_fields, [(_class_fields select 15)]] call cl_Tvtcf_Server_CampaignEngine_SaveHistoryTokens);


        _missionResultWest = ([(_class_fields select 15), [west]] call cl_Campaigns_Mission_GetMissionResult);
        _missionResultEast = ([(_class_fields select 15), [east]] call cl_Campaigns_Mission_GetMissionResult);

        _accumulatedScoreWest = _accumulatedScoreWest + (_missionResultWest select 14);
        _accumulatedScoreEast = _accumulatedScoreEast + (_missionResultEast select 14);

        [false] call Tvtcf_Communication_PublicVariableHandler_BroadcastMissionHasStarted;
        ["ClientEventReciever.OnMissionEnding", []] call Tvtcf_Communication_Remote_Invoke;

        [false] call Tvtcf_Communication_PublicVariableHandler_BroadcastWestHasInserted;
        [false] call Tvtcf_Communication_PublicVariableHandler_BroadcastEastHasInserted;
        [[]] call Tvtcf_Communication_PublicVariableHandler_BroadcastInsertedWestlyUnits;
        [[]] call Tvtcf_Communication_PublicVariableHandler_BroadcastInsertedEastlyUnits;
        [false] call Tvtcf_Communication_PublicVariableHandler_BroadcastWestHasReturned;
        [false] call Tvtcf_Communication_PublicVariableHandler_BroadcastEastHasReturned;

        sleep 2;

        ([(_class_fields select 15), []] call compile ("_this call cl_" + (((_class_fields select 15) select 0) select 0) + "_Dispose"));

        private _nextMission = ([(_class_fields select 6), []] call cl_Campaigns_Campaign_GetNextMissionToPlay);
        private _isLastMission = (_nextMission isEqualTo ["null"]);

        if (([_class_fields, []] call cl_Tvtcf_Server_CampaignEngine_MissionTimeIsUp)) then {
            _nextMission = ["null"];
            _isLastMission = true; };


        private _missionResult = ([[["Tvtcf_Common_MissionResult",[]]], [((_class_fields select 15) select 37), _missionResultWest, _missionResultEast, _accumulatedScoreWest, _accumulatedScoreEast]] call cl_Tvtcf_Common_MissionResult_constructor);

        (_class_fields select 27) pushBack _missionResult;
        [(_class_fields select 27)] call Tvtcf_Communication_PublicVariableHandler_BroadcastMissionResultArray;

        ["ClientEventReciever.OnMissionEnded", [_missionResult, _isLastMission]] call Tvtcf_Communication_Remote_Invoke;

        private _time = call Tvtcf_Common_Functions_GetMissionTime;
        private _nextMissionStartTime = _time + (_class_fields select 12);

        sleep 0.1;

        if (!(_nextMission isEqualTo ["null"])) then {
            [_nextMissionStartTime] call Tvtcf_Communication_PublicVariableHandler_BroadcastNextMissionStartTime;
            waitUntil { (_class_fields select 25) || (call Tvtcf_Common_Functions_GetMissionTime) > _nextMissionStartTime };

            if ((_class_fields select 25)) then {
                ["ClientEventReciever.OnForceNextMission", []] call Tvtcf_Communication_Remote_Invoke;
                sleep 2; };


            _class_fields set [25, false]; };


        if (([_class_fields, []] call cl_Tvtcf_Server_CampaignEngine_MissionTimeIsUp)) then {
            _class_fields set [15, ["null"]]; } else { 


            _class_fields set [15, _nextMission]; }; };



    ["ClientEventReciever.OnCampaignEnded", [_accumulatedScoreWest, _accumulatedScoreEast]] call Tvtcf_Communication_Remote_Invoke;

    ([_class_fields, []] call cl_Sqx_Services_Service_Run); };