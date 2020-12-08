

















cl_Tvtcf_Client_ClientMissionActionHandler_constructor = { params ["_class_fields", "_this"];

    _class_fields set [1, []]; _class_fields };



Tvtcf_Client_ClientMissionActionHandler_OnAction = {  params ["_target", "_caller", "_actionId", "_serverActionId"]; 
    ["ServerEventReciever.OnAction", [_serverActionId, _target, _caller]] call Tvtcf_Communication_Remote_Invoke; };



cl_Tvtcf_Client_ClientMissionActionHandler_AddAction = { params ["_class_fields", "_this"]; params ["_serverActionId", "_object", "_title"]; 
    private _clientActionId = _object addAction [_title, { call Tvtcf_Client_ClientMissionActionHandler_OnAction }, _serverActionId, 100, false, true, "", "true", 5];
    (_class_fields select 1) pushBack ([[["Tvtcf_Client_ActionMapping",[]]], [_serverActionId, _clientActionId, _object]] call cl_Tvtcf_Client_ActionMapping_constructor); };



cl_Tvtcf_Client_ClientMissionActionHandler_DeleteActions = { params ["_class_fields", "_this"]; params ["_serverActionIds"]; 
    private _actionMappingsToKeep = [];

    {
        if ((_x select 1) in _serverActionIds) then {
            (_x select 3) removeAction (_x select 2); } else { 


            _actionMappingsToKeep pushBack _x; };
    } forEach 
    (_class_fields select 1);

    _class_fields set [1, _actionMappingsToKeep]; };