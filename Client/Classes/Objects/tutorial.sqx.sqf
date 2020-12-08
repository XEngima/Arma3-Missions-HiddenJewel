
















cl_Tvtcf_Client_Tutorial_constructor = { params ["_class_fields", "_this"]; params ["_type", "_header", "_text"]; 
    _class_fields set [1, _type];
    _class_fields set [2, _header];
    _class_fields set [3, _text];
    _class_fields set [4, false]; _class_fields };



cl_Tvtcf_Client_Tutorial_Type_PropIndex = 1;


cl_Tvtcf_Client_Tutorial_Header_PropIndex = 2;


cl_Tvtcf_Client_Tutorial_Text_PropIndex = 3;


cl_Tvtcf_Client_Tutorial_ToBriefingText = { params ["_class_fields", "_this"]; scopeName "ToBriefingText";
    (([_class_fields, [(_class_fields select 3), "\n", "<br />"]] call cl_Tvtcf_Client_Tutorial_StringReplace)) breakOut "ToBriefingText"; };



cl_Tvtcf_Client_Tutorial_IsTurnedOff_PropIndex = 4;


cl_Tvtcf_Client_Tutorial_StringReplace = { params ["_class_fields", "_this"]; params ["_str", "_find", "_replace"]; scopeName "StringReplace";
    private _return = "";
    private _len = count _find;
    private _pos = _str find _find;

    while { (_pos != -1) && (count _str > 0) } do {

        _return = _return + (_str select [0, _pos]) + _replace;

        _str = (_str select [_pos + _len]);
        _pos = _str find _find; };


    (_return + _str) breakOut "StringReplace"; };