












Tvtcf_Client_TutorialDialog_DialogsTurnedOff = false;








cl_Tvtcf_Client_TutorialDialog_constructor = { params ["_class_fields", "_this"];
    params ["_tutorial"];
    _class_fields set [1, _tutorial];
    _class_fields set [2, false]; _class_fields };



cl_Tvtcf_Client_TutorialDialog_TurnOffTutorials_PropIndex = 2;



cl_Tvtcf_Client_TutorialDialog_ShowDialog = { params ["_class_fields", "_this"];
    private ["_dlgHeader", "_dlgText"];

    waitUntil { !dialog };

    _dlgHeader = 43;
    _dlgText = 44;

    createDialog "IntTutorialDialog";

    ctrlSetText [_dlgHeader, ((_class_fields select 1) select 2)];
    ctrlSetText [_dlgText, ((_class_fields select 1) select 3)];

    waitUntil { !dialog };

    _class_fields set [2, Tvtcf_Client_TutorialDialog_DialogsTurnedOff]; 3 };