













cl_Tvtcf_Client_WaitingForMissionCounter_IsRunning_PropIndex = 2; cl_Tvtcf_Client_WaitingForMissionCounter_IsCancelling_PropIndex = 3; cl_Tvtcf_Client_WaitingForMissionCounter_RunAsync = { _this call cl_Sqx_Services_Service_RunAsync }; cl_Tvtcf_Client_WaitingForMissionCounter_Cancel = { _this call cl_Sqx_Services_Service_Cancel };




cl_Tvtcf_Client_WaitingForMissionCounter_constructor = { params ["_class_fields", "_this"]; params ["_timeBetweenMissions"]; 

    ([_class_fields, []] call cl_Sqx_Services_Service_Constructor);
    _class_fields set [4, _timeBetweenMissions];
    _class_fields set [5, _timeBetweenMissions]; _class_fields };



cl_Tvtcf_Client_WaitingForMissionCounter_SetRemainingTime = { params ["_class_fields", "_this"]; params ["_remainingTime"]; 
    _class_fields set [5, floor _remainingTime]; };



cl_Tvtcf_Client_WaitingForMissionCounter_Run = { params ["_class_fields", "_this"];
    sleep 1;

    _class_fields set [5, (_class_fields select 5) - 1];

    cutText ["", "BLACK IN", 1];
    private _isBlack = false;

    while { (_class_fields select 5) >= 0 && !(_class_fields select 3) } do {

        hint ("Next mission starts in " + (str (_class_fields select 5)) + " seconds.");

        if ((_class_fields select 5) == 2) then {
            cutText ["", "BLACK OUT", 1];
            _isBlack = true; };


        _class_fields set [5, (_class_fields select 5) - 1];
        sleep 1; };


    if (!_isBlack) then {
        cutText ["", "BLACK OUT", 1];
        _isBlack = true; };


    _class_fields set [5, (_class_fields select 4)];
    ([_class_fields, []] call cl_Sqx_Services_Service_Run); };