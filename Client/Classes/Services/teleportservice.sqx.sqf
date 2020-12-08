













cl_Tvtcf_Client_TeleportService_IsRunning_PropIndex = 2; cl_Tvtcf_Client_TeleportService_IsCancelling_PropIndex = 3; cl_Tvtcf_Client_TeleportService_RunAsync = { _this call cl_Sqx_Services_Service_RunAsync }; cl_Tvtcf_Client_TeleportService_Cancel = { _this call cl_Sqx_Services_Service_Cancel };




cl_Tvtcf_Client_TeleportService_constructor = { params ["_class_fields", "_this"]; params ["_position", ["_teleportVehicles", true], ["_doBlackOut", true]]; 

    ([_class_fields, []] call cl_Sqx_Services_Service_Constructor);
    _class_fields set [4, _position];
    _class_fields set [6, _doBlackOut];
    _class_fields set [5, _teleportVehicles]; _class_fields };



Tvtcf_Client_TeleportService_FindSafePos = {  params ["_pos"]; scopeName "FindSafePos";
    private ["_spawnpos", "_randir", "_extendedRadius", "_randis", "_houses", "_supplies", "_vehicles", "_isFlat", "_danger", "_foundIt", "_tries"];
    private ["_distanceToNearestVehicle", "_distanceFromBuilding", "_allowedSteepness"];

    _distanceFromBuilding = 10;
    _allowedSteepness = 0.5;

    _distanceToNearestVehicle = 9;

    _spawnpos = [];
    _foundIt = false;
    _tries = 0;
    _extendedRadius = 0;

    while { true } do {
        scopeName "SpawnPosGen";

        _randir = floor random 360;
        _randis = floor random _extendedRadius;
        _spawnpos = [(_pos select 0) + ((sin _randir) * _randis), (_pos select 1) + ((cos _randir) * _randis), 0.1];
        _houses = nearestObjects [_spawnpos, ["house", "wall"], 50];
        _supplies = _spawnpos nearSupplies 2;
        _vehicles = nearestObjects [_spawnpos, ["LandVehicle", "AirVehicle", "Man"], 25];
        _isFlat = _spawnpos isFlatEmpty [2, -1, _allowedSteepness, 10, 0, false, objNull];
        _danger = false;
        { if (floor (_spawnpos distance getPos _x) < _distanceFromBuilding) then { _danger = true; };
        } forEach _houses; { if (floor (_spawnpos distance getPos _x) < _distanceToNearestVehicle) then { _danger = true; };
        } forEach _vehicles; { if (floor (_spawnpos distance getPos _x) < _distanceToNearestVehicle) then { _danger = true; };
        } forEach _supplies; if (count _isFlat < 1) then { _danger = true; };
        if (!_danger) then {
            _foundIt = true;
            breakOut "SpawnPosGen" };

        _tries = _tries + 1;
        _extendedRadius = _extendedRadius + 0.5;
        sleep 0.01; };


    if (!_foundIt) then {
        _spawnPos = []; };


    (_spawnpos) breakOut "FindSafePos"; };



cl_Tvtcf_Client_TeleportService_TeleportVehicleAndCrew = { params ["_class_fields", "_this"]; params ["_vehicle"]; 
    private _everyoneInTheSameVehicle = true;

    {
        if (vehicle _x != _x) then {
            if (vehicle _x != _vehicle) then {
                _everyoneInTheSameVehicle = false; }; };
    } forEach 

    units group player;

    private _occupiedByAnotherVehicle = false;

    {
        if (_x distance (_class_fields select 4) < 10) then {
            _occupiedByAnotherVehicle = true; };
    } forEach 
    vehicles;

    private _safePos = (_class_fields select 4);

    if (!_everyoneInTheSameVehicle || _occupiedByAnotherVehicle) then {
        _safePos = [(_class_fields select 4)] call Tvtcf_Client_TeleportService_FindSafePos;

        if (count _safePos == 0) then {
            _safePos = [(_safePos select 0) - 3 + random 6, (_safePos select 1) - 3 + random 6, 0.25]; }; };



    _vehicle setPos [(_safePos select 0), (_safePos select 1), 0.25]; };




cl_Tvtcf_Client_TeleportService_Run = { params ["_class_fields", "_this"];
    if (player distance (_class_fields select 4) > 50) then {

        if ((_class_fields select 6)) then {

            sleep 0.5; };


        if ((_class_fields select 5)) then {

            private _teleportedUnits = [];

            {
                private _unit = vehicle _x;
                private _isVehicle = vehicle _x != _x;

                if (_isVehicle) then {

                    if (local _unit && { !(_unit in _teleportedUnits) }) then {

                        ([_class_fields, [_unit]] call cl_Tvtcf_Client_TeleportService_TeleportVehicleAndCrew);
                        _teleportedUnits pushBack _unit; }; } else { 




                    if (local _unit && { !(_unit in _teleportedUnits) }) then {
                        _unit setPos [((_class_fields select 4) select 0) - 3 + random 6, ((_class_fields select 4) select 1) - 3 + random 6, 0.1];
                        _teleportedUnits pushBack _unit; }; };
            } forEach 

            units group player; } else { 



            {
                if (local _x) then {

                    _x setPos [((_class_fields select 4) select 0) - 3 + random 6, ((_class_fields select 4) select 1) - 3 + random 6, 0.1]; };
            } forEach 
            units group player;


            if (player distance (_class_fields select 4) > 10) then {
                player setPos [((_class_fields select 4) select 0) - 3 + random 6, ((_class_fields select 4) select 1) - 3 + random 6, 0.1]; }; };



        player setDamage 0;
        openMap false;

        if ((_class_fields select 6)) then { }; };




    ([_class_fields, []] call cl_Sqx_Services_Service_Run); };