
















cl_Tvtcf_Client_Statics_ClientObjects_constructor = { _this select 0 };



Tvtcf_Client_Statics_ClientObjects_Init = { 


    Tvtcf_Client_Statics_ClientObjects_BriefingHandler = ([[["Tvtcf_Client_BriefingHandler",["Tvtcf.Client.IBriefingHandler"]]], []] call cl_Tvtcf_Client_BriefingHandler_constructor);;
    Tvtcf_Client_Statics_ClientObjects_TaskHandler = ([[["Tvtcf_Client_TaskHandler",[]]], []] call cl_Tvtcf_Client_TaskHandler_constructor);;
    Tvtcf_Client_Statics_ClientObjects_MapMarkerHandler = ([[["Tvtcf_Client_MapMarkerHandler",[]]], [([[["Tvtcf_Common_BaseMarkersConfig",["Tvtcf.Common.IBaseMarkersConfig"]]], []] call cl_Tvtcf_Common_BaseMarkersConfig_constructor)]] call cl_Tvtcf_Client_MapMarkerHandler_constructor);;
    Tvtcf_Client_Statics_ClientObjects_MessageHandler = ([[["Tvtcf_Client_ClientMessageHandler",[]]], []] call cl_Tvtcf_Client_ClientMessageHandler_constructor);;
    Tvtcf_Client_Statics_ClientObjects_PerformInsertionService = ([[["Tvtcf_Client_PerformInsertionService",["Sqx.Services.Service", "Sqx.Services.IService"]]], [Tvtcf_Client_Statics_ClientObjects_MessageHandler, Tvtcf_Client_Statics_ClientObjects_MapMarkerHandler]] call cl_Tvtcf_Client_PerformInsertionService_constructor);;
    Tvtcf_Client_Statics_ClientObjects_CameraHandler = ([[["Tvtcf_Client_CameraHandler",[]]], [Tvtcf_Client_Statics_ClientObjects_MessageHandler]] call cl_Tvtcf_Client_CameraHandler_constructor);;
    Tvtcf_Client_Statics_ClientObjects_JipService = ([[["Tvtcf_Client_JipService",["Sqx.Services.Service", "Sqx.Services.IService"]]], [Tvtcf_Client_Statics_ClientObjects_MessageHandler]] call cl_Tvtcf_Client_JipService_constructor);;
    Tvtcf_Client_Statics_ClientObjects_ClientMissionActionHandler = ([[["Tvtcf_Client_ClientMissionActionHandler",[]]], []] call cl_Tvtcf_Client_ClientMissionActionHandler_constructor);;
    Tvtcf_Client_Statics_ClientObjects_ExtractionSymbolHandler = ([[["Tvtcf_Client_ExtractionSymbolHandler",[]]], []] call cl_Tvtcf_Client_ExtractionSymbolHandler_constructor);;
    Tvtcf_Client_Statics_ClientObjects_BaseInsertionService = ([[["Tvtcf_Client_BaseInsertionService",["Sqx.Services.Service", "Sqx.Services.IService"]]], [([[["Tvtcf_Common_BaseMarkersConfig",["Tvtcf.Common.IBaseMarkersConfig"]]], []] call cl_Tvtcf_Common_BaseMarkersConfig_constructor)]] call cl_Tvtcf_Client_BaseInsertionService_constructor);;
    Tvtcf_Client_Statics_ClientObjects_WaitingForMissionCounter = ([[["Tvtcf_Client_WaitingForMissionCounter",["Sqx.Services.Service", "Sqx.Services.IService"]]], [(Tvtcf_Common_Statics_CommonObjects_MissionParametersHandler select 3)]] call cl_Tvtcf_Client_WaitingForMissionCounter_constructor);; };


























