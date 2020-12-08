















cl_Tvtcf_Client_ExtractionSymbolHandler_constructor = { params ["_class_fields", "_this"];

    _class_fields set [1, "Sign_Arrow_Large_Blue_F"];
    _class_fields set [2, objNull]; _class_fields };



cl_Tvtcf_Client_ExtractionSymbolHandler_CreateSymbol = { params ["_class_fields", "_this"]; params ["_position"]; 
    if (!isNull (_class_fields select 2)) then {
        ([_class_fields, []] call cl_Tvtcf_Client_ExtractionSymbolHandler_DeleteSymbol); };


    _class_fields set [2, (_class_fields select 1) createVehicleLocal _position];

    if (surfaceIsWater _position) then {
        (_class_fields select 2) setPosASL [_position select 0, _position select 1, 0.5]; } else { 


        (_class_fields select 2) setPosATL [_position select 0, _position select 1, 0.5]; }; };




cl_Tvtcf_Client_ExtractionSymbolHandler_DeleteSymbol = { params ["_class_fields", "_this"];
    if (!isNull (_class_fields select 2)) then {
        deleteVehicle (_class_fields select 2);
        _class_fields set [2, objNull]; }; };