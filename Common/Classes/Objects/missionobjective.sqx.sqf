













cl_Tvtcf_Common_MissionObjective_constructor = { params ["_class_fields", "_this"]; params ["_shortDescription", ["_fullDescription", ""]]; 

    _class_fields set [1, _shortDescription];
    _class_fields set [2, _fullDescription];

    if (_fullDescription == "") then {
        _class_fields set [2, _shortDescription]; }; _class_fields };



cl_Tvtcf_Common_MissionObjective_ShortDescription_PropIndex = 1;

cl_Tvtcf_Common_MissionObjective_FullDescription_PropIndex = 2;