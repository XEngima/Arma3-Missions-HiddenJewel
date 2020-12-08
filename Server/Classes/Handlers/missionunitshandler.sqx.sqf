















cl_Tvtcf_Server_MissionUnitsHandler_constructor = { params ["_class_fields", "_this"];

    _class_fields set [1, []];
    _class_fields set [2, []]; _class_fields };



cl_Tvtcf_Server_MissionUnitsHandler_GetSwitchableUnits = { params ["_class_fields", "_this"]; scopeName "GetSwitchableUnits";
    private _switchableUnits = [];

    if (!isNil "b1" && { !isNull b1 }) then {
        _switchableUnits pushBack b1; };

    if (!isNil "b2" && { !isNull b2 }) then {
        _switchableUnits pushBack b2; };

    if (!isNil "b3" && { !isNull b3 }) then {
        _switchableUnits pushBack b3; };

    if (!isNil "b4" && { !isNull b4 }) then {
        _switchableUnits pushBack b4; };

    if (!isNil "b5" && { !isNull b5 }) then {
        _switchableUnits pushBack b5; };

    if (!isNil "b6" && { !isNull b1 }) then {
        _switchableUnits pushBack b1; };

    if (!isNil "b7" && { !isNull b2 }) then {
        _switchableUnits pushBack b2; };

    if (!isNil "b8" && { !isNull b3 }) then {
        _switchableUnits pushBack b3; };

    if (!isNil "b9" && { !isNull b4 }) then {
        _switchableUnits pushBack b4; };

    if (!isNil "b10" && { !isNull b5 }) then {
        _switchableUnits pushBack b5; };

    if (!isNil "b11" && { !isNull b5 }) then {
        _switchableUnits pushBack b5; };

    if (!isNil "b12" && { !isNull b5 }) then {
        _switchableUnits pushBack b5; };

    if (!isNil "b13" && { !isNull b5 }) then {
        _switchableUnits pushBack b5; };

    if (!isNil "b14" && { !isNull b5 }) then {
        _switchableUnits pushBack b5; };

    if (!isNil "b15" && { !isNull b5 }) then {
        _switchableUnits pushBack b5; };

    if (!isNil "b16" && { !isNull b5 }) then {
        _switchableUnits pushBack b5; };

    if (!isNil "b17" && { !isNull b5 }) then {
        _switchableUnits pushBack b5; };

    if (!isNil "b18" && { !isNull b5 }) then {
        _switchableUnits pushBack b5; };

    if (!isNil "b19" && { !isNull b5 }) then {
        _switchableUnits pushBack b5; };

    if (!isNil "b20" && { !isNull b5 }) then {
        _switchableUnits pushBack b5; };


    if (!isNil "o1" && { !isNull o1 }) then {
        _switchableUnits pushBack o1; };

    if (!isNil "o2" && { !isNull o2 }) then {
        _switchableUnits pushBack o2; };

    if (!isNil "o3" && { !isNull o3 }) then {
        _switchableUnits pushBack o3; };

    if (!isNil "o4" && { !isNull o4 }) then {
        _switchableUnits pushBack o4; };

    if (!isNil "o5" && { !isNull o5 }) then {
        _switchableUnits pushBack o5; };

    if (!isNil "o6" && { !isNull o1 }) then {
        _switchableUnits pushBack o1; };

    if (!isNil "o7" && { !isNull o2 }) then {
        _switchableUnits pushBack o2; };

    if (!isNil "o8" && { !isNull o3 }) then {
        _switchableUnits pushBack o3; };

    if (!isNil "o9" && { !isNull o4 }) then {
        _switchableUnits pushBack o4; };

    if (!isNil "o10" && { !isNull o5 }) then {
        _switchableUnits pushBack o5; };

    if (!isNil "o11" && { !isNull o5 }) then {
        _switchableUnits pushBack o5; };

    if (!isNil "o12" && { !isNull o5 }) then {
        _switchableUnits pushBack o5; };

    if (!isNil "o13" && { !isNull o5 }) then {
        _switchableUnits pushBack o5; };

    if (!isNil "o14" && { !isNull o5 }) then {
        _switchableUnits pushBack o5; };

    if (!isNil "o15" && { !isNull o5 }) then {
        _switchableUnits pushBack o5; };

    if (!isNil "o16" && { !isNull o5 }) then {
        _switchableUnits pushBack o5; };

    if (!isNil "o17" && { !isNull o5 }) then {
        _switchableUnits pushBack o5; };

    if (!isNil "o18" && { !isNull o5 }) then {
        _switchableUnits pushBack o5; };

    if (!isNil "o19" && { !isNull o5 }) then {
        _switchableUnits pushBack o5; };

    if (!isNil "o20" && { !isNull o5 }) then {
        _switchableUnits pushBack o5; };


    {
        _switchableUnits pushBack _x;
    } forEach (([_class_fields, [west]] call cl_Tvtcf_Server_MissionUnitsHandler_GetAiUnitsBySide));

    {
        _switchableUnits pushBack _x;
    } forEach (([_class_fields, [east]] call cl_Tvtcf_Server_MissionUnitsHandler_GetAiUnitsBySide));

    (_switchableUnits) breakOut "GetSwitchableUnits"; };



cl_Tvtcf_Server_MissionUnitsHandler_GetGroupBySide = { params ["_class_fields", "_this"]; params ["_side"]; scopeName "GetGroupBySide";
    {
        if (side group _x == _side) then {
            (group _x) breakOut "GetGroupBySide"; };
    } forEach 
    (([_class_fields, []] call cl_Tvtcf_Server_MissionUnitsHandler_GetSwitchableUnits));

    (createGroup [_side, true]) breakOut "GetGroupBySide"; };



cl_Tvtcf_Server_MissionUnitsHandler_AddAiUnit = { params ["_class_fields", "_this"]; params ["_unit"]; 
    if (side group _unit == west) then {
        (_class_fields select 1) pushBack _unit; } else { 


        (_class_fields select 2) pushBack _unit; }; };




cl_Tvtcf_Server_MissionUnitsHandler_RemoveDeadFromAiUnits = { params ["_class_fields", "_this"];
    private _westlyAiUnitsToKeep = [];
    private _eastlyAiUnitsToKeep = [];

    {
        if (alive _x && canStand _x) then {
            _westlyAiUnitsToKeep pushBack _x; } else { 


            deleteVehicle _x; };
    } forEach 
    (_class_fields select 1);

    {
        if (alive _x && canStand _x) then {
            _eastlyAiUnitsToKeep pushBack _x; } else { 


            deleteVehicle _x; };
    } forEach 
    (_class_fields select 2);

    _class_fields set [1, _westlyAiUnitsToKeep];
    _class_fields set [2, _eastlyAiUnitsToKeep]; };



cl_Tvtcf_Server_MissionUnitsHandler_GetAiUnitsBySide = { params ["_class_fields", "_this"]; params ["_side"]; scopeName "GetAiUnitsBySide";
    ([_class_fields, []] call cl_Tvtcf_Server_MissionUnitsHandler_RemoveDeadFromAiUnits);

    if (_side == west) then {
        ((_class_fields select 1)) breakOut "GetAiUnitsBySide"; } else { 


        ((_class_fields select 2)) breakOut "GetAiUnitsBySide"; }; };