

















cl_Tvtcf_Client_JipService_IsRunning_PropIndex = 2; cl_Tvtcf_Client_JipService_IsCancelling_PropIndex = 3; cl_Tvtcf_Client_JipService_RunAsync = { _this call cl_Sqx_Services_Service_RunAsync }; cl_Tvtcf_Client_JipService_Cancel = { _this call cl_Sqx_Services_Service_Cancel };



cl_Tvtcf_Client_JipService_constructor = { params ["_class_fields", "_this"]; params ["_clientMessageHandler"]; 

    ([_class_fields, []] call cl_Sqx_Services_Service_Constructor);
    _class_fields set [4, _clientMessageHandler]; _class_fields };



cl_Tvtcf_Client_JipService_Run = { params ["_class_fields", "_this"];
    private ["_missionMarkersInfo"];
    private ["_briefingService", "_missionBriefing"];
    private ["_missionPrepareCounter"];

    waitUntil { player == player };



    _missionMarkersInfo = call Tvtcf_Communication_PublicVariableHandler_GetMissionMarkersInfo;
    if (!(_missionMarkersInfo isEqualTo ["null"])) then {
        ([Tvtcf_Client_Statics_ClientObjects_MapMarkerHandler, [_missionMarkersInfo]] call cl_Tvtcf_Client_MapMarkerHandler_UpdateMarkers); };




    _missionBriefing = call Tvtcf_Communication_PublicVariableHandler_GetMissionBriefing;
    if (!(_missionBriefing isEqualTo ["null"])) then {
        private _objectiveStates = call Tvtcf_Communication_PublicVariableHandler_GetObjectiveChangeCollection;
        _briefingService = ([[["Tvtcf_Client_MissionBriefingService",["Sqx.Services.Service", "Sqx.Services.IService"]]], [_missionBriefing, Tvtcf_Client_Statics_ClientObjects_BriefingHandler, Tvtcf_Client_Statics_ClientObjects_TaskHandler, _objectiveStates, true]] call cl_Tvtcf_Client_MissionBriefingService_constructor);
        ([_briefingService, []] call compile ("_this call cl_" + ((_briefingService select 0) select 0) + "_RunAsync")); };




    private _missionResultArray = call Tvtcf_Communication_PublicVariableHandler_GetMissionResultArray;

    {
        ([Tvtcf_Client_Statics_ClientObjects_BriefingHandler, [_x]] call compile ("_this call cl_" + ((Tvtcf_Client_Statics_ClientObjects_BriefingHandler select 0) select 0) + "_AddMissionResultToHistory"));
    } forEach _missionResultArray;



    private _missionHasStarted = call Tvtcf_Communication_PublicVariableHandler_GetMissionHasStarted;
    private _nextMissionStartTime = call Tvtcf_Communication_PublicVariableHandler_GetNextMissionStartTime;
    private _remainingTime = floor (_nextMissionStartTime - (call Tvtcf_Common_Functions_GetMissionTime));

    if (!_missionHasStarted && _remainingTime > 0) then {

        ([Tvtcf_Client_Statics_ClientObjects_WaitingForMissionCounter, [_remainingTime]] call cl_Tvtcf_Client_WaitingForMissionCounter_SetRemainingTime);
        ([Tvtcf_Client_Statics_ClientObjects_WaitingForMissionCounter, []] call compile ("_this call cl_" + ((Tvtcf_Client_Statics_ClientObjects_WaitingForMissionCounter select 0) select 0) + "_RunAsync")); };




    if (!(_missionMarkersInfo isEqualTo ["null"])) then {

        private _startMarkers = ([_missionMarkersInfo, [playerSide]] call cl_Tvtcf_Common_MissionMarkersInfo_GetStartMarkersBySide);



        if (count _startMarkers > 0) then {



            private _hasInserted = false;

            if (playerSide == west) then {
                _hasInserted = call Tvtcf_Communication_PublicVariableHandler_GetWestHasInserted; };

            if (playerSide == east) then {
                _hasInserted = call Tvtcf_Communication_PublicVariableHandler_GetEastHasInserted; };


            if (!_hasInserted) then {
                ([Tvtcf_Client_Statics_ClientObjects_BaseInsertionService, []] call compile ("_this call cl_" + ((Tvtcf_Client_Statics_ClientObjects_BaseInsertionService select 0) select 0) + "_RunAsync")); };




            private _briefingEndTime = call Tvtcf_Communication_PublicVariableHandler_GetBriefingEndTime;
            _missionPrepareCounter = ([[["Tvtcf_Client_MissionPrepareCounter",["Sqx.Services.Service", "Sqx.Services.IService"]]], [(_class_fields select 4), _briefingEndTime + (Tvtcf_Common_Statics_CommonObjects_MissionParametersHandler select 2)]] call cl_Tvtcf_Client_MissionPrepareCounter_constructor);
            ([_missionPrepareCounter, []] call compile ("_this call cl_" + ((_missionPrepareCounter select 0) select 0) + "_RunAsync")); };





        private _extractionPos = [];
        private _useExtractionMarker = false;

        if (playerSide == west) then {
            _extractionPos = call Tvtcf_Communication_PublicVariableHandler_GetWestInsertionPos;
            _useExtractionMarker = (_missionMarkersInfo select 3); };

        if (playerSide == east) then {
            _extractionPos = call Tvtcf_Communication_PublicVariableHandler_GetEastInsertionPos;
            _useExtractionMarker = (_missionMarkersInfo select 4); };


        if (_useExtractionMarker) then {
            ([Tvtcf_Client_Statics_ClientObjects_MapMarkerHandler, [_extractionPos]] call cl_Tvtcf_Client_MapMarkerHandler_AddInsertionMarker);
            ([Tvtcf_Client_Statics_ClientObjects_ExtractionSymbolHandler, [_extractionPos]] call cl_Tvtcf_Client_ExtractionSymbolHandler_CreateSymbol); }; };





    sleep 1;
    ([Tvtcf_Client_Statics_ClientObjects_CameraHandler, []] call cl_Tvtcf_Client_CameraHandler_UpdateDeathCamera);
    sleep 0.5;

    cutText ["", "BLACK IN", 1];

    ([_class_fields, []] call cl_Sqx_Services_Service_Run);



    call Tvtcf_Client_TvtcfActionMenuHandler_UpdateVisibleOptions; };