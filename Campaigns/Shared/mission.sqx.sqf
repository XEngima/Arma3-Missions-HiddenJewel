

















cl_Campaigns_Mission_IsRunning_PropIndex = 2; cl_Campaigns_Mission_IsCancelling_PropIndex = 3; cl_Campaigns_Mission_RunAsync = { _this call cl_Sqx_Services_Service_RunAsync };







cl_Campaigns_Mission_constructor = { params ["_class_fields", "_this"];

    private ["_missionSettings"];

    ([_class_fields, []] call cl_Sqx_Services_Service_Constructor);

    _class_fields set [20, ([[["Campaigns_VehicleDictionary",[]]], []] call cl_Campaigns_VehicleDictionary_constructor)];
    _class_fields set [21, ([[["Campaigns_SoldierDictionary",[]]], []] call cl_Campaigns_SoldierDictionary_constructor)];
    _class_fields set [10, []];
    _class_fields set [11, []];
    _class_fields set [12, []];
    _class_fields set [13, []];
    _class_fields set [6, west];
    _class_fields set [7, []];
    _class_fields set [8, []];
    _class_fields set [9, false];
    _class_fields set [22, []];
    _class_fields set [23, []];
    _class_fields set [28, 1];
    _class_fields set [29, 1];
    _class_fields set [30, 1];
    _class_fields set [31, 1];
    _class_fields set [32, 1];
    _class_fields set [33, 1];
    _class_fields set [39, 0];
    _class_fields set [34, [0, 0, 0]];
    _class_fields set [35, [0, 0, 0]];
    _class_fields set [36, false];

    _missionSettings = ([[["Tvtcf_Server_MissionSettings",[]]], []] call cl_Tvtcf_Server_MissionSettings_constructor);
    ([_class_fields, [_missionSettings]] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_InitMission"));

    _class_fields set [37, (_missionSettings select 1)];
    _class_fields set [19, (_missionSettings select 2)];
    _class_fields set [38, 30];
    _class_fields set [40, (_class_fields select 38)];
    _class_fields set [15, (_missionSettings select 3)];
    _class_fields set [16, (_missionSettings select 4)];
    _class_fields set [17, (_missionSettings select 5)];
    _class_fields set [18, (_missionSettings select 6)];
    _class_fields set [41, (_missionSettings select 7)];
    _class_fields set [42, (_missionSettings select 8)]; _class_fields };







cl_Campaigns_Mission_InitMission = { params ["_class_fields", "_this"]; params ["_mission"]; };









cl_Campaigns_Mission_CreateMissionObjectives = { params ["_class_fields", "_this"];
    _class_fields set [24,([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_AddPrimaryObjectiveActing"))];
    _class_fields set [25,([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_AddSecondaryObjectiveActing"))];
    _class_fields set [26,([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_AddPrimaryObjectiveOpposing"))];
    _class_fields set [27,([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_AddSecondaryObjectiveOpposing"))]; };







Campaigns_Mission_FindSpawnPos = {  params ["_markPos", ["_initialRadius", 0], ["_isHelicopter", false]]; scopeName "FindSpawnPos";
    private ["_spawnpos", "_randir", "_extendedRadius", "_randis", "_houses", "_supplies", "_vehicles", "_isFlat", "_danger", "_foundIt", "_tries"];
    private ["_distanceToNearestVehicle", "_distanceFromBuilding", "_allowedSteepness"];

    _distanceFromBuilding = 10;
    _allowedSteepness = 0.5;

    _distanceToNearestVehicle = 9;
    if (_isHelicopter) then {
        _distanceToNearestVehicle = 12;
        _allowedSteepness = 0.25; };


    _spawnpos = [];
    _foundIt = false;
    _tries = 0;
    _extendedRadius = 0;

    while { true } do {
        scopeName "SpawnPosGen";

        _randir = floor random 360;
        _randis = _initialRadius + floor random _extendedRadius;
        _spawnpos = [(_markpos select 0) + ((sin _randir) * _randis), (_markpos select 1) + ((cos _randir) * _randis), 0.1];
        _houses = nearestObjects [_spawnpos, ["house", "wall"], 50];
        _supplies = _spawnpos nearSupplies 2;
        _vehicles = nearestObjects [_spawnpos, ["LandVehicle", "AirVehicle", "Man"], 25];
        _isFlat = _spawnpos isFlatEmpty [2, -1, _allowedSteepness, 10, 0, false, objNull];
        _danger = false;
        { if (floor (_spawnpos distance getPos _x) < _distanceFromBuilding) then { _danger = true; };
        } forEach _houses; { if (floor (_spawnpos distance getPos _x) < _distanceToNearestVehicle) then { _danger = true; };
        } forEach _vehicles; { if (floor (_spawnpos distance getPos _x) < _distanceToNearestVehicle) then { _danger = true; };
        } forEach _supplies; if (surfaceIsWater _spawnpos) then { _danger = true; };
        if (count _isFlat < 1) then { _danger = true; };
        if (!_danger) then {
            _foundIt = true;
            breakOut "SpawnPosGen" };

        _tries = _tries + 1;
        _extendedRadius = _extendedRadius + 0.5;
        sleep 0.01; };


    if (!_foundIt) then {
        _spawnPos = []; };


    (_spawnpos) breakOut "FindSpawnPos"; };








cl_Campaigns_Mission_GainedTokensActing_PropIndex = 10;



cl_Campaigns_Mission_LostTokensActing_PropIndex = 11;



cl_Campaigns_Mission_GainedTokensOpposing_PropIndex = 12;



cl_Campaigns_Mission_LostTokensOpposing_PropIndex = 13;













cl_Campaigns_Mission_CreateVehicle = { params ["_class_fields", "_this"]; params ["_vehicleClassName", "_position", "_direction", ["_avoidCollision", false], ["_withCrew", false]]; scopeName "CreateVehicle";
    if (_avoidCollision) then {
        _position = [_position] call Campaigns_Mission_FindSpawnPos; };


    private _vehicle = createVehicle [_vehicleClassName, [_position select 0, _position select 1, 1000]];

    _vehicle setDir _direction;
    _vehicle setPos [_position select 0, _position select 1, 0.1];

    (_class_fields select 7) pushBack _vehicle;

    if (_withCrew) then {
        private _crewGroup = createVehicleCrew _vehicle;
        _class_fields set [8, (_class_fields select 8) + units _crewGroup]; };


    (_vehicle) breakOut "CreateVehicle"; };











cl_Campaigns_Mission_CreateSideVehicle = { params ["_class_fields", "_this"]; params ["_vehicleTypeAlias", "_position", "_direction", "_missionSide", ["_avoidCollision", false], ["_withCrew", false]]; scopeName "CreateSideVehicle";
    private _side = ([_class_fields, [_missionSide]] call cl_Campaigns_Mission_GetActualSide);
    private _vehicleType = ([(_class_fields select 20), [_vehicleTypeAlias, _side]] call cl_Campaigns_VehicleDictionary_GetVehicleType);

    (([_class_fields, [_vehicleType, _position, _direction, _avoidCollision, _withCrew]] call cl_Campaigns_Mission_CreateVehicle)) breakOut "CreateSideVehicle"; };









cl_Campaigns_Mission_CreateVehicleOnMarker = { params ["_class_fields", "_this"]; params ["_vehicleClassName", "_markerName", ["_avoidCollision", false], ["_withCrew", false]]; scopeName "CreateVehicleOnMarker";
    private _position = getMarkerPos _markerName;
    private _direction = markerDir _markerName;

    if (_avoidCollision) then {
        _position = [_position] call Campaigns_Mission_FindSpawnPos; };


    private _vehicle = createVehicle [_vehicleClassName, [_position select 0, _position select 1, 1000]];

    _vehicle setDir _direction;
    _vehicle setPos [_position select 0, _position select 1, 0.1];

    (_class_fields select 7) pushBack _vehicle;

    if (_withCrew) then {
        private _crewGroup = createVehicleCrew _vehicle;
        _class_fields set [8, (_class_fields select 8) + units _crewGroup]; };


    (_vehicle) breakOut "CreateVehicleOnMarker"; };










cl_Campaigns_Mission_CreateSideVehicleOnMarker = { params ["_class_fields", "_this"]; params ["_vehicleTypeAlias", "_markerName", "_missionSide", ["_avoidCollision", false], ["_withCrew", false]]; scopeName "CreateSideVehicleOnMarker";
    private _side = ([_class_fields, [_missionSide]] call cl_Campaigns_Mission_GetActualSide);
    private _vehicleType = ([(_class_fields select 20), [_vehicleTypeAlias, _side]] call cl_Campaigns_VehicleDictionary_GetVehicleType);

    (([_class_fields, [_vehicleType, _markerName, _avoidCollision, _withCrew]] call cl_Campaigns_Mission_CreateVehicleOnMarker)) breakOut "CreateSideVehicleOnMarker"; };










cl_Campaigns_Mission_CreateVehicleInBase = { params ["_class_fields", "_this"]; params ["_vehicleClassName", "_baseMarker", "_missionSide", ["_avoidCollision", false], ["_withCrew", false]]; scopeName "CreateVehicleInBase";
    private _side = ([_class_fields, [_missionSide]] call cl_Campaigns_Mission_GetActualSide);
    private _spawnMarker = ([(_class_fields select 4), [_side, _baseMarker]] call compile ("_this call cl_" + (((_class_fields select 4) select 0) select 0) + "_GetMarkerName"));

    (([_class_fields, [_vehicleClassName, _spawnMarker, _avoidCollision, _withCrew]] call cl_Campaigns_Mission_CreateVehicleOnMarker)) breakOut "CreateVehicleInBase"; };










cl_Campaigns_Mission_CreateSideVehicleInBase = { params ["_class_fields", "_this"]; params ["_vehicleTypeAlias", "_baseMarker", "_missionSide", ["_avoidCollision", false], ["_withCrew", false]]; scopeName "CreateSideVehicleInBase";
    private _side = ([_class_fields, [_missionSide]] call cl_Campaigns_Mission_GetActualSide);
    private _vehicleType = ([(_class_fields select 20), [_vehicleTypeAlias, _side]] call cl_Campaigns_VehicleDictionary_GetVehicleType);
    private _spawnMarker = ([(_class_fields select 4), [_side, _baseMarker]] call compile ("_this call cl_" + (((_class_fields select 4) select 0) select 0) + "_GetMarkerName"));

    (([_class_fields, [_vehicleType, _spawnMarker, _avoidCollision, _withCrew]] call cl_Campaigns_Mission_CreateVehicleOnMarker)) breakOut "CreateSideVehicleInBase"; };








cl_Campaigns_Mission_CreateAiSoldier = { params ["_class_fields", "_this"]; params ["_unitClassName", "_position", "_group"]; scopeName "CreateAiSoldier";
    private _soldier = _group createUnit [_unitClassName, _position, [], 0, "NONE"];
    (_class_fields select 8) pushBack _soldier;

    (_soldier) breakOut "CreateAiSoldier"; };









cl_Campaigns_Mission_CreateSideAiSoldier = { params ["_class_fields", "_this"]; params ["_unitTypeAlias", "_position", "_missionSide", ["_group", grpNull]]; scopeName "CreateSideAiSoldier";
    private _side = ([_class_fields, [_missionSide]] call cl_Campaigns_Mission_GetActualSide);
    private _soldierType = ([(_class_fields select 21), [_unitTypeAlias, _side]] call cl_Campaigns_SoldierDictionary_GetSoldierType);

    if (isNull _group) then {
        _group = createGroup [_side, true]; };


    (([_class_fields, [_soldierType, _position, _group]] call cl_Campaigns_Mission_CreateAiSoldier)) breakOut "CreateSideAiSoldier"; };


















cl_Campaigns_Mission_CreateSideIconMarker = { params ["_class_fields", "_this"]; params ["_missionSide", "_name", "_position", ["_type", "hd_dot"], ["_color", "ColorBlack"], ["_text", ""], ["_alpha", 0.4]]; 
    private _side = ([_class_fields, [_missionSide]] call cl_Campaigns_Mission_GetActualSide);
    private _marker = [_name, _position, _type, _color, _text, _alpha] call Tvtcf_Common_Marker_NewIconMarker;

    ["ClientEventReciever.OnCreateSideMarker", [_side, _marker]] call Tvtcf_Communication_Remote_Invoke; };






















cl_Campaigns_Mission_CreateSideShapeMarker = { params ["_class_fields", "_this"]; params ["_missionSide", "_name", "_position", ["_shape", "RECTANGLE"], ["_size", [50, 50]], ["_direction", 0], ["_color", "ColorBlack"], ["_brush", "Solid"], ["_alpha", 0.4]]; 
    private _side = ([_class_fields, [_missionSide]] call cl_Campaigns_Mission_GetActualSide);
    private _marker = [_name, _position, _shape, _size, _direction, _color, _brush, _alpha] call Tvtcf_Common_Marker_NewShapeMarker;

    ["ClientEventReciever.OnCreateSideMarker", [_side, _marker]] call Tvtcf_Communication_Remote_Invoke; };







cl_Campaigns_Mission_GetActualSide = { params ["_class_fields", "_this"]; params ["_side"]; scopeName "GetActualSide";
    if ((_class_fields select 6) == west) then {
        if (_side == 1) then {
            (west) breakOut "GetActualSide"; } else { 


            (east) breakOut "GetActualSide"; }; } else { 




        if (_side == 1) then {
            (east) breakOut "GetActualSide"; } else { 


            (west) breakOut "GetActualSide"; }; }; };








cl_Campaigns_Mission_GetMissionSide = { params ["_class_fields", "_this"]; params ["_side"]; scopeName "GetMissionSide";
    if (_side == (_class_fields select 6)) then {
        (1) breakOut "GetMissionSide"; };


    (2) breakOut "GetMissionSide"; };






cl_Campaigns_Mission_ShowNotification = { params ["_class_fields", "_this"]; params ["_missionSide", "_text"]; 
    private _side = ([_class_fields, [_missionSide]] call cl_Campaigns_Mission_GetActualSide);

    ["ClientEventReciever.OnShowNotification", [_side, _text]] call Tvtcf_Communication_Remote_Invoke; };





cl_Campaigns_Mission_CountUnitsAliveActing = { params ["_class_fields", "_this"]; scopeName "CountUnitsAliveActing";
    ({ alive _x } count (_class_fields select 22)) breakOut "CountUnitsAliveActing"; };





cl_Campaigns_Mission_CountUnitsAliveOpposing = { params ["_class_fields", "_this"]; scopeName "CountUnitsAliveOpposing";
    ({ alive _x } count (_class_fields select 23)) breakOut "CountUnitsAliveOpposing"; };








cl_Campaigns_Mission_AddAction = { params ["_class_fields", "_this"]; params ["_object", "_title", "_missionSide"]; 
    private _side = ([_class_fields, [_missionSide]] call cl_Campaigns_Mission_GetActualSide);
    ([(_class_fields select 5), [_object, _title, _side]] call cl_Tvtcf_Server_ServerActionHandler_AddAction); };





cl_Campaigns_Mission_DeleteActions = { params ["_class_fields", "_this"]; params ["_actionIds"]; 
    ([(_class_fields select 5), [_actionIds]] call cl_Tvtcf_Server_ServerActionHandler_DeleteActions); };









cl_Campaigns_Mission_Remote_PropIndex = 14;




cl_Campaigns_Mission_InsertionAreasActing_PropIndex = 15;




cl_Campaigns_Mission_InsertionAreasOpposing_PropIndex = 16;



cl_Campaigns_Mission_VisibleMarkersActing_PropIndex = 17;



cl_Campaigns_Mission_VisibleMarkersOpposing_PropIndex = 18;




cl_Campaigns_Mission_StartTimeOfDay_PropIndex = 19;


cl_Campaigns_Mission_VehicleDictionary_PropIndex = 20;


cl_Campaigns_Mission_SoldierDictionary_PropIndex = 21;


cl_Campaigns_Mission_ActingUnits_PropIndex = 22;


cl_Campaigns_Mission_OpposingUnits_PropIndex = 23;


cl_Campaigns_Mission_PrimaryObjectiveActing_PropIndex = 24;


cl_Campaigns_Mission_SecondaryObjectiveActing_PropIndex = 25;


cl_Campaigns_Mission_PrimaryObjectiveOpposing_PropIndex = 26;


cl_Campaigns_Mission_SecondaryObjectiveOpposing_PropIndex = 27;


cl_Campaigns_Mission_PrimaryObjectiveStateActing_PropIndex = 28;


cl_Campaigns_Mission_SecondaryObjectiveStateActing_PropIndex = 29;


cl_Campaigns_Mission_ReturnObjectiveStateActing_PropIndex = 30;


cl_Campaigns_Mission_PrimaryObjectiveStateOpposing_PropIndex = 31;


cl_Campaigns_Mission_SecondaryObjectiveStateOpposing_PropIndex = 32;


cl_Campaigns_Mission_ReturnObjectiveStateOpposing_PropIndex = 33;


cl_Campaigns_Mission_InsertionPointActing_PropIndex = 34;


cl_Campaigns_Mission_InsertionPointOpposing_PropIndex = 35;




cl_Campaigns_Mission_HasEnded_PropIndex = 36;






cl_Campaigns_Mission_Name_PropIndex = 37;


cl_Campaigns_Mission_MissionTimeLimit_PropIndex = 38;


cl_Campaigns_Mission_MissionTimeElapsed_PropIndex = 39;


cl_Campaigns_Mission_RemainingTime_PropIndex = 40;



cl_Campaigns_Mission_HasReturnObjectiveActing_PropIndex = 41;



cl_Campaigns_Mission_HasReturnObjectiveOpposing_PropIndex = 42;








cl_Campaigns_Mission_SetTimeElapsed = { params ["_class_fields", "_this"]; params ["_missionTimeElapsed"]; 
    _class_fields set [39, _missionTimeElapsed];
    _class_fields set [40, (_class_fields select 38) - _missionTimeElapsed]; };






cl_Campaigns_Mission_SetActingSide = { params ["_class_fields", "_this"]; params ["_actingSide"]; 
    if (!(_class_fields select 9)) then {
        _class_fields set [6, _actingSide]; }; };






cl_Campaigns_Mission_Prepare = { params ["_class_fields", "_this"]; params ["_baseMarkersConfig", "_serverActionHandler", "_westlyGroup", "_eastlyGroup", "_gainedTokensActing", "_lostTokensActing", "_gainedTokensOpposing", "_lostTokensOpposing", "_remote"]; 
    _class_fields set [4, _baseMarkersConfig];
    _class_fields set [5, _serverActionHandler];
    _class_fields set [14, _remote];

    if ((_class_fields select 6) == west) then {
        _class_fields set [22, units _westlyGroup];
        _class_fields set [23, units _eastlyGroup]; } else { 


        _class_fields set [22, units _eastlyGroup];
        _class_fields set [23, units _westlyGroup]; };


    _class_fields set [10, _gainedTokensActing];
    _class_fields set [11, _lostTokensActing];
    _class_fields set [12, _gainedTokensOpposing];
    _class_fields set [13, _lostTokensOpposing];

    private _timeToSkip = 24 - daytime + (_class_fields select 19);
    skipTime _timeToSkip;

    ([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_Setup"));
    ([_class_fields, []] call cl_Campaigns_Mission_CreateMissionObjectives);
    _class_fields set [9, true]; };







cl_Campaigns_Mission_GetInsertionAreaMarkers = { params ["_class_fields", "_this"]; params ["_side"]; scopeName "GetInsertionAreaMarkers";
    private ["_missionSide"];

    _missionSide = ([_class_fields, [_side]] call cl_Campaigns_Mission_GetMissionSide);

    if (_missionSide == 1) then {
        ((_class_fields select 15)) breakOut "GetInsertionAreaMarkers"; };


    ((_class_fields select 16)) breakOut "GetInsertionAreaMarkers"; };







cl_Campaigns_Mission_GetVisibleMarkers = { params ["_class_fields", "_this"]; params ["_side"]; scopeName "GetVisibleMarkers";
    private ["_missionSide"];

    _missionSide = ([_class_fields, [_side]] call cl_Campaigns_Mission_GetMissionSide);

    if (_missionSide == 1) then {
        ((_class_fields select 17)) breakOut "GetVisibleMarkers"; };


    ((_class_fields select 18)) breakOut "GetVisibleMarkers"; };







cl_Campaigns_Mission_GetSideHasReturnObjective = { params ["_class_fields", "_this"]; params ["_side"]; scopeName "GetSideHasReturnObjective";
    private ["_missionSide"];

    _missionSide = ([_class_fields, [_side]] call cl_Campaigns_Mission_GetMissionSide);

    if (_missionSide == 1) then {
        ((_class_fields select 41)) breakOut "GetSideHasReturnObjective"; };


    ((_class_fields select 42)) breakOut "GetSideHasReturnObjective"; };






cl_Campaigns_Mission_GetMissionResult = { params ["_class_fields", "_this"]; params ["_side"]; scopeName "GetMissionResult";
    private ["_missionSide", "_secondaryObjectiveName"];

    _missionSide = ([_class_fields, [_side]] call cl_Campaigns_Mission_GetMissionSide);

    if (_missionSide == 1) then {

        _secondaryObjectiveName = "";

        if (!((_class_fields select 25) isEqualTo ["null"])) then {
            _secondaryObjectiveName = ((_class_fields select 25) select 1); };


        (([[["Tvtcf_Common_MissionResultInfo",[]]], [((_class_fields select 24) select 1), (_class_fields select 28), _secondaryObjectiveName, (_class_fields select 29), (_class_fields select 41), (_class_fields select 30), count (_class_fields select 22), { alive _x } count (_class_fields select 22)]] call cl_Tvtcf_Common_MissionResultInfo_constructor)) breakOut "GetMissionResult"; } else { 



        _secondaryObjectiveName = "";

        if (!((_class_fields select 27) isEqualTo ["null"])) then {
            _secondaryObjectiveName = ((_class_fields select 27) select 1); };


        (([[["Tvtcf_Common_MissionResultInfo",[]]], [((_class_fields select 26) select 1), (_class_fields select 31), _secondaryObjectiveName, (_class_fields select 32), (_class_fields select 42), (_class_fields select 33), count (_class_fields select 23), { alive _x } count (_class_fields select 23)]] call cl_Tvtcf_Common_MissionResultInfo_constructor)) breakOut "GetMissionResult"; }; };




cl_Campaigns_Mission_GetBriefingInfo = { params ["_class_fields", "_this"]; params ["_side"]; scopeName "GetBriefingInfo";
    private ["_missionSide"];

    _missionSide = ([_class_fields, [_side]] call cl_Campaigns_Mission_GetMissionSide);

    if (_missionSide == 1) then {
        (([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_AddBriefingActing"))) breakOut "GetBriefingInfo"; };


    if (_missionSide == 2) then {
        (([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_AddBriefingOpposing"))) breakOut "GetBriefingInfo"; };


    ("") breakOut "GetBriefingInfo"; };



cl_Campaigns_Mission_GetMissionObjective = { params ["_class_fields", "_this"]; params ["_side", "_prio"]; scopeName "GetMissionObjective";
    private ["_missionSide"];

    _missionSide = ([_class_fields, [_side]] call cl_Campaigns_Mission_GetMissionSide);

    if (_missionSide == 1 && _prio == 1) then {
        ((_class_fields select 24)) breakOut "GetMissionObjective"; };

    if (_missionSide == 1 && _prio == 2) then {
        ((_class_fields select 25)) breakOut "GetMissionObjective"; };

    if (_missionSide == 1 && _prio == 3 && (_class_fields select 41)) then {
        (([[["Tvtcf_Common_MissionObjective",[]]], ["Return to insertion point", "Return to the insertion point."]] call cl_Tvtcf_Common_MissionObjective_constructor)) breakOut "GetMissionObjective"; };


    if (_missionSide == 2 && _prio == 1) then {
        ((_class_fields select 26)) breakOut "GetMissionObjective"; };

    if (_missionSide == 2 && _prio == 2) then {
        ((_class_fields select 27)) breakOut "GetMissionObjective"; };

    if (_missionSide == 2 && _prio == 3 && (_class_fields select 42)) then {
        (([[["Tvtcf_Common_MissionObjective",[]]], ["Return to insertion point", "Return to the insertion point."]] call cl_Tvtcf_Common_MissionObjective_constructor)) breakOut "GetMissionObjective"; };


    (["null"]) breakOut "GetMissionObjective"; };








cl_Campaigns_Mission_CheckObjectiveState = { params ["_class_fields", "_this"]; params ["_side", "_prio"]; scopeName "CheckObjectiveState";
    private ["_missionSide", "_state"];

    _missionSide = ([_class_fields, [_side]] call cl_Campaigns_Mission_GetMissionSide);

    if (_missionSide == 1) then {

        if (_prio == 1) then {

            if ((_class_fields select 28) == 1) then {
                _state = ([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_CheckPrimaryObjectiveStateActing"));

                if (_state != 1) then {
                    _class_fields set [28, _state];
                    (_state) breakOut "CheckObjectiveState"; }; } else { 



                ((_class_fields select 28)) breakOut "CheckObjectiveState"; }; };


        if (_prio == 2) then {
            if ((_class_fields select 29) == 1) then {
                _state = ([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_CheckSecondaryObjectiveStateActing"));

                if (_state != 1) then {
                    _class_fields set [29, _state];
                    (_state) breakOut "CheckObjectiveState"; }; } else { 



                ((_class_fields select 29)) breakOut "CheckObjectiveState"; }; };


        if (_prio == 3) then {
            if ((_class_fields select 30) == 1) then {
                _state = ([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_CheckReturnObjectiveStateActing"));

                if (_state != 1) then {
                    _class_fields set [30, _state];
                    (_state) breakOut "CheckObjectiveState"; }; } else { 



                ((_class_fields select 30)) breakOut "CheckObjectiveState"; }; }; } else { 





        if (_prio == 1) then {

            if ((_class_fields select 31) == 1) then {
                _state = ([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_CheckPrimaryObjectiveStateOpposing"));

                if (_state != 1) then {
                    _class_fields set [31, _state];
                    (_state) breakOut "CheckObjectiveState"; }; } else { 



                ((_class_fields select 31)) breakOut "CheckObjectiveState"; }; };


        if (_prio == 2) then {
            if ((_class_fields select 32) == 1) then {
                _state = ([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_CheckSecondaryObjectiveStateOpposing"));

                if (_state != 1) then {
                    _class_fields set [32, _state];
                    (_state) breakOut "CheckObjectiveState"; }; } else { 



                ((_class_fields select 32)) breakOut "CheckObjectiveState"; }; };


        if (_prio == 3) then {
            if ((_class_fields select 33) == 1) then {
                _state = ([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_CheckReturnObjectiveStateOpposing"));

                if (_state != 1) then {
                    _class_fields set [33, _state];
                    (_state) breakOut "CheckObjectiveState"; }; } else { 



                ((_class_fields select 33)) breakOut "CheckObjectiveState"; }; }; };




    (1) breakOut "CheckObjectiveState"; };









cl_Campaigns_Mission_InsertGroup = { params ["_class_fields", "_this"]; params ["_group", "_position"]; scopeName "InsertGroup";
    private ["_missionSide", "_e"];

    _missionSide = ([_class_fields, [side _group]] call cl_Campaigns_Mission_GetMissionSide);

    if (_missionSide == 1) then {
        _class_fields set [22, units _group];

        _e = ([[["Tvtcf_Server_InsertionEventArgs",[]]], [side _group, _position]] call cl_Tvtcf_Server_InsertionEventArgs_constructor);
        ([_class_fields, [_e]] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_OnActingGroupInserted")); } else { 


        _class_fields set [23, units _group];

        _e = ([[["Tvtcf_Server_InsertionEventArgs",[]]], [side _group, _position]] call cl_Tvtcf_Server_InsertionEventArgs_constructor);
        ([_class_fields, [_e]] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_OnOpposingGroupInserted")); };


    (_e) breakOut "InsertGroup"; };







cl_Campaigns_Mission_OnAction = { params ["_class_fields", "_this"]; params ["_actionId", "_target", "_actor"]; };









cl_Campaigns_Mission_Setup = { params ["_class_fields", "_this"]; };







cl_Campaigns_Mission_AddBriefingActing = { params ["_class_fields", "_this"]; scopeName "AddBriefingActing";
    private ["_primaryObjective"];

    _primaryObjective = ([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_AddPrimaryObjectiveActing"));

    if (!(_primaryObjective isEqualTo ["null"])) then {
        ((_primaryObjective select 2)) breakOut "AddBriefingActing"; };


    ("Carry out the mission.") breakOut "AddBriefingActing"; };







cl_Campaigns_Mission_AddBriefingOpposing = { params ["_class_fields", "_this"]; scopeName "AddBriefingOpposing";
    private ["_primaryObjective"];

    _primaryObjective = ([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_AddPrimaryObjectiveOpposing"));

    if (!(_primaryObjective isEqualTo ["null"])) then {
        ((_primaryObjective select 2)) breakOut "AddBriefingOpposing"; };


    ("Carry out the mission.") breakOut "AddBriefingOpposing"; };








cl_Campaigns_Mission_AddPrimaryObjectiveActing = { params ["_class_fields", "_this"]; scopeName "AddPrimaryObjectiveActing";
    (([[["Tvtcf_Common_MissionObjective",[]]], ["Survive."]] call cl_Tvtcf_Common_MissionObjective_constructor)) breakOut "AddPrimaryObjectiveActing"; };








cl_Campaigns_Mission_AddSecondaryObjectiveActing = { params ["_class_fields", "_this"]; scopeName "AddSecondaryObjectiveActing";
    (["null"]) breakOut "AddSecondaryObjectiveActing"; };








cl_Campaigns_Mission_AddPrimaryObjectiveOpposing = { params ["_class_fields", "_this"]; scopeName "AddPrimaryObjectiveOpposing";
    (([[["Tvtcf_Common_MissionObjective",[]]], ["Survive."]] call cl_Tvtcf_Common_MissionObjective_constructor)) breakOut "AddPrimaryObjectiveOpposing"; };








cl_Campaigns_Mission_AddSecondaryObjectiveOpposing = { params ["_class_fields", "_this"]; scopeName "AddSecondaryObjectiveOpposing";
    (["null"]) breakOut "AddSecondaryObjectiveOpposing"; };








cl_Campaigns_Mission_OnActingGroupInserted = { params ["_class_fields", "_this"]; params ["_e"]; 
    _class_fields set [34, (_e select 2)]; };








cl_Campaigns_Mission_OnOpposingGroupInserted = { params ["_class_fields", "_this"]; params ["_e"]; 
    _class_fields set [35, (_e select 2)]; };









cl_Campaigns_Mission_CheckPrimaryObjectiveStateActing = { params ["_class_fields", "_this"]; scopeName "CheckPrimaryObjectiveStateActing";
    private _unitsAlive = (([_class_fields, []] call cl_Campaigns_Mission_CountUnitsAliveActing)) > 0;


    if (!_unitsAlive) then {
        (3) breakOut "CheckPrimaryObjectiveStateActing"; };



    if ((_class_fields select 36) && (([_class_fields, []] call cl_Campaigns_Mission_CountUnitsAliveActing)) > 0) then {
        (4) breakOut "CheckPrimaryObjectiveStateActing"; };



    (1) breakOut "CheckPrimaryObjectiveStateActing"; };









cl_Campaigns_Mission_CheckSecondaryObjectiveStateActing = { params ["_class_fields", "_this"]; scopeName "CheckSecondaryObjectiveStateActing";
    (1) breakOut "CheckSecondaryObjectiveStateActing"; };









cl_Campaigns_Mission_CheckReturnObjectiveStateActing = { params ["_class_fields", "_this"]; scopeName "CheckReturnObjectiveStateActing";
    if ((_class_fields select 41)) then {

        private _primaryOrSecondaryObjectiveCompleted = false;
        private _aliveUnitsCount = 0;
        private _allUnitsPresent = false;

        _primaryOrSecondaryObjectiveCompleted = (_class_fields select 28) != 1 || (_class_fields select 29) != 1;
        _aliveUnitsCount = ([_class_fields, []] call cl_Campaigns_Mission_CountUnitsAliveActing);
        _allUnitsPresent = ({ alive _x && _x distance (_class_fields select 34) < 25 } count (_class_fields select 22)) == _aliveUnitsCount;

        diag_log ("GURGEL: _primaryOrSecondaryObjectiveCompleted: " + str _primaryOrSecondaryObjectiveCompleted + "; _aliveUnitsCount: " + str _aliveUnitsCount + "; _allUnitsPresent: " + str _allUnitsPresent);

        if (_primaryOrSecondaryObjectiveCompleted && _aliveUnitsCount > 0 && _allUnitsPresent) then {

            (4) breakOut "CheckReturnObjectiveStateActing"; }; };



    (1) breakOut "CheckReturnObjectiveStateActing"; };









cl_Campaigns_Mission_CheckPrimaryObjectiveStateOpposing = { params ["_class_fields", "_this"]; scopeName "CheckPrimaryObjectiveStateOpposing";
    private _unitsAlive = (([_class_fields, []] call cl_Campaigns_Mission_CountUnitsAliveOpposing)) > 0;


    if (!_unitsAlive) then {
        (3) breakOut "CheckPrimaryObjectiveStateOpposing"; };



    if ((_class_fields select 36) && (([_class_fields, []] call cl_Campaigns_Mission_CountUnitsAliveOpposing)) > 0) then {
        (4) breakOut "CheckPrimaryObjectiveStateOpposing"; };



    (1) breakOut "CheckPrimaryObjectiveStateOpposing"; };









cl_Campaigns_Mission_CheckSecondaryObjectiveStateOpposing = { params ["_class_fields", "_this"]; scopeName "CheckSecondaryObjectiveStateOpposing";
    (1) breakOut "CheckSecondaryObjectiveStateOpposing"; };









cl_Campaigns_Mission_CheckReturnObjectiveStateOpposing = { params ["_class_fields", "_this"]; scopeName "CheckReturnObjectiveStateOpposing";
    if ((_class_fields select 42)) then {

        private _primaryOrSecondaryObjectiveCompleted = false;
        private _aliveUnitsCount = 0;
        private _allUnitsPresent = false;

        _primaryOrSecondaryObjectiveCompleted = (_class_fields select 31) != 1 || (_class_fields select 32) != 1;
        _aliveUnitsCount = ([_class_fields, []] call cl_Campaigns_Mission_CountUnitsAliveOpposing);
        _allUnitsPresent = ({ alive _x && _x distance (_class_fields select 35) < 25 } count (_class_fields select 23)) == _aliveUnitsCount;

        diag_log ("GURGEL: _primaryOrSecondaryObjectiveCompleted: " + str _primaryOrSecondaryObjectiveCompleted + "; _aliveUnitsCount: " + str _aliveUnitsCount + "; _allUnitsPresent: " + str _allUnitsPresent);

        if (_primaryOrSecondaryObjectiveCompleted && _aliveUnitsCount > 0 && _allUnitsPresent) then {

            (4) breakOut "CheckReturnObjectiveStateOpposing"; }; };



    (1) breakOut "CheckReturnObjectiveStateOpposing"; };









cl_Campaigns_Mission_GetMissionIsCompleteActing = { params ["_class_fields", "_this"]; scopeName "GetMissionIsCompleteActing";
    private ["_primaryObjective", "_secondaryObjective"];

    _primaryObjective = (_class_fields select 24);
    _secondaryObjective = (_class_fields select 25);

    private _primaryExists = !(_primaryObjective isEqualTo ["null"]);
    private _secondaryExists = !(_secondaryObjective isEqualTo ["null"]);
    private _primaryCompleted = _primaryExists && (_class_fields select 28) != 1;
    private _secondaryCompleted = _secondaryExists && (_class_fields select 29) != 1;

    diag_log ("COMPLETE: _primaryExists: " + str _primaryExists + "; _primaryCompleted: " + str _primaryCompleted);
    diag_log ("COMPLETE: _secondaryExists: " + str _secondaryExists + "; _secondaryCompleted: " + str _secondaryCompleted);



    if ((_class_fields select 41)) then {

        private _returnCompleted = (_class_fields select 30) != 1;

        if (_returnCompleted && (_primaryCompleted || _secondaryCompleted)) then {
            (true) breakOut "GetMissionIsCompleteActing"; }; } else { 






        if (_primaryExists && !_primaryCompleted) then {
            (false) breakOut "GetMissionIsCompleteActing"; };

        if (_secondaryExists && !_secondaryCompleted) then {
            (false) breakOut "GetMissionIsCompleteActing"; };


        (true) breakOut "GetMissionIsCompleteActing"; };


    (false) breakOut "GetMissionIsCompleteActing"; };









cl_Campaigns_Mission_GetMissionIsCompleteOpposing = { params ["_class_fields", "_this"]; scopeName "GetMissionIsCompleteOpposing";
    private ["_primaryObjective", "_secondaryObjective"];

    _primaryObjective = (_class_fields select 26);
    _secondaryObjective = (_class_fields select 27);

    private _primaryExists = !(_primaryObjective isEqualTo ["null"]);
    private _secondaryExists = !(_secondaryObjective isEqualTo ["null"]);
    private _primaryCompleted = _primaryExists && (_class_fields select 31) != 1;
    private _secondaryCompleted = _secondaryExists && (_class_fields select 32) != 1;

    diag_log ("GURGEL: _primaryExists: " + str _primaryExists + "; _primaryCompleted: " + str _primaryCompleted);
    diag_log ("GURGEL: _secondaryExists: " + str _secondaryExists + "; _secondaryCompleted: " + str _secondaryCompleted);



    if ((_class_fields select 42)) then {

        private _returnCompleted = (_class_fields select 33) != 1;

        if (_returnCompleted && (_primaryCompleted || _secondaryCompleted)) then {
            (true) breakOut "GetMissionIsCompleteOpposing"; }; } else { 






        if (_primaryExists && !_primaryCompleted) then {
            (false) breakOut "GetMissionIsCompleteOpposing"; };


        if (_secondaryExists && !_secondaryCompleted) then {
            (false) breakOut "GetMissionIsCompleteOpposing"; };


        (true) breakOut "GetMissionIsCompleteOpposing"; };


    (false) breakOut "GetMissionIsCompleteOpposing"; };






cl_Campaigns_Mission_OnEachIteration = { params ["_class_fields", "_this"]; };






cl_Campaigns_Mission_CountPlayersAliveOnSide = { params ["_class_fields", "_this"]; params ["_missionSide"]; scopeName "CountPlayersAliveOnSide";
    private _count = 0;
    private _units = (_class_fields select 22);

    if (_missionSide == 2) then {
        _units = (_class_fields select 23); };


    {
        if (alive _x && isPlayer _x) then {
            _count = _count + 1; };
    } forEach 
    _units;

    (_count) breakOut "CountPlayersAliveOnSide"; };






cl_Campaigns_Mission_ShouldMissionShutDown = { params ["_class_fields", "_this"]; scopeName "ShouldMissionShutDown";
    private _completeActing = ([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_GetMissionIsCompleteActing"));
    private _completeOpposing = ([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_GetMissionIsCompleteOpposing"));

    if (_completeActing && _completeOpposing) then {
        (true) breakOut "ShouldMissionShutDown"; };


    private _aliveOpposingPlayers = (([_class_fields, [2]] call cl_Campaigns_Mission_CountPlayersAliveOnSide)) > 0;
    diag_log ("GURGEL: _aliveOpposingPlayers: " + str _aliveOpposingPlayers);
    if (_completeActing && !_aliveOpposingPlayers) then {
        (true) breakOut "ShouldMissionShutDown"; };


    private _aliveActingPlayers = (([_class_fields, [1]] call cl_Campaigns_Mission_CountPlayersAliveOnSide)) > 0;
    diag_log ("GURGEL: _aliveActingPlayers: " + str _aliveActingPlayers);
    if (_completeOpposing && !_aliveActingPlayers) then {
        (true) breakOut "ShouldMissionShutDown"; };


    (false) breakOut "ShouldMissionShutDown"; };



cl_Campaigns_Mission_Cancel = { params ["_class_fields", "_this"];
    _class_fields set [36, true];
    ([_class_fields, []] call cl_Sqx_Services_Service_Cancel); };









cl_Campaigns_Mission_Run = { params ["_class_fields", "_this"];
    while { !(_class_fields select 3) } do {

        if (([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_ShouldMissionShutDown"))) then {
            ([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_Cancel")); };


        ([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_OnEachIteration"));

        sleep 1; };


    ([_class_fields, []] call cl_Sqx_Services_Service_Run); };







cl_Campaigns_Mission_Cleanup = { params ["_class_fields", "_this"]; };








cl_Campaigns_Mission_Dispose = { params ["_class_fields", "_this"];


    {
        deleteVehicle _x;
    } forEach (_class_fields select 8);



    {
        deleteVehicle _x;
    } forEach (_class_fields select 7);



    private _mapCenterPos = [worldSize / 2, worldSize / 2];
    private _mapCenterPosDistance = (worldSize) * 1.475;
    private _list = nearestObjects [_mapCenterPos, ["WeaponHolderSimulated", "GroundWeaponHolder"], _mapCenterPosDistance];

    {
        deleteVehicle _x;
    } forEach _list;


    ([_class_fields, []] call compile ("_this call cl_" + ((_class_fields select 0) select 0) + "_Cleanup")); };