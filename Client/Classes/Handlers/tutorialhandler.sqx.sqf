













cl_Tvtcf_Client_TutorialHandler_constructor = { _this select 0 };




Tvtcf_Client_TutorialHandler_Init = { 
    Tvtcf_Client_TutorialHandler__mTutorialsTurnedOff = false; };





Tvtcf_Client_TutorialHandler_DoShowTutorial = {  params ["_tutorialType"]; 
    private ["_tutorial", "_tutorialDialog"];

    waitUntil { !dialog };

    if (!Tvtcf_Client_TutorialHandler__mTutorialsTurnedOff) then {

        _tutorial = [_tutorialType] call Tvtcf_Client_TutorialConfig_GetTutorial;

        if (!(_tutorial select 4)) then {

            _tutorialDialog = ([[["Tvtcf_Client_TutorialDialog",[]]], [_tutorial]] call cl_Tvtcf_Client_TutorialDialog_constructor);
            ([_tutorialDialog, []] call cl_Tvtcf_Client_TutorialDialog_ShowDialog);

            _tutorial set [4, true];

            if ((_tutorialDialog select 2)) then {
                Tvtcf_Client_TutorialHandler__mTutorialsTurnedOff = true; }; }; }; };








Tvtcf_Client_TutorialHandler_ShowTutorial = {  params ["_tutorialType"]; 
    [_tutorialType] spawn Tvtcf_Client_TutorialHandler_DoShowTutorial; };