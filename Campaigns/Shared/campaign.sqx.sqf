
















cl_Campaigns_Campaign_constructor = { params ["_class_fields", "_this"];

    private _missions = [];

    _class_fields set [4, []];
    _class_fields set [6, []];
    _class_fields set [5, []];
    _class_fields set [7, []];

    ([_class_fields, [_missions]] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_SelectMissions"));

    _class_fields set [3, _missions];
    _class_fields set [2, -1]; _class_fields };






cl_Campaigns_Campaign_SetCampaignMode = { params ["_class_fields", "_this"]; params ["_mode"]; 
    _class_fields set [1, _mode];

    if (_mode == 2) then {

        [(_class_fields select 3)] call Tvtcf_Common_Functions_ShuffleArray;

        {
            ([_x, [selectRandom [west, east]]] call cl_Campaigns_Mission_SetActingSide);
        } forEach (_class_fields select 3); }; };










cl_Campaigns_Campaign_SelectMissions = { params ["_class_fields", "_this"]; params ["_missions"]; };



cl_Campaigns_Campaign_CampaignMode_PropIndex = 1;


cl_Campaigns_Campaign_CurrentMissionIndex_PropIndex = 2;


cl_Campaigns_Campaign_Missions_PropIndex = 3;


cl_Campaigns_Campaign_GainedTokensWest_PropIndex = 4;


cl_Campaigns_Campaign_GainedTokensEast_PropIndex = 5;


cl_Campaigns_Campaign_LostTokensWest_PropIndex = 6;


cl_Campaigns_Campaign_LostTokensEast_PropIndex = 7;





cl_Campaigns_Campaign_GetNextMissionToPlay = { params ["_class_fields", "_this"]; scopeName "GetNextMissionToPlay";
    if ((_class_fields select 1) == 1) then {
        (([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_GetNextMission"))) breakOut "GetNextMissionToPlay"; } else { 



        _class_fields set [2, (_class_fields select 2) + 1];

        if ((_class_fields select 2) < count (_class_fields select 3)) then {
            ((_class_fields select 3) select (_class_fields select 2)) breakOut "GetNextMissionToPlay"; };


        (["null"]) breakOut "GetNextMissionToPlay"; };


    (["null"]) breakOut "GetNextMissionToPlay"; };






cl_Campaigns_Campaign_GetNextMission = { params ["_class_fields", "_this"]; scopeName "GetNextMission";
    _class_fields set [2, (_class_fields select 2) + 1];

    if ((_class_fields select 2) < count (_class_fields select 3)) then {
        ((_class_fields select 3) select (_class_fields select 2)) breakOut "GetNextMission"; };


    (["null"]) breakOut "GetNextMission"; };