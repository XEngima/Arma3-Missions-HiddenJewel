















cl_Tvtcf_Client_DebriefingDialog_constructor = { params ["_class_fields", "_this"]; params ["_header", "_text"]; 

    _class_fields set [1, _header];
    _class_fields set [2, _text]; _class_fields };





cl_Tvtcf_Client_DebriefingDialog_ShowDialog = { params ["_class_fields", "_this"]; scopeName "ShowDialog";
    waitUntil { !dialog };

    private _dlgHeader = 43;
    private _dlgText = 44;

    createDialog "IntTutorialDialog";

    ctrlSetText [_dlgHeader, (_class_fields select 1)];
    ctrlSetText [_dlgText, (_class_fields select 2)];

    ctrlShow [45, false];

    waitUntil { !dialog };

    (3) breakOut "ShowDialog"; };