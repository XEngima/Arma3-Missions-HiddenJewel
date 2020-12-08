















cl_Tvtcf_Client_BaseInsertionService_IsRunning_PropIndex = 2; cl_Tvtcf_Client_BaseInsertionService_IsCancelling_PropIndex = 3; cl_Tvtcf_Client_BaseInsertionService_RunAsync = { _this call cl_Sqx_Services_Service_RunAsync }; cl_Tvtcf_Client_BaseInsertionService_Cancel = { _this call cl_Sqx_Services_Service_Cancel };



cl_Tvtcf_Client_BaseInsertionService_constructor = { params ["_class_fields", "_this"]; params ["_baseMarkersConfig"]; 

    ([_class_fields, []] call cl_Sqx_Services_Service_Constructor);
    _class_fields set [4, _baseMarkersConfig]; _class_fields };



cl_Tvtcf_Client_BaseInsertionService_Run = { params ["_class_fields", "_this"];
    while { !(_class_fields select 3) } do {

        private _respawnMarker = ([(_class_fields select 4), [playerSide, 1]] call compile ("_this call cl_" + (((_class_fields select 4) select 0) select 0) + "_GetMarkerName"));
        private _basePos = getMarkerPos _respawnMarker;

        if (player distance2D _basePos > 300) then {
            ["ServerEventReciever.OnPlayerPerformingInsertion", [playerSide, _basePos, false]] call Tvtcf_Communication_Remote_Invoke;
            ([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_Cancel")); };


        sleep 0.2; };


    ([_class_fields, []] call cl_Sqx_Services_Service_Run); };