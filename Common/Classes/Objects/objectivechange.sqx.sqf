













cl_Tvtcf_Common_ObjectiveChange_constructor = { params ["_class_fields", "_this"]; params ["_side", "_prio", "_state"]; 

    _class_fields set [1, _side];
    _class_fields set [2, _prio];
    _class_fields set [3, _state]; _class_fields };


cl_Tvtcf_Common_ObjectiveChange_Side_PropIndex = 1;

cl_Tvtcf_Common_ObjectiveChange_Prio_PropIndex = 2;

cl_Tvtcf_Common_ObjectiveChange_State_PropIndex = 3;