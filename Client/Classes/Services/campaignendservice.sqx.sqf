













cl_Tvtcf_Client_CampaignEndService_IsRunning_PropIndex = 2; cl_Tvtcf_Client_CampaignEndService_IsCancelling_PropIndex = 3; cl_Tvtcf_Client_CampaignEndService_RunAsync = { _this call cl_Sqx_Services_Service_RunAsync }; cl_Tvtcf_Client_CampaignEndService_Cancel = { _this call cl_Sqx_Services_Service_Cancel };



cl_Tvtcf_Client_CampaignEndService_constructor = { params ["_class_fields", "_this"]; params ["_isVictory"]; 

    ([_class_fields, []] call cl_Sqx_Services_Service_Constructor);
    _class_fields set [4, _isVictory]; _class_fields };



cl_Tvtcf_Client_CampaignEndService_Run = { params ["_class_fields", "_this"];
    cutText ["", "BLACK IN", 1];

    private _i = 60;

    while { _i >= 0 } do {
        private _text = "CAMPAIGN VICTORY! ";

        if (!(_class_fields select 4)) then {
            _text = "CAMPAIGN DEFEAT! "; };


        hint (_text + str _i);

        sleep 1;
        _i = _i - 1; };


    ["END1", (_class_fields select 4)] spawn BIS_fnc_endMission;

    ([_class_fields, []] call cl_Sqx_Services_Service_Run); };