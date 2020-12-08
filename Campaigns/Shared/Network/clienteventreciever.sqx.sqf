
















cl_Campaigns_Network_ClientEventReciever_constructor = { _this select 0 };








Campaigns_Network_ClientEventReciever_OnShowMessage = {  params ["_message", "_showOnSide"]; 
    if (_showOnSide == playerSide) then {
        titleText [_message, "PLAIN"]; }; };