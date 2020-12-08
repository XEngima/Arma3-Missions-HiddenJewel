













cl_Tvtcf_Common_MissionParametersHandler_constructor = { params ["_class_fields", "_this"];

    ([_class_fields, []] call cl_Tvtcf_Common_MissionParametersHandler_SetDefaultValuesIfSinglePlayer);

    _class_fields set [1, (paramsArray select 0) == 1];
    _class_fields set [2, (paramsArray select 1)];
    _class_fields set [3, (paramsArray select 2)];
    _class_fields set [4, (paramsArray select 3)];
    _class_fields set [5, (paramsArray select 4)];
    _class_fields set [6, (paramsArray select 5)];
    _class_fields set [7, (paramsArray select 6)]; _class_fields };


cl_Tvtcf_Common_MissionParametersHandler_EnableServerAdminOptions_PropIndex = 1;

cl_Tvtcf_Common_MissionParametersHandler_MandatoryPrepareTime_PropIndex = 2;

cl_Tvtcf_Common_MissionParametersHandler_TimeBetweenMissions_PropIndex = 3;

cl_Tvtcf_Common_MissionParametersHandler_CampaignLimitTime_PropIndex = 4;

cl_Tvtcf_Common_MissionParametersHandler_CampaignMode_PropIndex = 5;

cl_Tvtcf_Common_MissionParametersHandler_AiWestFrequency_PropIndex = 6;

cl_Tvtcf_Common_MissionParametersHandler_AiEastFrequency_PropIndex = 7;


cl_Tvtcf_Common_MissionParametersHandler_SetDefaultValuesIfSinglePlayer = { params ["_class_fields", "_this"];
    if (isNil "paramsArray") then {

        private ["_c", "_i", "_paramName"];

        paramsArray = [];

        if (isClass (missionConfigFile / "Params")) then {

            _c = count (missionConfigFile / "Params");

            for [{ _i = 0 }, { _i < _c }, { _i = _i + 1 }] do {

                _paramName = configName ((missionConfigFile >> "Params") select _i);
                paramsArray = paramsArray + [getNumber (missionConfigFile >> "Params" >> _paramName >> "default")]; }; };



        _c = count paramsArray;

        if (isNil "param1" && _c > 0) then {
            param1 = paramsArray select 0; };


        if (isNil "param2" && _c > 1) then {
            param2 = paramsArray select 1; }; }; };