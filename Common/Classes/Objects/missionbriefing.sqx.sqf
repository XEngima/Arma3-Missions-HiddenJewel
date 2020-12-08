













cl_Tvtcf_Common_MissionBriefing_constructor = { params ["_class_fields", "_this"]; params ["_missionName", "_westBriefingInfo", "_westPrimaryObjective", "_westSecondaryObjective", "_westReturnObjective", "_eastBriefingInfo", "_eastPrimaryObjective", "_eastSecondaryObjective", "_eastReturnObjective"]; 

    _class_fields set [1, _missionName];
    _class_fields set [2, _westBriefingInfo];
    _class_fields set [6, _eastBriefingInfo];
    _class_fields set [3, _westPrimaryObjective];
    _class_fields set [5, _westReturnObjective];
    _class_fields set [4, _westSecondaryObjective];
    _class_fields set [7, _eastPrimaryObjective];
    _class_fields set [8, _eastSecondaryObjective];
    _class_fields set [9, _eastReturnObjective]; _class_fields };


cl_Tvtcf_Common_MissionBriefing_MissionName_PropIndex = 1;

cl_Tvtcf_Common_MissionBriefing_BriefingInfoWest_PropIndex = 2;

cl_Tvtcf_Common_MissionBriefing_PrimaryObjectiveWest_PropIndex = 3;

cl_Tvtcf_Common_MissionBriefing_SecondaryObjectiveWest_PropIndex = 4;

cl_Tvtcf_Common_MissionBriefing_ReturnObjectiveWest_PropIndex = 5;

cl_Tvtcf_Common_MissionBriefing_BriefingInfoEast_PropIndex = 6;

cl_Tvtcf_Common_MissionBriefing_PrimaryObjectiveEast_PropIndex = 7;

cl_Tvtcf_Common_MissionBriefing_SecondaryObjectiveEast_PropIndex = 8;

cl_Tvtcf_Common_MissionBriefing_ReturnObjectiveEast_PropIndex = 9;


cl_Tvtcf_Common_MissionBriefing_GetBriefingInfo = { params ["_class_fields", "_this"]; params ["_side"]; scopeName "GetBriefingInfo";
    if (_side == west) then {
        ((_class_fields select 2)) breakOut "GetBriefingInfo"; };


    ((_class_fields select 6)) breakOut "GetBriefingInfo"; };



cl_Tvtcf_Common_MissionBriefing_GetObjective = { params ["_class_fields", "_this"]; params ["_side", "_prio"]; scopeName "GetObjective";
    if (_side == west) then {
        if (_prio == 1) then {
            ((_class_fields select 3)) breakOut "GetObjective"; };

        if (_prio == 2) then {
            ((_class_fields select 4)) breakOut "GetObjective"; };

        if (_prio == 3) then {
            ((_class_fields select 5)) breakOut "GetObjective"; }; };



    if (_side == east) then {
        if (_prio == 1) then {
            ((_class_fields select 7)) breakOut "GetObjective"; };

        if (_prio == 2) then {
            ((_class_fields select 8)) breakOut "GetObjective"; };

        if (_prio == 3) then {
            ((_class_fields select 9)) breakOut "GetObjective"; }; };



    (["null"]) breakOut "GetObjective"; };