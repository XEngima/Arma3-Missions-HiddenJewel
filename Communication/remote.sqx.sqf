














cl_Tvtcf_Communication_Remote_constructor = { _this select 0 };





Tvtcf_Communication_Remote_Invoke = {  params ["_methodFullName", ["_parameter", []]]; 
    [_methodFullName, _parameter] remoteExec ["Tvtcf_Communication_Remote_Recieve", Tvtcf_Communication_RemoteTargetOptions_All]; };






Tvtcf_Communication_Remote_Recieve = {  params ["_methodFullName", "_parameters"]; 
    if (isServer) then {



        switch (_methodFullName) do {
            case 
            "ServerEventReciever.OnPlayerPerformingInsertion": { _parameters spawn Tvtcf_Server_Statics_ServerEventReciever_OnPlayerPerformingInsertion; };
            case "ServerEventReciever.OnAction": { _parameters spawn Tvtcf_Server_Statics_ServerEventReciever_OnAction; };
            case "ServerEventReciever.OnEndMission": { _parameters spawn Tvtcf_Server_Statics_ServerEventReciever_OnEndMission; };
            case "ServerEventReciever.OnForceNextMission": { _parameters spawn Tvtcf_Server_Statics_ServerEventReciever_OnForceNextMission; }; }; };



    if (!isDedicated) then {



        switch (_methodFullName) do {
            case 
            "ClientEventReciever.OnCampaignStart": { _parameters spawn Tvtcf_Client_Statics_ClientEventReciever_OnCampaignStart; };
            case "ClientEventReciever.OnMissionTimeTick": { _parameters spawn Tvtcf_Client_Statics_ClientEventReciever_OnMissionTimeTick; };
            case "ClientEventReciever.OnMissionStarting": { _parameters spawn Tvtcf_Client_Statics_ClientEventReciever_OnMissionStarting; };
            case "ClientEventReciever.OnMissionSetup": { _parameters spawn Tvtcf_Client_Statics_ClientEventReciever_OnMissionSetup; };
            case "ClientEventReciever.OnInsertGroup": { _parameters spawn Tvtcf_Client_Statics_ClientEventReciever_OnInsertGroup; };
            case "ClientEventReciever.OnMissionEnding": { _parameters spawn Tvtcf_Client_Statics_ClientEventReciever_OnMissionEnding; };
            case "ClientEventReciever.OnMissionEnded": { _parameters spawn Tvtcf_Client_Statics_ClientEventReciever_OnMissionEnded; };
            case "ClientEventReciever.OnMissionBriefing": { _parameters spawn Tvtcf_Client_Statics_ClientEventReciever_OnMissionBriefing; };
            case "ClientEventReciever.OnTaskStateChanged": { _parameters spawn Tvtcf_Client_Statics_ClientEventReciever_OnTaskStateChanged; };
            case "ClientEventReciever.OnCampaignEnded": { _parameters spawn Tvtcf_Client_Statics_ClientEventReciever_OnCampaignEnded; };
            case "ClientEventReciever.OnUnitKilled": { _parameters spawn Tvtcf_Client_Statics_ClientEventReciever_OnUnitKilled; };
            case "ClientEventReciever.OnShowNotification": { _parameters spawn Tvtcf_Client_Statics_ClientEventReciever_OnShowNotification; };
            case "ClientEventReciever.OnAddAction": { _parameters spawn Tvtcf_Client_Statics_ClientEventReciever_OnAddAction; };
            case "ClientEventReciever.OnDeleteActions": { _parameters spawn Tvtcf_Client_Statics_ClientEventReciever_OnDeleteActions; };
            case "ClientEventReciever.OnForceNextMission": { _parameters spawn Tvtcf_Client_Statics_ClientEventReciever_OnForceNextMission; };
            case "ClientEventReciever.OnCreateSideMarker": { _parameters spawn Tvtcf_Client_Statics_ClientEventReciever_OnCreateSideMarker; }; }; }; };