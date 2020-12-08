














cl_Tvtcf_Server_Statics_ServerEventReciever_constructor = { _this select 0 };





Tvtcf_Server_Statics_ServerEventReciever_OnPlayerPerformingInsertion = {  params ["_side", "_position", "_doTeleport"]; scopeName "OnPlayerPerformingInsertion";
    private _insertionEventArgs = ([Tvtcf_Server_Statics_ServerObjects_CampaignEngine, [_side, _position]] call cl_Tvtcf_Server_CampaignEngine_InsertGroup);

    private _switchableUnits = ([Tvtcf_Server_Statics_ServerObjects_MissionUnitsHandler, []] call cl_Tvtcf_Server_MissionUnitsHandler_GetSwitchableUnits);

    {
        if (side group _x == _side) then {

            ["ClientEventReciever.OnInsertGroup", [group _x, (_insertionEventArgs select 2), (_insertionEventArgs select 3), _doTeleport]] call Tvtcf_Communication_Remote_Invoke;
             breakOut "OnPlayerPerformingInsertion"; };
    } forEach 
    _switchableUnits; };



Tvtcf_Server_Statics_ServerEventReciever_OnPlayerKilled = {  params ["_player", "_killer"]; };



Tvtcf_Server_Statics_ServerEventReciever_OnAction = {  params ["_serverActionId", "_target", "_caller"]; 
    ([Tvtcf_Server_Statics_ServerObjects_CampaignEngine, [_serverActionId, _target, _caller]] call cl_Tvtcf_Server_CampaignEngine_OnAction); };



Tvtcf_Server_Statics_ServerEventReciever_OnEndMission = { 
    ([Tvtcf_Server_Statics_ServerObjects_CampaignEngine, []] call cl_Tvtcf_Server_CampaignEngine_EndCurrentMission); };



Tvtcf_Server_Statics_ServerEventReciever_OnForceNextMission = { 
    ([Tvtcf_Server_Statics_ServerObjects_CampaignEngine, []] call cl_Tvtcf_Server_CampaignEngine_ForceNextMission); };