















cl_Sqx_Services_Service_constructor = { params ["_class_fields", "_this"];

    _class_fields set [2, false];
    _class_fields set [3, false]; _class_fields };



cl_Sqx_Services_Service_IsRunning_PropIndex = 2;


cl_Sqx_Services_Service_IsCancelling_PropIndex = 3;




cl_Sqx_Services_Service_Run = { params ["_class_fields", "_this"];
    _class_fields set [2, false];
    _class_fields set [3, false]; };








cl_Sqx_Services_Service_RunAsync = { params ["_class_fields", "_this"]; scopeName "RunAsync";
    if (!(_class_fields select 2)) then {

        _class_fields set [2, true];
        _class_fields set [3, false];

        _class_fields set [1,([_class_fields, []] spawn compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_Run"))]; };


    ((_class_fields select 1)) breakOut "RunAsync"; };






cl_Sqx_Services_Service_Cancel = { params ["_class_fields", "_this"];
    _class_fields set [3, true]; };