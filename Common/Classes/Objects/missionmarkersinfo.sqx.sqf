













cl_Tvtcf_Common_MissionMarkersInfo_constructor = { params ["_class_fields", "_this"]; params ["_startMarkers", "_markers", "_westUseExtractionMarker", "_eastUseExtractionMarker"]; 

    _class_fields set [1, _startMarkers];
    _class_fields set [2, _markers];
    _class_fields set [3, _westUseExtractionMarker];
    _class_fields set [4, _eastUseExtractionMarker]; _class_fields };


cl_Tvtcf_Common_MissionMarkersInfo_StartMarkers_PropIndex = 1;

cl_Tvtcf_Common_MissionMarkersInfo_Markers_PropIndex = 2;

cl_Tvtcf_Common_MissionMarkersInfo_WestUseExtractionMarker_PropIndex = 3;

cl_Tvtcf_Common_MissionMarkersInfo_EastUseExtractionMarker_PropIndex = 4;


cl_Tvtcf_Common_MissionMarkersInfo_GetStartMarkersBySide = { params ["_class_fields", "_this"]; params ["_side"]; scopeName "GetStartMarkersBySide";
    private ["_markers"];

    _markers = [];

    {
        if ((_x select 2) == _side) then {
            _markers pushBack (_x select 1); };
    } forEach (
    _class_fields select 1);

    (_markers) breakOut "GetStartMarkersBySide"; };



cl_Tvtcf_Common_MissionMarkersInfo_CheckUseExtractionMarker = { params ["_class_fields", "_this"]; params ["_side"]; scopeName "CheckUseExtractionMarker";
    if (_side == west) then {
        ((_class_fields select 3)) breakOut "CheckUseExtractionMarker"; } else { 


        ((_class_fields select 4)) breakOut "CheckUseExtractionMarker"; }; };