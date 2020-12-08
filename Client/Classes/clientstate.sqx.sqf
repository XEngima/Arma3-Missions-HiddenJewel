













cl_Tvtcf_Client_Statics_ClientState_constructor = { _this select 0 };


Tvtcf_Client_Statics_ClientState_Init = { 
    Tvtcf_Client_Statics_ClientState_IsAlive = true; };





Tvtcf_Client_Statics_ClientState_SetPlayerIsAlive = {  params ["_isAlive"]; 
    Tvtcf_Client_Statics_ClientState_IsAlive = _isAlive;
    diag_log ("ISALIVE: " + (name player) + " is alive: " + str _isAlive); };



Tvtcf_Client_Statics_ClientState_GetHasInserted = { scopeName "GetHasInserted";
    private _hasInserted = false;

    if (playerSide == west) then {

        _hasInserted = call Tvtcf_Communication_PublicVariableHandler_GetWestHasInserted; } else { 


        _hasInserted = call Tvtcf_Communication_PublicVariableHandler_GetEastHasInserted; };


    (_hasInserted) breakOut "GetHasInserted"; };