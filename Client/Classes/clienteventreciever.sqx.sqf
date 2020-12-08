
















cl_Tvtcf_Client_Statics_ClientEventReciever_constructor = { _this select 0 };



Tvtcf_Client_Statics_ClientEventReciever_OnCampaignStart = { 
    private _welcomeTutorial = [1] call Tvtcf_Client_TutorialConfig_GetTutorial;
    private _briefingText = ([_welcomeTutorial, []] call cl_Tvtcf_Client_Tutorial_ToBriefingText);
    ([Tvtcf_Client_Statics_ClientObjects_BriefingHandler, [_briefingText]] call compile ("_this call cl_" + ((Tvtcf_Client_Statics_ClientObjects_BriefingHandler select 0) select 0) + "_CreateWelcomeBriefing"));

    [] spawn {
        sleep 6;
        [1] call Tvtcf_Client_TutorialHandler_ShowTutorial;

        private _allPlayers = call BIS_fnc_listPlayers;
        private _westRepresented = false;
        private _eastRepresented = false;

        {
            if (side group _x == west) then {
                _westRepresented = true; } else { 

                _eastRepresented = true; };
        } forEach 
        _allPlayers;

        if (!_westRepresented || !_eastRepresented) then {
            sleep 2;
            [2] call Tvtcf_Client_TutorialHandler_ShowTutorial; }; }; };







Tvtcf_Client_Statics_ClientEventReciever_OnMissionTimeTick = {  params ["_missionTimeRemaining"]; 
    hint ("Mission ends in " + (str _missionTimeRemaining) + " minutes.");
    call Tvtcf_Client_TvtcfActionMenuHandler_UpdateVisibleOptions; };



Tvtcf_Client_Statics_ClientEventReciever_OnMissionStarting = {  params ["_isFirstMission"]; 

    ([Tvtcf_Client_Statics_ClientObjects_TaskHandler, []] call cl_Tvtcf_Client_TaskHandler_DeleteAllTasks);
    ([Tvtcf_Client_Statics_ClientObjects_MapMarkerHandler, []] call cl_Tvtcf_Client_MapMarkerHandler_CleanUpAllMarkers); };



Tvtcf_Client_Statics_ClientEventReciever_OnMissionSetup = {  params ["_missionMarkersInfo"]; 


    ([Tvtcf_Client_Statics_ClientObjects_MapMarkerHandler, [_missionMarkersInfo]] call cl_Tvtcf_Client_MapMarkerHandler_UpdateMarkers);

    private _startMarkers = ([_missionMarkersInfo, [playerSide]] call cl_Tvtcf_Common_MissionMarkersInfo_GetStartMarkersBySide);

    if (count _startMarkers > 0) then {
        ([Tvtcf_Client_Statics_ClientObjects_BaseInsertionService, []] call compile ("_this call cl_" + ((Tvtcf_Client_Statics_ClientObjects_BaseInsertionService select 0) select 0) + "_RunAsync")); } else { 




        if (player == leader group player) then {
            ["ServerEventReciever.OnPlayerPerformingInsertion", [playerSide, getPos player, true]] call Tvtcf_Communication_Remote_Invoke; }; };



    call Tvtcf_Client_TvtcfActionMenuHandler_UpdateVisibleOptions; };



Tvtcf_Client_Statics_ClientEventReciever_OnMissionBriefing = {  params ["_missionBriefing", "_serverTime"]; 
    private ["_missionPrepareCounter"];
    private ["_briefingService"];

    private _markersInfo = call Tvtcf_Communication_PublicVariableHandler_GetMissionMarkersInfo;
    private _startMarkers = ([_markersInfo, [playerSide]] call cl_Tvtcf_Common_MissionMarkersInfo_GetStartMarkersBySide);



    if (count _startMarkers > 0) then {
        _missionPrepareCounter = ([[["Tvtcf_Client_MissionPrepareCounter",["Sqx.Services.Service", "Sqx.Services.IService"]]], [Tvtcf_Client_Statics_ClientObjects_MessageHandler, _serverTime + (Tvtcf_Common_Statics_CommonObjects_MissionParametersHandler select 2)]] call cl_Tvtcf_Client_MissionPrepareCounter_constructor);
        ([_missionPrepareCounter, []] call compile ("_this call cl_" + ((_missionPrepareCounter select 0) select 0) + "_RunAsync")); };


    _briefingService = ([[["Tvtcf_Client_MissionBriefingService",["Sqx.Services.Service", "Sqx.Services.IService"]]], [_missionBriefing, Tvtcf_Client_Statics_ClientObjects_BriefingHandler, Tvtcf_Client_Statics_ClientObjects_TaskHandler, ["null"], false]] call cl_Tvtcf_Client_MissionBriefingService_constructor);

    ([_briefingService, []] call compile ("_this call cl_" + ((_briefingService select 0) select 0) + "_RunAsync")); };



Tvtcf_Client_Statics_ClientEventReciever_OnInsertGroup = {  params ["_group", "_position", "_showInsertionMarker", "_doTeleport"]; 
    private ["_teleporter"];


    ([Tvtcf_Client_Statics_ClientObjects_BaseInsertionService, []] call compile ("_this call cl_" + ((Tvtcf_Client_Statics_ClientObjects_BaseInsertionService select 0) select 0) + "_Cancel"));

    if (playerSide == side _group) then {

        if (_showInsertionMarker) then {
            ([Tvtcf_Client_Statics_ClientObjects_MapMarkerHandler, [_position]] call cl_Tvtcf_Client_MapMarkerHandler_AddInsertionMarker); } else { 


            ([Tvtcf_Client_Statics_ClientObjects_MapMarkerHandler, []] call cl_Tvtcf_Client_MapMarkerHandler_RemoveInsertionMarkers); };


        if (_doTeleport) then {
            _teleporter = ([[["Tvtcf_Client_TeleportService",["Sqx.Services.Service", "Sqx.Services.IService"]]], [_position]] call cl_Tvtcf_Client_TeleportService_constructor);
            ([_teleporter, []] call compile ("_this call cl_" + ((_teleporter select 0) select 0) + "_RunAsync")); };


        if ((Tvtcf_Client_Statics_ClientObjects_MapMarkerHandler select 6)) then {
            ([Tvtcf_Client_Statics_ClientObjects_ExtractionSymbolHandler, [_position]] call cl_Tvtcf_Client_ExtractionSymbolHandler_CreateSymbol); }; };




    call Tvtcf_Client_TvtcfActionMenuHandler_UpdateVisibleOptions; };



Tvtcf_Client_Statics_ClientEventReciever_OnCreateSideMarker = {  params ["_side", "_markerInfo"]; 
    if (_side == playerSide) then {
        ([Tvtcf_Client_Statics_ClientObjects_MapMarkerHandler, [_markerInfo]] call cl_Tvtcf_Client_MapMarkerHandler_AddMarker); }; };




Tvtcf_Client_Statics_ClientEventReciever_OnTaskStateChanged = {  params ["_side", "_objectivePrio", "_objectiveState"]; 
    private ["_teleporter"];

    if (_side == playerSide) then {

        ([Tvtcf_Client_Statics_ClientObjects_TaskHandler, [_objectivePrio, _objectiveState, true]] call cl_Tvtcf_Client_TaskHandler_SetTaskState);

        if (_objectivePrio == 3 && _objectiveState == 4) then {


            ([Tvtcf_Client_Statics_ClientObjects_ExtractionSymbolHandler, []] call cl_Tvtcf_Client_ExtractionSymbolHandler_DeleteSymbol);

            private _baseMarkerName = ([Tvtcf_Common_Statics_CommonObjects_BaseMarkersConfig, [playerSide, 1]] call compile ("_this call cl_" + ((Tvtcf_Common_Statics_CommonObjects_BaseMarkersConfig select 0) select 0) + "_GetMarkerName"));

            _teleporter = ([[["Tvtcf_Client_TeleportService",["Sqx.Services.Service", "Sqx.Services.IService"]]], [getMarkerPos _baseMarkerName, false]] call cl_Tvtcf_Client_TeleportService_constructor);

            [_teleporter] spawn {
                params ["_teleporter"];

                sleep 5;

                [true] call Tvtcf_Client_Statics_ClientState_SetPlayerIsAlive;
                ([Tvtcf_Client_Statics_ClientObjects_CameraHandler, []] call cl_Tvtcf_Client_CameraHandler_UpdateDeathCamera);
                ([_teleporter, []] call compile ("_this call cl_" + ((_teleporter select 0) select 0) + "_RunAsync")); }; }; }; };






Tvtcf_Client_Statics_ClientEventReciever_OnMissionEnding = { 
    private ["_teleporter"];

    cutText ["", "BLACK OUT", 1];

    sleep 1.2;



    private _baseMarkerName = ([Tvtcf_Common_Statics_CommonObjects_BaseMarkersConfig, [playerSide, 1]] call compile ("_this call cl_" + ((Tvtcf_Common_Statics_CommonObjects_BaseMarkersConfig select 0) select 0) + "_GetMarkerName"));

    if (player distance getMarkerPos _baseMarkerName > 50) then {
        _teleporter = ([[["Tvtcf_Client_TeleportService",["Sqx.Services.Service", "Sqx.Services.IService"]]], [getMarkerPos _baseMarkerName, false, false]] call cl_Tvtcf_Client_TeleportService_constructor);
        ([_teleporter, []] call compile ("_this call cl_" + ((_teleporter select 0) select 0) + "_RunAsync")); };




    if (playerSide == west) then {
        player setUnitLoadout "B_Soldier_F"; } else { 


        player setUnitLoadout "O_Soldier_F"; };



    [true] call Tvtcf_Client_Statics_ClientState_SetPlayerIsAlive;


    ([Tvtcf_Client_Statics_ClientObjects_ExtractionSymbolHandler, []] call cl_Tvtcf_Client_ExtractionSymbolHandler_DeleteSymbol); };



Tvtcf_Client_Statics_ClientEventReciever_OnMissionEnded = {  params ["_missionResult", "_isLastMission"]; 

    [true] call Tvtcf_Client_Statics_ClientState_SetPlayerIsAlive;
    ([Tvtcf_Client_Statics_ClientObjects_CameraHandler, []] call cl_Tvtcf_Client_CameraHandler_UpdateDeathCamera);


    ([Tvtcf_Client_Statics_ClientObjects_BriefingHandler, [_missionResult]] call compile ("_this call cl_" + ((Tvtcf_Client_Statics_ClientObjects_BriefingHandler select 0) select 0) + "_AddMissionResultToHistory"));


    call Tvtcf_Client_TvtcfActionMenuHandler_UpdateVisibleOptions;


    if (!_isLastMission && (Tvtcf_Common_Statics_CommonObjects_MissionParametersHandler select 3) > 0) then {
        ([Tvtcf_Client_Statics_ClientObjects_WaitingForMissionCounter, []] call compile ("_this call cl_" + ((Tvtcf_Client_Statics_ClientObjects_WaitingForMissionCounter select 0) select 0) + "_RunAsync")); };



    private _debriefingText = ([_missionResult, [playerSide]] call cl_Tvtcf_Common_MissionResult_ToDiaryText);
    _debriefingText = [_debriefingText, "<br />", "\n"] call Tvtcf_Common_Functions_StringReplace;
    private _debriefingDialog = ([[["Tvtcf_Client_DebriefingDialog",[]]], ["Mission Debriefing", _debriefingText]] call cl_Tvtcf_Client_DebriefingDialog_constructor);


    [_debriefingDialog] spawn {
        params ["_debriefingDialog"];
        sleep 3;
        ([_debriefingDialog, []] call cl_Tvtcf_Client_DebriefingDialog_ShowDialog); }; };




Tvtcf_Client_Statics_ClientEventReciever_OnCampaignEnded = {  params ["_westAccumulatedScore", "_eastAccumulatedScore"]; 
    ([Tvtcf_Client_Statics_ClientObjects_WaitingForMissionCounter, []] call compile ("_this call cl_" + ((Tvtcf_Client_Statics_ClientObjects_WaitingForMissionCounter select 0) select 0) + "_Cancel"));

    if (playerSide == west) then {
        private _campaignEndService = ([[["Tvtcf_Client_CampaignEndService",["Sqx.Services.Service", "Sqx.Services.IService"]]], [_westAccumulatedScore >= _eastAccumulatedScore]] call cl_Tvtcf_Client_CampaignEndService_constructor);
        ([_campaignEndService, []] call compile ("_this call cl_" + ((_campaignEndService select 0) select 0) + "_RunAsync")); } else { 


        private _campaignEndService = ([[["Tvtcf_Client_CampaignEndService",["Sqx.Services.Service", "Sqx.Services.IService"]]], [_eastAccumulatedScore >= _westAccumulatedScore]] call cl_Tvtcf_Client_CampaignEndService_constructor);
        ([_campaignEndService, []] call compile ("_this call cl_" + ((_campaignEndService select 0) select 0) + "_RunAsync")); }; };




Tvtcf_Client_Statics_ClientEventReciever_OnUnitKilled = {  params ["_playerUid", "_unit", "_killer"]; 


    if (_playerUid != getPlayerUID player) then {

        ([Tvtcf_Client_Statics_ClientObjects_CameraHandler, []] call cl_Tvtcf_Client_CameraHandler_UpdateDeathCamera); }; };




Tvtcf_Client_Statics_ClientEventReciever_OnShowNotification = {  params ["_side", "_text"]; 
    if (_side == playerSide) then {
        ([Tvtcf_Client_Statics_ClientObjects_TaskHandler, [_text]] call cl_Tvtcf_Client_TaskHandler_ShowNotification); }; };




Tvtcf_Client_Statics_ClientEventReciever_OnAddAction = {  params ["_serverActionId", "_object", "_title", "_side"]; 
    if (_side == playerSide) then {
        ([Tvtcf_Client_Statics_ClientObjects_ClientMissionActionHandler, [_serverActionId, _object, _title]] call cl_Tvtcf_Client_ClientMissionActionHandler_AddAction); }; };




Tvtcf_Client_Statics_ClientEventReciever_OnDeleteActions = {  params ["_actionIds"]; 
    ([Tvtcf_Client_Statics_ClientObjects_ClientMissionActionHandler, [_actionIds]] call cl_Tvtcf_Client_ClientMissionActionHandler_DeleteActions); };



Tvtcf_Client_Statics_ClientEventReciever_OnForceNextMission = { 
    ([Tvtcf_Client_Statics_ClientObjects_WaitingForMissionCounter, []] call compile ("_this call cl_" + ((Tvtcf_Client_Statics_ClientObjects_WaitingForMissionCounter select 0) select 0) + "_Cancel")); };