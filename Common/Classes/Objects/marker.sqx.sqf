






















Tvtcf_Common_Marker_NewIconMarker = {  params ["_name", "_position", ["_type", "hd_dot"], ["_color", "ColorBlack"], ["_text", ""], ["_alpha", 0.4]]; scopeName "NewIconMarker";
    ((([[["Tvtcf_Common_Marker",[]]], [_name, _position, "ICON", [1, 1], 0, _type, _color, "Solid", _text, _alpha]] call cl_Tvtcf_Common_Marker_constructor))) breakOut "NewIconMarker"; };












Tvtcf_Common_Marker_NewShapeMarker = {  params ["_name", "_position", ["_shape", "RECTANGLE"], ["_size", [50, 50]], ["_direction", 0], ["_color", "ColorBlack"], ["_brush", "Solid"], ["_alpha", 0.4]]; scopeName "NewShapeMarker";
    ((([[["Tvtcf_Common_Marker",[]]], [_name, _position, _shape, _size, _direction, "hd_dot", _color, _brush, "", _alpha]] call cl_Tvtcf_Common_Marker_constructor))) breakOut "NewShapeMarker"; };

















cl_Tvtcf_Common_Marker_constructor = { params ["_class_fields", "_this"]; params [
"_name", 
"_position", 
["_shape", "ICON"], 
["_size", [1, 1]], 
["_direction", 0], 
["_type", "hd_dot"], 
["_color", "ColorBlack"], 
["_brush", "Solid"], 
["_text", ""], 
["_alpha", 0.4]]; 

    if (isNil "Sqx_Markers_Marker_CurrentId") then {
        Tvtcf_Common_Marker_CurrentId = 1; };



    if (_name == "") then {
        _name = "Tvtcf_Common_Marker" + str Tvtcf_Common_Marker_CurrentId;
        Tvtcf_Common_Marker_CurrentId = Tvtcf_Common_Marker_CurrentId + 1; };


    _class_fields set [1, _name];
    _class_fields set [2, _position];

    _class_fields set [3, _shape];
    _class_fields set [4, _size];
    _class_fields set [5, _direction];
    _class_fields set [6, _type];
    _class_fields set [7, _color];
    _class_fields set [8, _brush];
    _class_fields set [9, _text];
    _class_fields set [10, _alpha]; _class_fields };







cl_Tvtcf_Common_Marker_Name_PropIndex = 1;


cl_Tvtcf_Common_Marker_Position_PropIndex = 2;


cl_Tvtcf_Common_Marker_Shape_PropIndex = 3;


cl_Tvtcf_Common_Marker_Size_PropIndex = 4;


cl_Tvtcf_Common_Marker_Direction_PropIndex = 5;


cl_Tvtcf_Common_Marker_Type_PropIndex = 6;


cl_Tvtcf_Common_Marker_Color_PropIndex = 7;


cl_Tvtcf_Common_Marker_Brush_PropIndex = 8;


cl_Tvtcf_Common_Marker_Text_PropIndex = 9;


cl_Tvtcf_Common_Marker_Alpha_PropIndex = 10;