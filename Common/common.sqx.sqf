call compile preprocessFileLineNumbers "Common\Enums\ObjectiveState.sqx.sqf";
call compile preprocessFileLineNumbers "Common\Classes\CommonObjects.sqx.sqf";
call compile preprocessFileLineNumbers "Common\Classes\CommonEventHandlers.sqx.sqf";
call compile preprocessFileLineNumbers "Common\Classes\Configs\BaseMarkersConfig.sqx.sqf";
call compile preprocessFileLineNumbers "Common\Classes\Handlers\MissionParametersHandler.sqx.sqf";
call compile preprocessFileLineNumbers "Common\Classes\Handlers\Functions.sqx.sqf";
call compile preprocessFileLineNumbers "Common\Classes\Objects\BaseMarkerInfo.sqx.sqf";
call compile preprocessFileLineNumbers "Common\Classes\Objects\DictionaryItem.sqx.sqf";
call compile preprocessFileLineNumbers "Common\Classes\Objects\MissionMarkersInfo.sqx.sqf";
call compile preprocessFileLineNumbers "Common\Classes\Objects\MarkerInfo.sqx.sqf";
call compile preprocessFileLineNumbers "Common\Classes\Objects\MissionResultInfo.sqx.sqf";
call compile preprocessFileLineNumbers "Common\Classes\Objects\MissionResult.sqx.sqf";
call compile preprocessFileLineNumbers "Common\Classes\Objects\MissionObjective.sqx.sqf";
call compile preprocessFileLineNumbers "Common\Classes\Objects\MissionBriefing.sqx.sqf";
call compile preprocessFileLineNumbers "Common\Classes\Objects\ObjectiveChange.sqx.sqf";
call compile preprocessFileLineNumbers "Common\Classes\Objects\ObjectiveChangeCollection.sqx.sqf";
call compile preprocessFileLineNumbers "Common\Classes\Objects\Marker.sqx.sqf";






cl_Mission_Common_constructor = { _this select 0 };



Mission_Common_Initialize = { 

    0 fadeRadio 0;

    enableSentences false;


    call Tvtcf_Common_Statics_CommonObjects_Init;


    call Tvtcf_Common_Statics_CommonEventHandlers_Init; };