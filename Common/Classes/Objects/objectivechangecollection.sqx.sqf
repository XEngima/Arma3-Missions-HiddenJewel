















cl_Tvtcf_Common_ObjectiveChangeCollection_constructor = { params ["_class_fields", "_this"];

    _class_fields set [1, []]; _class_fields };



cl_Tvtcf_Common_ObjectiveChangeCollection_AddObjectiveChange = { params ["_class_fields", "_this"]; params ["_side", "_prio", "_state"]; 
    (_class_fields select 1) pushBack ([[["Tvtcf_Common_ObjectiveChange",[]]], [_side, _prio, _state]] call cl_Tvtcf_Common_ObjectiveChange_constructor); };



cl_Tvtcf_Common_ObjectiveChangeCollection_GetObjectiveChangesBySide = { params ["_class_fields", "_this"]; params ["_side"]; scopeName "GetObjectiveChangesBySide";
    private _changes = [];

    {
        if ((_x select 1) == _side) then {
            _changes pushBack _x; };
    } forEach 
    (_class_fields select 1);

    (_changes) breakOut "GetObjectiveChangesBySide"; };