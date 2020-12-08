














cl_Tvtcf_Server_Statics_ServerObjects_constructor = { _this select 0 };



Tvtcf_Server_Statics_ServerObjects_Init = { 
    Tvtcf_Server_Statics_ServerObjects_MissionUnitsHandler = ([[["Tvtcf_Server_MissionUnitsHandler",[]]], []] call cl_Tvtcf_Server_MissionUnitsHandler_constructor);;

    Tvtcf_Server_Statics_ServerObjects_CampaignStarter = ([[["Tvtcf_Server_Statics_CampaignStarter",[]]], []] call cl_Tvtcf_Server_Statics_CampaignStarter_constructor);;

    Tvtcf_Server_Statics_ServerObjects_CampaignEngine = 






    ([[["Tvtcf_Server_CampaignEngine",["Sqx.Services.Service", "Sqx.Services.IService"]]], [Tvtcf_Common_Statics_CommonObjects_BaseMarkersConfig, Tvtcf_Server_Statics_ServerObjects_MissionUnitsHandler, (Tvtcf_Common_Statics_CommonObjects_MissionParametersHandler select 6), (Tvtcf_Common_Statics_CommonObjects_MissionParametersHandler select 7), (Tvtcf_Common_Statics_CommonObjects_MissionParametersHandler select 3), (Tvtcf_Common_Statics_CommonObjects_MissionParametersHandler select 4), (Tvtcf_Common_Statics_CommonObjects_MissionParametersHandler select 5)]] call cl_Tvtcf_Server_CampaignEngine_constructor);; };






