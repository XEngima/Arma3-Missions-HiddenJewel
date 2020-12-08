call compile preprocessFileLineNumbers "Client\Classes\ClientState.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\ClientObjects.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\ClientEventReciever.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\ClientEventHandlers.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Configs\TutorialConfig.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Dialogs\TutorialDialog.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Dialogs\DebriefingDialog.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Handlers\TutorialHandler.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Handlers\BriefingHandler.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Handlers\TaskHandler.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Handlers\MapMarkerHandler.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Handlers\TvtcfActionMenuHandler.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Handlers\ClientMessageHandler.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Handlers\CameraHandler.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Handlers\ClientMissionActionHandler.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Handlers\ExtractionSymbolHandler.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Objects\ActionMapping.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Objects\Tutorial.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Services\CampaignEndService.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Services\PerformInsertionService.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Services\TeleportService.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Services\JipService.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Services\MissionBriefingService.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Services\MissionPrepareCounter.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Services\BaseInsertionService.sqx.sqf";
call compile preprocessFileLineNumbers "Client\Classes\Services\WaitingForMissionCounter.sqx.sqf";






cl_Mission_Client_constructor = { _this select 0 };



Mission_Client_Initialize = { 

    cutText ["", "BLACK FADED"];
    waitUntil { player == player };

    call Tvtcf_Client_TutorialConfig_Init;
    call Tvtcf_Client_TutorialHandler_Init;

    call Tvtcf_Client_Statics_ClientState_Init;


    call Tvtcf_Client_Statics_ClientObjects_Init;


    call Tvtcf_Client_Statics_ClientEventHandlers_Init;


    sleep 1;
    call Tvtcf_Client_TvtcfActionMenuHandler_Init; };