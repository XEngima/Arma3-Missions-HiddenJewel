













cl_Tvtcf_Common_MissionResult_constructor = { params ["_class_fields", "_this"]; params ["_missionName", "_resultInfoWest", "_resultInfoEast", "_totalScoreWest", "_totalScoreEast"]; 

    _class_fields set [1, _missionName];
    _class_fields set [2, _resultInfoWest];
    _class_fields set [3, _resultInfoEast];
    _class_fields set [4, _totalScoreWest];
    _class_fields set [5, _totalScoreEast]; _class_fields };


cl_Tvtcf_Common_MissionResult_MissionName_PropIndex = 1;

cl_Tvtcf_Common_MissionResult_ResultInfoWest_PropIndex = 2;

cl_Tvtcf_Common_MissionResult_ResultInfoEast_PropIndex = 3;

cl_Tvtcf_Common_MissionResult_TotalScoreWest_PropIndex = 4;

cl_Tvtcf_Common_MissionResult_TotalScoreEast_PropIndex = 5;


cl_Tvtcf_Common_MissionResult_GetResultInfo = { params ["_class_fields", "_this"]; params ["_side"]; scopeName "GetResultInfo";
    if (_side == west) then {
        ((_class_fields select 2)) breakOut "GetResultInfo"; };


    ((_class_fields select 3)) breakOut "GetResultInfo"; };



cl_Tvtcf_Common_MissionResult_ToDiaryText = { params ["_class_fields", "_this"]; params ["_side"]; scopeName "ToDiaryText";
    private _resultInfo = ([_class_fields, [_side]] call cl_Tvtcf_Common_MissionResult_GetResultInfo);

    private _diaryText = (_class_fields select 1) + "<br />";
    _diaryText = _diaryText + "<br />" + (_resultInfo select 6) + ": ";
    _diaryText = _diaryText + ([(_resultInfo select 7)] call Tvtcf_Common_ObjectiveStateMeta_ToLang);

    if ((_resultInfo select 7) == 4) then {
        _diaryText = _diaryText + " (+" + str (_resultInfo select 1) + ")"; };


    if ((_resultInfo select 8) != "") then {

        _diaryText = _diaryText + "<br />" + (_resultInfo select 8) + ": ";
        _diaryText = _diaryText + ([(_resultInfo select 9)] call Tvtcf_Common_ObjectiveStateMeta_ToLang);

        if ((_resultInfo select 9) == 4) then {
            _diaryText = _diaryText + " (+" + str (_resultInfo select 2) + ")"; }; };



    if ((_resultInfo select 10)) then {

        _diaryText = _diaryText + "<br />Return to insertion point: ";
        _diaryText = _diaryText + ([(_resultInfo select 11)] call Tvtcf_Common_ObjectiveStateMeta_ToLang);

        if ((_resultInfo select 11) == 4) then {
            _diaryText = _diaryText + " (+" + str (_resultInfo select 3) + ")"; }; };



    private _menLostCount = (_resultInfo select 12) - (_resultInfo select 13);
    _diaryText = _diaryText + "<br />Men lost: " + str _menLostCount;

    if (_menLostCount > 0) then {
        _diaryText = _diaryText + " (" + str _menLostCount + " x -" + str (_resultInfo select 5) + " = " + str (-_menLostCount * (_resultInfo select 5)) + ")"; } else { 


        if ((_resultInfo select 14) > 0) then {
            _diaryText = _diaryText + " (Bonus for success and all survived: +" + str (_resultInfo select 4) + ")"; }; };



    _diaryText = _diaryText + "<br /><br />Mission score: " + str (_resultInfo select 14);

    _diaryText = _diaryText + "<br /><br />Total score";
    _diaryText = _diaryText + "<br />West: " + str (_class_fields select 4) + ". East: " + str (_class_fields select 5) + ".";

    (_diaryText) breakOut "ToDiaryText"; };