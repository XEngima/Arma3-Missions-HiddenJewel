











call compile preprocessFileLineNumbers "Campaigns\MyCampaign\InitCampaign.sqx.sqf";



cl_Campaigns_Bootstrapper_constructor = { _this select 0 };


Campaigns_Bootstrapper_GetCampaign = { scopeName "GetCampaign";

    (([[["Campaigns_MyCampaign_MyOperation",["Campaigns.Campaign"]]], []] call cl_Campaigns_MyCampaign_MyOperation_constructor)) breakOut "GetCampaign"; };