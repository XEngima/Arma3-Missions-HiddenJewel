









cl_Tvtcf_Client_ClientMessageHandler_constructor = { _this select 0 };




cl_Tvtcf_Client_ClientMessageHandler_ShowHint = { params ["_class_fields", "_this"]; params ["_message", ["_address", objNull]]; 
    if ((typeName _address == "OBJECT") && { isNull _address }) then {
        hint _message; } else { 


        if ((typeName _address == "OBJECT") && { _address == player }) then {
            hint _message; };

        if (typeName _address == "Group" && { _address == group player }) then {
            hint _message; };

        if (typeName _address == "Side" && { _address == side player }) then {
            hint _message; }; }; };







cl_Tvtcf_Client_ClientMessageHandler_ShowMessage = { params ["_class_fields", "_this"]; params ["_message", ["_address", objNull]]; 
    if (isNull _address) then {
        titleText [_message, "PLAIN"]; } else { 


        if ((typeName _address == "OBJECT") && { _address == player }) then {
            titleText [_message, "PLAIN"]; };


        if (typeName _address == "Group" && { _address == group player }) then {
            titleText [_message, "PLAIN"]; };

        if (typeName _address == "Side" && { _address == side player }) then {
            titleText [_message, "PLAIN"]; }; }; };







cl_Tvtcf_Client_ClientMessageHandler_ShowSubTitle = { params ["_class_fields", "_this"]; params ["_message", ["_address", objNull]]; 
    if (isNull _address) then {
        titleText [_message, "PLAIN DOWN"]; } else { 


        if ((typeName _address == "OBJECT") && { _address == player }) then {
            titleText [_message, "PLAIN DOWN"]; };

        if (typeName _address == "Group" && { _address == group player }) then {
            titleText [_message, "PLAIN DOWN"]; };

        if (typeName _address == "Side" && { _address == side player }) then {
            titleText [_message, "PLAIN DOWN"]; }; }; };







cl_Tvtcf_Client_ClientMessageHandler_ShowTaskInfo = { params ["_class_fields", "_this"]; params ["_message", ["_address", objNull]]; 
    if (isNull _address) then {
        ["TaskSucceeded", ["", _message]] call BIS_fnc_showNotification; } else { 


        if ((typeName _address == "OBJECT") && { _address == player }) then {
            ["TaskSucceeded", ["", _message]] call BIS_fnc_showNotification; };

        if (typeName _address == "Group" && { _address == group player }) then {
            ["TaskSucceeded", ["", _message]] call BIS_fnc_showNotification; };

        if (typeName _address == "Side" && { _address == side player }) then {
            ["TaskSucceeded", ["", _message]] call BIS_fnc_showNotification; }; }; };