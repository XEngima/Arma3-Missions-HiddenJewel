


















cl_Tvtcf_Server_ServerActionHandler_constructor = { params ["_class_fields", "_this"];

    _class_fields set [1, 0]; _class_fields };








cl_Tvtcf_Server_ServerActionHandler_AddAction = { params ["_class_fields", "_this"]; params ["_object", "_title", "_side"]; scopeName "AddAction";
    _class_fields set [1, (_class_fields select 1) + 1];
    ["ClientEventReciever.OnAddAction", [(_class_fields select 1), _object, _title, _side]] call Tvtcf_Communication_Remote_Invoke;
    ((_class_fields select 1)) breakOut "AddAction"; };



cl_Tvtcf_Server_ServerActionHandler_DeleteActions = { params ["_class_fields", "_this"]; params ["_actionIds"]; 
    ["ClientEventReciever.OnDeleteActions", [_actionIds]] call Tvtcf_Communication_Remote_Invoke; };