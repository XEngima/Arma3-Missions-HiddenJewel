













cl_Tvtcf_Server_VehicleSideAlias_constructor = { params ["_class_fields", "_this"]; params ["_name", "_westVehicleType", "_eastVehicleType"]; 

    _class_fields set [1, _name];
    _class_fields set [2, _westVehicleType];
    _class_fields set [3, _eastVehicleType]; _class_fields };


cl_Tvtcf_Server_VehicleSideAlias_Name_PropIndex = 1;

cl_Tvtcf_Server_VehicleSideAlias_WestVehicleType_PropIndex = 2;

cl_Tvtcf_Server_VehicleSideAlias_EastVehicleType_PropIndex = 3;


cl_Tvtcf_Server_VehicleSideAlias_GetVehicleType = { params ["_class_fields", "_this"]; params ["_side"]; scopeName "GetVehicleType";
    if (_side == west) then {
        ((_class_fields select 2)) breakOut "GetVehicleType"; };


    if (_side == east) then {
        ((_class_fields select 3)) breakOut "GetVehicleType"; };


    ("") breakOut "GetVehicleType"; };