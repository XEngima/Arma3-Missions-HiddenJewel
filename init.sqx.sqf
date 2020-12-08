


call compile preprocessFileLineNumbers "Sqx\Services\Service.sqx.sqf";
call compile preprocessFileLineNumbers "Communication\InitCommunication.sqx.sqf";


call compile preprocessFileLineNumbers "Common\Common.sqx.sqf";
call Mission_Common_Initialize;


if (isServer) then {
    call compile preprocessFileLineNumbers "Server\Server.sqx.sqf";
    call Mission_Server_Initialize; };



if (!isDedicated) then {
    call compile preprocessFileLineNumbers "Client\Client.sqx.sqf";
    call Mission_Client_Initialize; };



if (!isMultiplayer) then {

    for "_i" from 1 to 20 do {

        private _bluforUnitVar = "b" + str _i;
        private _opforUnitVar = "o" + str _i;

        if (!isNil _bluforUnitVar) then {
            if (!isPlayer call compile _bluforUnitVar) then {
                deleteVehicle call compile _bluforUnitVar; }; };



        if (!isNil _opforUnitVar) then {
            if (!isPlayer call compile _opforUnitVar) then {
                deleteVehicle call compile _opforUnitVar; }; }; }; };