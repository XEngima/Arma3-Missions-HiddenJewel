



















cl_Tvtcf_Client_CameraHandler_constructor = { params ["_class_fields", "_this"]; params ["_clientMessageHandler"]; 

    _class_fields set [2, _clientMessageHandler];
    _class_fields set [1, objNull]; _class_fields };




cl_Tvtcf_Client_CameraHandler_UpdateDeathCamera = { params ["_class_fields", "_this"];
    if (Tvtcf_Client_Statics_ClientState_IsAlive) then {
        ([_class_fields, []] call cl_Tvtcf_Client_CameraHandler_ResetPlayerCamera); } else { 


        ([_class_fields, []] call cl_Tvtcf_Client_CameraHandler_SetDeathCamera); }; };





cl_Tvtcf_Client_CameraHandler_SetDeathCamera = { params ["_class_fields", "_this"]; scopeName "SetDeathCamera";

    if (isNull (_class_fields select 1) || { !(cameraOn == (_class_fields select 1)) || !(alive (_class_fields select 1)) }) then {

        private _missionUnits = (call Tvtcf_Communication_PublicVariableHandler_GetInsertedWestlyUnits) + (call Tvtcf_Communication_PublicVariableHandler_GetInsertedEastlyUnits);


        {
            if (alive _x && isPlayer _x && (side group _x == playerSide) && _x != player) then {
                switchCamera _x;
                _class_fields set [1, _x];
                ([(_class_fields select 2), ["Following " + name _x]] call cl_Tvtcf_Client_ClientMessageHandler_ShowMessage);
                 breakOut "SetDeathCamera"; };
        } forEach 
        _missionUnits;


        {
            if (alive _x && isPlayer _x && (side group _x != playerSide) && _x != player) then {
                switchCamera _x;
                _class_fields set [1, _x];
                ([(_class_fields select 2), ["Following " + name _x]] call cl_Tvtcf_Client_ClientMessageHandler_ShowMessage);
                 breakOut "SetDeathCamera"; };
        } forEach 
        _missionUnits;


        {
            if (alive _x && (side group _x == playerSide) && _x != player) then {
                switchCamera _x;
                _class_fields set [1, _x];
                ([(_class_fields select 2), ["Following " + name _x]] call cl_Tvtcf_Client_ClientMessageHandler_ShowMessage);
                 breakOut "SetDeathCamera"; };
        } forEach 
        _missionUnits;


        {
            if (alive _x && _x != player) then {
                switchCamera _x;
                _class_fields set [1, _x];
                ([(_class_fields select 2), ["Following " + name _x]] call cl_Tvtcf_Client_ClientMessageHandler_ShowMessage);
                 breakOut "SetDeathCamera"; };
        } forEach 
        _missionUnits; }; };




cl_Tvtcf_Client_CameraHandler_ResetPlayerCamera = { params ["_class_fields", "_this"];
    switchCamera player;
    _class_fields set [1, objNull]; };