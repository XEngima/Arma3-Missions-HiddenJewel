

















cl_Tvtcf_Client_BriefingHandler_constructor = { params ["_class_fields", "_this"];

    _class_fields set [1, []]; _class_fields };




cl_Tvtcf_Client_BriefingHandler_CreateBriefing = { params ["_class_fields", "_this"]; params ["_missionName", "_briefingInfo"]; 
    {
        player removeDiaryRecord ["Diary", _x];
    } forEach (_class_fields select 1);

    _class_fields set [1, []];

    private _diaryRecord = player createDiaryRecord ["Diary", [_missionName, _briefingInfo]];
    (_class_fields select 1) pushBack _diaryRecord; };



cl_Tvtcf_Client_BriefingHandler_CreateWelcomeBriefing = { params ["_class_fields", "_this"]; params ["_welcomeText"]; 
    player createDiarySubject ["Welcome", "Welcome"];

    player createDiaryRecord ["Welcome", ["Welcome", _welcomeText]]; };



cl_Tvtcf_Client_BriefingHandler_AddMissionResultToHistory = { params ["_class_fields", "_this"]; params ["_missionResult"]; 
    if (!(player diarySubjectExists "Results")) then {
        player createDiarySubject ["Results", "Mission Results"]; };


    private _diaryText = ([_missionResult, [playerSide]] call cl_Tvtcf_Common_MissionResult_ToDiaryText);

    player createDiaryRecord ["Results", [(_missionResult select 1), _diaryText]]; };