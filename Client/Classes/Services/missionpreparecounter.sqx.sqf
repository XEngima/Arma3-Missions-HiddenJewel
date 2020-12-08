














cl_Tvtcf_Client_MissionPrepareCounter_IsRunning_PropIndex = 2; cl_Tvtcf_Client_MissionPrepareCounter_IsCancelling_PropIndex = 3; cl_Tvtcf_Client_MissionPrepareCounter_RunAsync = { _this call cl_Sqx_Services_Service_RunAsync }; cl_Tvtcf_Client_MissionPrepareCounter_Cancel = { _this call cl_Sqx_Services_Service_Cancel };




cl_Tvtcf_Client_MissionPrepareCounter_constructor = { params ["_class_fields", "_this"]; params ["_clientMessageHandler", "_insertionTime"]; 

    ([_class_fields, []] call cl_Sqx_Services_Service_Constructor);

    _class_fields set [4, _clientMessageHandler];
    _class_fields set [5, _insertionTime]; _class_fields };



cl_Tvtcf_Client_MissionPrepareCounter_Run = { params ["_class_fields", "_this"];
    private _time = call Tvtcf_Common_Functions_GetMissionTime;
    private _hasWaited = false;
    private _seconds = 0;

    while { _time < (_class_fields select 5) } do {

        private _timeLeft = ceil ((_class_fields select 5) - (call Tvtcf_Common_Functions_GetMissionTime));

        if (_seconds >= 10) then {
            ([(_class_fields select 4), ["Insertion allowed in " + str _timeLeft + " seconds."]] call cl_Tvtcf_Client_ClientMessageHandler_ShowSubTitle); };


        sleep 1;

        _time = call Tvtcf_Common_Functions_GetMissionTime;

        _hasWaited = true;
        _seconds = _seconds + 1; };


    if (_hasWaited) then {
        ([(_class_fields select 4), ["Insertion allowed!"]] call cl_Tvtcf_Client_ClientMessageHandler_ShowSubTitle); };


    ([_class_fields, []] call cl_Sqx_Services_Service_Run); };