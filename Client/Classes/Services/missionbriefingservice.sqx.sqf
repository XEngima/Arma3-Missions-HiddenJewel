














cl_Tvtcf_Client_MissionBriefingService_IsRunning_PropIndex = 2; cl_Tvtcf_Client_MissionBriefingService_IsCancelling_PropIndex = 3; cl_Tvtcf_Client_MissionBriefingService_RunAsync = { _this call cl_Sqx_Services_Service_RunAsync }; cl_Tvtcf_Client_MissionBriefingService_Cancel = { _this call cl_Sqx_Services_Service_Cancel };




cl_Tvtcf_Client_MissionBriefingService_constructor = { params ["_class_fields", "_this"]; params ["_missionBriefing", "_briefingHandler", "_taskHandler", "_objectiveChangeCollection", "_jip"]; 

    ([_class_fields, []] call cl_Sqx_Services_Service_Constructor);
    _class_fields set [4, _missionBriefing];
    _class_fields set [5, _briefingHandler];
    _class_fields set [6, _taskHandler];
    _class_fields set [7, _objectiveChangeCollection];
    _class_fields set [8, _jip]; _class_fields };



cl_Tvtcf_Client_MissionBriefingService_Run = { params ["_class_fields", "_this"];
    private ["_briefingInfo", "_primaryObjective", "_secondaryObjective", "_returnObjective"];

    if (!(_class_fields select 8)) then {
        sleep 1; };


    [((_class_fields select 4) select 1), str (date select 2) + "/" + str (date select 1) + "/" + str (date select 0) + " " + str (date select 3) + ":00"] spawn BIS_fnc_infoText;

    if (!(_class_fields select 8)) then {
        sleep 2;
        cutText ["", "BLACK IN", 1];
        sleep 1; };


    _briefingInfo = ([(_class_fields select 4), [playerSide]] call cl_Tvtcf_Common_MissionBriefing_GetBriefingInfo);
    _primaryObjective = ([(_class_fields select 4), [playerSide, 1]] call cl_Tvtcf_Common_MissionBriefing_GetObjective);
    _secondaryObjective = ([(_class_fields select 4), [playerSide, 2]] call cl_Tvtcf_Common_MissionBriefing_GetObjective);
    _returnObjective = ([(_class_fields select 4), [playerSide, 3]] call cl_Tvtcf_Common_MissionBriefing_GetObjective);

    if (_briefingInfo != "") then {
        ([(_class_fields select 5), [((_class_fields select 4) select 1), _briefingInfo]] call compile ("_this call cl_" + (((_class_fields select 5) select 0) select 0) + "_CreateBriefing")); };


    if (!(_primaryObjective isEqualTo ["null"])) then {
        ([(_class_fields select 6), [_primaryObjective, 1, !(_class_fields select 8)]] call cl_Tvtcf_Client_TaskHandler_CreateTask); };


    if (!(_secondaryObjective isEqualTo ["null"])) then {
        ([(_class_fields select 6), [_secondaryObjective, 2, false]] call cl_Tvtcf_Client_TaskHandler_CreateTask); };


    if (!(_returnObjective isEqualTo ["null"])) then {
        ([(_class_fields select 6), [_returnObjective, 3, false]] call cl_Tvtcf_Client_TaskHandler_CreateTask); };


    if (!((_class_fields select 7) isEqualTo ["null"])) then {

        private _objectiveChanges = ([(_class_fields select 7), [playerSide]] call cl_Tvtcf_Common_ObjectiveChangeCollection_GetObjectiveChangesBySide);

        {
            ([(_class_fields select 6), [(_x select 2), (_x select 3), false]] call cl_Tvtcf_Client_TaskHandler_SetTaskState);
        } forEach _objectiveChanges; };


    ([_class_fields, []] call cl_Sqx_Services_Service_Run); };