















cl_Tvtcf_Client_TvtcfActionMenuHandler_constructor = { _this select 0 };





Tvtcf_Client_TvtcfActionMenuHandler_Init = { 
    Tvtcf_Client_TvtcfActionMenuHandler__mMissionMenuActionId = -1;
    Tvtcf_Client_TvtcfActionMenuHandler__player = objNull;
    Tvtcf_Client_TvtcfActionMenuHandler_OptionPerformInsertionVisible = false;
    call Tvtcf_Client_TvtcfActionMenuHandler_UpdateVisibleOptions; };



Tvtcf_Client_TvtcfActionMenuHandler_ShowAction = { 
    if (!isNull Tvtcf_Client_TvtcfActionMenuHandler__player) then {
        call Tvtcf_Client_TvtcfActionMenuHandler_HideAction; };


    if (Tvtcf_Client_TvtcfActionMenuHandler__mMissionMenuActionId < 0 || isNull Tvtcf_Client_TvtcfActionMenuHandler__player || { Tvtcf_Client_TvtcfActionMenuHandler__player != player }) then {

        Tvtcf_Client_TvtcfActionMenuHandler__mMissionMenuActionId = player addAction ["<t color='#AAAAFF'>Open Mission Menu</t>", { call Tvtcf_Client_TvtcfActionMenuHandler_Open; }, nil, 100, false];
        Tvtcf_Client_TvtcfActionMenuHandler__player = player; }; };




Tvtcf_Client_TvtcfActionMenuHandler_HideAction = { 
    if (Tvtcf_Client_TvtcfActionMenuHandler__mMissionMenuActionId >= 0 && !isNull Tvtcf_Client_TvtcfActionMenuHandler__player) then {
        Tvtcf_Client_TvtcfActionMenuHandler__player removeAction Tvtcf_Client_TvtcfActionMenuHandler__mMissionMenuActionId;
        Tvtcf_Client_TvtcfActionMenuHandler__mMissionMenuActionId = -1;
        Tvtcf_Client_TvtcfActionMenuHandler__player = objNull; }; };
















Tvtcf_Client_TvtcfActionMenuHandler_ShowOptionPerformInsertion = {  params ["_show"]; 
    if (_show != Tvtcf_Client_TvtcfActionMenuHandler_OptionPerformInsertionVisible) then {
        Tvtcf_Client_TvtcfActionMenuHandler_OptionPerformInsertionVisible = _show;
        call Tvtcf_Client_TvtcfActionMenuHandler_BuildCampaignMenu; }; };




Tvtcf_Client_TvtcfActionMenuHandler_ShowOptionEndMission = {  params ["_show"]; 
    if (_show != Tvtcf_Client_TvtcfActionMenuHandler_OptionEndMissionVisible) then {
        Tvtcf_Client_TvtcfActionMenuHandler_OptionEndMissionVisible = _show;
        call Tvtcf_Client_TvtcfActionMenuHandler_BuildCampaignMenu; }; };




Tvtcf_Client_TvtcfActionMenuHandler_ShowOptionForceNextMission = {  params ["_show"]; 
    if (_show != Tvtcf_Client_TvtcfActionMenuHandler_OptionForceNextMissionVisible) then {
        Tvtcf_Client_TvtcfActionMenuHandler_OptionForceNextMissionVisible = _show;
        call Tvtcf_Client_TvtcfActionMenuHandler_BuildCampaignMenu; }; };








Tvtcf_Client_TvtcfActionMenuHandler_UpdateVisibleOptions = { 


    private _playerGroupHasInserted = false;

    if (playerSide == west) then {
        _playerGroupHasInserted = call Tvtcf_Communication_PublicVariableHandler_GetWestHasInserted; } else { 


        _playerGroupHasInserted = call Tvtcf_Communication_PublicVariableHandler_GetEastHasInserted; };


    private _missionHasStarted = call Tvtcf_Communication_PublicVariableHandler_GetMissionHasStarted;
    Tvtcf_Client_TvtcfActionMenuHandler_OptionPerformInsertionVisible = (_missionHasStarted) && !_playerGroupHasInserted;



    Tvtcf_Client_TvtcfActionMenuHandler_OptionEndMissionVisible = 
    _missionHasStarted && (Tvtcf_Common_Statics_CommonObjects_MissionParametersHandler select 1)
    &&
    ((call BIS_fnc_admin) > 0 || isServer);;



    Tvtcf_Client_TvtcfActionMenuHandler_OptionForceNextMissionVisible = 
    !_missionHasStarted && (Tvtcf_Common_Statics_CommonObjects_MissionParametersHandler select 1)
    &&
    ((call BIS_fnc_admin) > 0 || isServer);;

    call Tvtcf_Client_TvtcfActionMenuHandler_BuildCampaignMenu; };



Tvtcf_Client_TvtcfActionMenuHandler_BuildCampaignMenu = { 
    TVTCF_TvtcfMenu = 
    [
    ["Mission Menu", true]];


    if (Tvtcf_Client_TvtcfActionMenuHandler_OptionPerformInsertionVisible) then {
        TVTCF_TvtcfMenu pushBack ["Perform Insertion", [0], "", -5, [["expression", "call Tvtcf_Client_TvtcfActionMenuHandler_OnPerformInsertion"]], "1", "1"]; };


    if (Tvtcf_Client_TvtcfActionMenuHandler_OptionEndMissionVisible) then {
        TVTCF_TvtcfMenu pushBack ["End Mission", [0], "", -5, [["expression", "call Tvtcf_Client_TvtcfActionMenuHandler_OnEndMission"]], "1", "1"]; };


    if (Tvtcf_Client_TvtcfActionMenuHandler_OptionForceNextMissionVisible) then {
        TVTCF_TvtcfMenu pushBack ["Play Next Mission", [0], "", -5, [["expression", "call Tvtcf_Client_TvtcfActionMenuHandler_OnForceNextMission"]], "1", "1"]; };




    if (!Tvtcf_Client_TvtcfActionMenuHandler_OptionPerformInsertionVisible && !Tvtcf_Client_TvtcfActionMenuHandler_OptionEndMissionVisible && !Tvtcf_Client_TvtcfActionMenuHandler_OptionForceNextMissionVisible) then {
        call Tvtcf_Client_TvtcfActionMenuHandler_HideAction; } else { 


        call Tvtcf_Client_TvtcfActionMenuHandler_ShowAction; }; };





Tvtcf_Client_TvtcfActionMenuHandler_Open = { 
    showCommandingMenu "#USER:TVTCF_TvtcfMenu"; };








Tvtcf_Client_TvtcfActionMenuHandler_OnPerformInsertion = { 
    private ["_missionMarkersInfo"];

    if (call Tvtcf_Communication_PublicVariableHandler_HasValueMissionMarkersInfo) then {

        _missionMarkersInfo = call Tvtcf_Communication_PublicVariableHandler_GetMissionMarkersInfo;

        ([Tvtcf_Client_Statics_ClientObjects_PerformInsertionService, [([_missionMarkersInfo, [playerSide]] call cl_Tvtcf_Common_MissionMarkersInfo_GetStartMarkersBySide)]] call cl_Tvtcf_Client_PerformInsertionService_Reset);

        ([Tvtcf_Client_Statics_ClientObjects_PerformInsertionService, []] call compile ("_this call cl_" + ((Tvtcf_Client_Statics_ClientObjects_PerformInsertionService select 0) select 0) + "_RunAsync")); }; };





Tvtcf_Client_TvtcfActionMenuHandler_OnEndMission = { 
    ["ServerEventReciever.OnEndMission", []] call Tvtcf_Communication_Remote_Invoke; };




Tvtcf_Client_TvtcfActionMenuHandler_OnForceNextMission = { 
    ["ServerEventReciever.OnForceNextMission", []] call Tvtcf_Communication_Remote_Invoke; };