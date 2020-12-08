















cl_Tvtcf_Client_Statics_ClientEventHandlers_constructor = { _this select 0 };




Tvtcf_Client_Statics_ClientEventHandlers_Init = { 
    Tvtcf_Client_Statics_ClientEventHandlers__mFirstPreloadDone = false;




















    ["ClientEventHandlerId_01", "onPreloadFinished", { diag_log ("EH 'OnPreloadFinished': " + str Tvtcf_Client_Statics_ClientEventHandlers__mFirstPreloadDone); if (!Tvtcf_Client_Statics_ClientEventHandlers__mFirstPreloadDone) then { [true] call Tvtcf_Client_Statics_ClientState_SetPlayerIsAlive; if (didJIP) then {private _isInserted = call Tvtcf_Client_Statics_ClientState_GetHasInserted; [!_isInserted] call Tvtcf_Client_Statics_ClientState_SetPlayerIsAlive;([Tvtcf_Client_Statics_ClientObjects_JipService, []] call compile ("_this call cl_" + ((Tvtcf_Client_Statics_ClientObjects_JipService select 0) select 0) + "_RunAsync")); }; Tvtcf_Client_Statics_ClientEventHandlers__mFirstPreloadDone = true; }; }] call BIS_fnc_addStackedEventHandler;


    addMissionEventHandler ["MapSingleClick", {
        diag_log ("EH 'MapSingleClick': " + str _this);
        params ["_units", "_pos", "_alt", "_shift"];

        if ((Tvtcf_Client_Statics_ClientObjects_PerformInsertionService select 2)) then {
            ([Tvtcf_Client_Statics_ClientObjects_PerformInsertionService, [_pos]] call cl_Tvtcf_Client_PerformInsertionService_SendMapClick); }; }];




    player addEventHandler ["Respawn", {
        diag_log ("EH 'Respawn': " + str _this);
        params ["_player", "_corpse"];

        [] spawn {
            waitUntil { player == player };

            call Tvtcf_Client_TvtcfActionMenuHandler_UpdateVisibleOptions;
            ([Tvtcf_Client_Statics_ClientObjects_CameraHandler, []] call cl_Tvtcf_Client_CameraHandler_UpdateDeathCamera); }; }];




    player addEventHandler ["Killed", {

        diag_log ("EH 'Killed': " + str _this);
        params ["_unit", "_killer", "_instigator", "_useEffects"];

        private _isInserted = call Tvtcf_Client_Statics_ClientState_GetHasInserted;

        if (_isInserted) then {
            [false] call Tvtcf_Client_Statics_ClientState_SetPlayerIsAlive; };


        ["ClientEventReciever.OnUnitKilled", [getPlayerUID player, _unit, _killer]] call Tvtcf_Communication_Remote_Invoke; }];


    player addEventHandler ["HandleRating", {
        0 }]; };