













cl_Campaigns_HiddenJewel_OperationHiddenJewel_CampaignMode_PropIndex = 1; cl_Campaigns_HiddenJewel_OperationHiddenJewel_CurrentMissionIndex_PropIndex = 2; cl_Campaigns_HiddenJewel_OperationHiddenJewel_Missions_PropIndex = 3; cl_Campaigns_HiddenJewel_OperationHiddenJewel_GainedTokensWest_PropIndex = 4; cl_Campaigns_HiddenJewel_OperationHiddenJewel_GainedTokensEast_PropIndex = 5; cl_Campaigns_HiddenJewel_OperationHiddenJewel_LostTokensWest_PropIndex = 6; cl_Campaigns_HiddenJewel_OperationHiddenJewel_LostTokensEast_PropIndex = 7; cl_Campaigns_HiddenJewel_OperationHiddenJewel_SetCampaignMode = { _this call cl_Campaigns_Campaign_SetCampaignMode }; cl_Campaigns_HiddenJewel_OperationHiddenJewel_GetNextMissionToPlay = { _this call cl_Campaigns_Campaign_GetNextMissionToPlay }; cl_Campaigns_HiddenJewel_OperationHiddenJewel_GetNextMission = { _this call cl_Campaigns_Campaign_GetNextMission };


cl_Campaigns_HiddenJewel_OperationHiddenJewel_constructor = { params ["_class_fields", "_this"];

    ([_class_fields, []] call cl_Campaigns_Campaign_Constructor); _class_fields };



cl_Campaigns_HiddenJewel_OperationHiddenJewel_SelectMissions = { params ["_class_fields", "_this"]; params ["_missions"]; 
    _missions pushBack ([[["Campaigns_HiddenJewel_Escape",["Sqx.Services.Service", "Campaigns.Mission", "Sqx.Services.IService"]]], []] call cl_Campaigns_HiddenJewel_Escape_constructor); };