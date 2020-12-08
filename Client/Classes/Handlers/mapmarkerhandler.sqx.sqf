


















cl_Tvtcf_Client_MapMarkerHandler_constructor = { params ["_class_fields", "_this"]; params ["_baseMarkersConfig"]; 

    _class_fields set [1, _baseMarkersConfig];
    _class_fields set [2, []];
    _class_fields set [3, []];
    _class_fields set [6, false];
    _class_fields set [4, []];
    _class_fields set [5, ""]; _class_fields };


cl_Tvtcf_Client_MapMarkerHandler_InsertionMapPosition_PropIndex = 4;

cl_Tvtcf_Client_MapMarkerHandler_BaseMarker_PropIndex = 5;

cl_Tvtcf_Client_MapMarkerHandler_MissionHasReturnObjective_PropIndex = 6;


cl_Tvtcf_Client_MapMarkerHandler_RemoveInsertionMarkers = { params ["_class_fields", "_this"];
    {
        deleteMarkerLocal _x;
    } forEach (_class_fields select 2);

    _class_fields set [2, []]; };



cl_Tvtcf_Client_MapMarkerHandler_AddInsertionMarker = { params ["_class_fields", "_this"]; params ["_position"]; 
    ([_class_fields, []] call cl_Tvtcf_Client_MapMarkerHandler_RemoveInsertionMarkers);

    private _marker = createMarkerLocal ["_extractionMarkerLocal", _position];
    _marker setMarkerShapeLocal "ICON";
    _marker setMarkerTypeLocal "mil_start";

    (_class_fields select 3) pushBack _marker; };



cl_Tvtcf_Client_MapMarkerHandler_AddMarker = { params ["_class_fields", "_this"]; params ["_markerInfo"]; 
    private _marker = createMarkerLocal [(_markerInfo select 1), (_markerInfo select 2)];
    _marker setMarkerShapeLocal (_markerInfo select 3);
    _marker setMarkerSizeLocal (_markerInfo select 4);
    _marker setMarkerDirLocal (_markerInfo select 5);
    _marker setMarkerTypeLocal (_markerInfo select 6);
    _marker setMarkerColorLocal (_markerInfo select 7);
    _marker setMarkerBrushLocal (_markerInfo select 8);
    _marker setMarkerTextLocal (_markerInfo select 9);
    _marker setMarkerAlphaLocal (_markerInfo select 10);

    (_class_fields select 3) pushBack _marker; };



cl_Tvtcf_Client_MapMarkerHandler_CleanUpAllMarkers = { params ["_class_fields", "_this"];


    if ((_class_fields select 5) != "") then {
        deleteMarkerLocal (_class_fields select 5); };


    ([_class_fields, []] call cl_Tvtcf_Client_MapMarkerHandler_RemoveInsertionMarkers);

    {
        deleteMarkerLocal _x;
    } forEach (_class_fields select 3);

    _class_fields set [3, []]; };



cl_Tvtcf_Client_MapMarkerHandler_UpdateMarkers = { params ["_class_fields", "_this"]; params ["_missionMarkersInfo"]; 
    _class_fields set [6,([_missionMarkersInfo, [playerSide]] call cl_Tvtcf_Common_MissionMarkersInfo_CheckUseExtractionMarker)];



    private _startMarkerColor = "ColorBlack";
    private _startMarkers = [];

    {
        if ((_x select 2) == playerSide) then {

            private _name = (_x select 1) + "_local";
            private _pos = getMarkerPos (_x select 1);

            private _marker = createMarkerLocal [_name, _pos];
            (_class_fields select 2) pushBack _marker;
            _startMarkers pushBack _marker;

            _marker setMarkerShapeLocal (markerShape (_x select 1));
            _marker setMarkerSizeLocal (markerSize (_x select 1));
            _marker setMarkerDirLocal (markerDir (_x select 1));
            _marker setMarkerColorLocal _startMarkerColor; };
    } forEach (

    _missionMarkersInfo select 1);



    private _respawnMarker = ([(_class_fields select 1), [playerSide, 1]] call compile ("_this call cl_" + (((_class_fields select 1) select 0) select 0) + "_GetMarkerName"));
    _class_fields set [5, createMarkerLocal ["_baseMarkerLocal", getMarkerPos _respawnMarker]];
    (_class_fields select 5) setMarkerTypeLocal "b_hq";



    private _pos = [0, 0, 0];

    if (count _startMarkers > 0) then {
        _pos = [_startMarkers] call Tvtcf_Common_Functions_FindClosestToMarkersPos; } else { 


        private _respawnMarker = ([(_class_fields select 1), [playerSide, 1]] call compile ("_this call cl_" + (((_class_fields select 1) select 0) select 0) + "_GetMarkerName"));
        _pos = getMarkerPos _respawnMarker; };


    _class_fields set [4, _pos];



    {
        if ((_x select 2) == playerSide) then {
            private _name = (_x select 1) + "_local";
            private _pos = getMarkerPos (_x select 1);

            private _marker = createMarkerLocal [_name, _pos];
            (_class_fields select 3) pushBack _marker;

            _marker setMarkerShapeLocal (markerShape (_x select 1));
            _marker setMarkerSizeLocal (markerSize (_x select 1));
            _marker setMarkerDirLocal (markerDir (_x select 1));
            _marker setMarkerColorLocal (markerColor (_x select 1));
            _marker setMarkerBrushLocal (markerBrush (_x select 1));
            _marker setMarkerTypeLocal (markerType (_x select 1));
            _marker setMarkerTextLocal (markerText (_x select 1)); };
    } forEach (
    _missionMarkersInfo select 2); };