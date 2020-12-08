















cl_Tvtcf_Common_BaseMarkersConfig_constructor = { params ["_class_fields", "_this"];

    _class_fields set [1, [
    ([[["Tvtcf_Common_BaseMarkerInfo",[]]], [west, 1, "respawn_west"]] call cl_Tvtcf_Common_BaseMarkerInfo_constructor), 
    ([[["Tvtcf_Common_BaseMarkerInfo",[]]], [west, 2, "base_west_AmmoCrateMarker"]] call cl_Tvtcf_Common_BaseMarkerInfo_constructor), 
    ([[["Tvtcf_Common_BaseMarkerInfo",[]]], [west, 3, "base_west_NavalMarker"]] call cl_Tvtcf_Common_BaseMarkerInfo_constructor), 
    ([[["Tvtcf_Common_BaseMarkerInfo",[]]], [west, 4, "base_west_LandVehicleMarker"]] call cl_Tvtcf_Common_BaseMarkerInfo_constructor), 
    ([[["Tvtcf_Common_BaseMarkerInfo",[]]], [east, 1, "respawn_east"]] call cl_Tvtcf_Common_BaseMarkerInfo_constructor), 
    ([[["Tvtcf_Common_BaseMarkerInfo",[]]], [east, 2, "base_east_AmmoCrateMarker"]] call cl_Tvtcf_Common_BaseMarkerInfo_constructor), 
    ([[["Tvtcf_Common_BaseMarkerInfo",[]]], [east, 3, "base_east_NavalMarker"]] call cl_Tvtcf_Common_BaseMarkerInfo_constructor), 
    ([[["Tvtcf_Common_BaseMarkerInfo",[]]], [east, 4, "base_east_LandVehicleMarker"]] call cl_Tvtcf_Common_BaseMarkerInfo_constructor)]]; _class_fields };




cl_Tvtcf_Common_BaseMarkersConfig_GetMarkerName = { params ["_class_fields", "_this"]; params ["_side", "_baseMarker"]; scopeName "GetMarkerName";
    {
        if ((_x select 1) == _side && (_x select 2) == _baseMarker) then {
            ((_x select 3)) breakOut "GetMarkerName"; };
    } forEach 
    (_class_fields select 1);

    ("") breakOut "GetMarkerName"; };