

















cl_Tvtcf_Client_PerformInsertionService_IsRunning_PropIndex = 2; cl_Tvtcf_Client_PerformInsertionService_IsCancelling_PropIndex = 3; cl_Tvtcf_Client_PerformInsertionService_RunAsync = { _this call cl_Sqx_Services_Service_RunAsync }; cl_Tvtcf_Client_PerformInsertionService_Cancel = { _this call cl_Sqx_Services_Service_Cancel };




cl_Tvtcf_Client_PerformInsertionService_constructor = { params ["_class_fields", "_this"]; params ["_messageHandler", "_mapMarkerHandler"]; 

    ([_class_fields, []] call cl_Sqx_Services_Service_Constructor);
    _class_fields set [7, _messageHandler];
    _class_fields set [8, _mapMarkerHandler]; _class_fields };



cl_Tvtcf_Client_PerformInsertionService_Reset = { params ["_class_fields", "_this"]; params ["_insertionMarkers"]; 
    _class_fields set [4, true];
    _class_fields set [5, []];
    _class_fields set [6, _insertionMarkers]; };



cl_Tvtcf_Client_PerformInsertionService_SendMapClick = { params ["_class_fields", "_this"]; params ["_position"]; 
    _class_fields set [5, _position];
    _class_fields set [4, false]; };



cl_Tvtcf_Client_PerformInsertionService_InAnyMarker = { params ["_class_fields", "_this"]; params ["_position", "_markers"]; scopeName "InAnyMarker";
    if (count _markers == 0) then {
        (true) breakOut "InAnyMarker"; };


    {
        if (_position inArea _x) then {
            (true) breakOut "InAnyMarker"; };
    } forEach 
    _markers;

    (false) breakOut "InAnyMarker"; };



cl_Tvtcf_Client_PerformInsertionService_Run = { params ["_class_fields", "_this"];
    private _briefingEndTime = call Tvtcf_Communication_PublicVariableHandler_GetBriefingEndTime;
    private _serverTime = call Tvtcf_Common_Functions_GetMissionTime;

    if (_serverTime < _briefingEndTime + (Tvtcf_Common_Statics_CommonObjects_MissionParametersHandler select 2)) then {
        ([(_class_fields select 7), ["Insertion is not yet allowed."]] call cl_Tvtcf_Client_ClientMessageHandler_ShowMessage); } else { 








        call Josef_Common_MapCtrl_OpenDefaultMap;
        private _bBox = [(_class_fields select 6)] call Josef_Common_MapCtrl_MarkersBoundingBox;
        [call Josef_Common_MapCtrl_DefaultMapControl, _bBox, 150, 500, 1.5, worldSize * 0.7] call Josef_Common_MapCtrl_MoveMapToRectangle;



        _class_fields set [4, true];

        titleText ["<t color='#111199' size='1.3' valign='bottom'><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />Select an insertion position in one of the insertion markers.</t>", "PLAIN", -1, true, true];


        private _clickedInside = false;

        while { !_clickedInside && visibleMap } do {

            waitUntil { !(_class_fields select 4) || !visibleMap };

            if (!(_class_fields select 4)) then {

                if (([_class_fields, [(_class_fields select 5), (_class_fields select 6)]] call cl_Tvtcf_Client_PerformInsertionService_InAnyMarker)) then {
                    ["ServerEventReciever.OnPlayerPerformingInsertion", [playerSide, (_class_fields select 5), true]] call Tvtcf_Communication_Remote_Invoke;
                    _clickedInside = true; } else { 


                    titleText ["<t color='#991111' size='1.3' valign='bottom'><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />Insertion must be inside one of the dark insertion markers. Please try again.</t>", "PLAIN", -1, true, true];

                    _class_fields set [4, true]; }; }; }; };





    titleFadeOut 1;
    ([_class_fields, []] call cl_Sqx_Services_Service_Run); };