


















cl_Tvtcf_Client_TaskHandler_constructor = { params ["_class_fields", "_this"];

    _class_fields set [1, []];
    _class_fields set [2, "MissionTask_" + (str getPlayerUID player) + "_"]; _class_fields };




cl_Tvtcf_Client_TaskHandler_CreateTask = { params ["_class_fields", "_this"]; params ["_missionObjective", "_prio", "_showNotification"]; 
    private ["_taskId"];

    _taskId = (_class_fields select 2) + str _prio;

    [player, _taskId, [(_missionObjective select 2), (_missionObjective select 1)], [], "CREATED", 0, _showNotification] call BIS_fnc_taskCreate;
    (_class_fields select 1) pushBack _taskId; };






cl_Tvtcf_Client_TaskHandler_SetTaskState = { params ["_class_fields", "_this"]; params ["_prio", "_objectiveState", "_showNotification"]; 
    private ["_taskId"];



    _taskId = (_class_fields select 2) + str _prio;

    [_taskId, [_objectiveState] call Tvtcf_Common_ObjectiveStateMeta_ToTaskStateString, _showNotification] call BIS_fnc_taskSetState; };



cl_Tvtcf_Client_TaskHandler_ShowNotification = { params ["_class_fields", "_this"]; params ["_text"]; 
    ["TaskCreated", ["", _text]] call BIS_fnc_showNotification; };



cl_Tvtcf_Client_TaskHandler_DeleteAllTasks = { params ["_class_fields", "_this"];
    {
        [_x, playerSide] call BIS_fnc_deleteTask;
    } forEach (_class_fields select 1);

    _class_fields set [1, []]; };