











call compile preprocessFileLineNumbers "Campaigns\HiddenJewel\InitCampaign.sqx.sqf";



cl_Campaigns_Bootstrapper_constructor = { _this select 0 };


Campaigns_Bootstrapper_GetCampaign = { scopeName "GetCampaign";

    (([[["Campaigns_HiddenJewel_OperationHiddenJewel",["Campaigns.Campaign"]]], []] call cl_Campaigns_HiddenJewel_OperationHiddenJewel_constructor)) breakOut "GetCampaign"; };