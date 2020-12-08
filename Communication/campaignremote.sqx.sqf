











cl_Tvtcf_Communication_CampaignRemote_constructor = { _this select 0 };





cl_Tvtcf_Communication_CampaignRemote_Invoke = { params ["_class_fields", "_this"]; params ["_eventName", ["_parameter", []]]; 
    [_eventName, _parameter] remoteExec ["Tvtcf_Communication_CampaignRemote_Recieve", Tvtcf_Communication_RemoteTargetOptions_All]; };






Tvtcf_Communication_CampaignRemote_Recieve = {  params ["_eventName", "_parameters"]; 
    if (!isDedicated) then {



        _parameters call compile ("_this spawn Campaigns_Network_ClientEventReciever_On" + _eventName + ";"); }; };