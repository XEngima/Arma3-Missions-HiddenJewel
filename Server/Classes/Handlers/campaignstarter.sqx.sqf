









call compile preprocessFileLineNumbers "Campaigns\Shared\Bootstrapper.sqx.sqf";







cl_Tvtcf_Server_Statics_CampaignStarter_constructor = { _this select 0 };


cl_Tvtcf_Server_Statics_CampaignStarter_StartCampaign = { params ["_class_fields", "_this"];
    private _campaign = call Campaigns_Bootstrapper_GetCampaign;
    ([Tvtcf_Server_Statics_ServerObjects_CampaignEngine, [_campaign]] call cl_Tvtcf_Server_CampaignEngine_SetCampaign);
    ([Tvtcf_Server_Statics_ServerObjects_CampaignEngine, []] call compile ("_this call cl_" + ((Tvtcf_Server_Statics_ServerObjects_CampaignEngine select 0) select 0) + "_RunAsync")); };