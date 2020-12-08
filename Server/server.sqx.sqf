call compile preprocessFileLineNumbers "Server\Classes\ServerEventHandlers.sqx.sqf";
call compile preprocessFileLineNumbers "Server\Classes\ServerEventReciever.sqx.sqf";
call compile preprocessFileLineNumbers "Server\Classes\ServerObjects.sqx.sqf";
call compile preprocessFileLineNumbers "Server\Classes\Handlers\MissionUnitsHandler.sqx.sqf";
call compile preprocessFileLineNumbers "Server\Classes\Handlers\ServerActionHandler.sqx.sqf";
call compile preprocessFileLineNumbers "Server\Classes\Handlers\CampaignStarter.sqx.sqf";
call compile preprocessFileLineNumbers "Server\Classes\Objects\VehicleSideAlias.sqx.sqf";
call compile preprocessFileLineNumbers "Server\Classes\Objects\MissionSettings.sqx.sqf";
call compile preprocessFileLineNumbers "Server\Classes\Objects\InsertionEventArgs.sqx.sqf";
call compile preprocessFileLineNumbers "Server\Classes\Services\CampaignEngine.sqx.sqf";

call compile preprocessFileLineNumbers "Campaigns\Shared\Campaign.sqx.sqf";
call compile preprocessFileLineNumbers "Campaigns\Shared\Mission.sqx.sqf";
call compile preprocessFileLineNumbers "Campaigns\Shared\VehicleDictionary.sqx.sqf";
call compile preprocessFileLineNumbers "Campaigns\Shared\SoldierDictionary.sqx.sqf";







cl_Mission_Server_constructor = { _this select 0 };



Mission_Server_Initialize = { 

    call Tvtcf_Server_Statics_ServerObjects_Init;


    call Tvtcf_Server_Statics_ServerEventHandlers_Init;


    ([Tvtcf_Server_Statics_ServerObjects_CampaignStarter, []] call cl_Tvtcf_Server_Statics_CampaignStarter_StartCampaign); };