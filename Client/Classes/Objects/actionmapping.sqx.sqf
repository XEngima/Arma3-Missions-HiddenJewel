













cl_Tvtcf_Client_ActionMapping_constructor = { params ["_class_fields", "_this"]; params ["_serverActionId", "_clientActionId", "_target"]; 

    _class_fields set [1, _serverActionId];
    _class_fields set [2, _clientActionId];
    _class_fields set [3, _target]; _class_fields };


cl_Tvtcf_Client_ActionMapping_ServerActionId_PropIndex = 1;

cl_Tvtcf_Client_ActionMapping_ClientActionId_PropIndex = 2;

cl_Tvtcf_Client_ActionMapping_Target_PropIndex = 3;