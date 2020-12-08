













cl_Tvtcf_Server_Statics_ServerEventHandlers_constructor = { _this select 0 };


Tvtcf_Server_Statics_ServerEventHandlers_Init = { 




















    {

        _x addEventHandler ["Killed", {
            params ["_unit", "_killer", "_instigator", "_useEffects"];

            if (local _unit) then {

                ["ClientEventReciever.OnUnitKilled", ["", _unit, _killer]] call Tvtcf_Communication_Remote_Invoke; }; }];
    } forEach 

    switchableUnits; };