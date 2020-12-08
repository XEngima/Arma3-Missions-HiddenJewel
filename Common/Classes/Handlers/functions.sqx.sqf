










cl_Tvtcf_Common_Functions_constructor = { _this select 0 };




Tvtcf_Common_Functions_FindClosestToMarkersPos = {  params ["_markers"]; scopeName "FindClosestToMarkersPos";
    private ["_topX", "_topY", "_bottomX", "_bottomY"];
    private ["_bestPos", "_quadrantValue", "_bestQuadrantValue"];

    if (count _markers == 0) then {
        ([]) breakOut "FindClosestToMarkersPos"; };


    _topX = getMarkerPos (_markers select 0) select 0;
    _topY = getMarkerPos (_markers select 0) select 1;
    _bottomX = getMarkerPos (_markers select 0) select 0;
    _bottomY = getMarkerPos (_markers select 0) select 1;

    {
        private _pos = getMarkerPos _x;

        if (_pos select 0 < _topX) then {
            _topX = _pos select 0; };

        if (_pos select 0 > _bottomX) then {
            _bottomX = _pos select 0; };

        if (_pos select 1 < _bottomY) then {
            _bottomY = _pos select 1; };

        if (_pos select 1 > _topY) then {
            _topY = _pos select 1; };
    } forEach 
    _markers;

    private _xx = _topX;

    _bestQuadrantValue = -1;
    _bestPos = [_topX, _topY, 0];

    while { _xx < _bottomX } do {

        private _y = _topY;

        while { _y > _bottomY } do {

            _quadrantValue = 0;

            {
                _quadrantValue = _quadrantValue + (([_xx, _y] distance2D (getMarkerPos _x)) / 1000) ^ 2;
            } forEach _markers;

            if (_bestQuadrantValue < 0 || _quadrantValue < _bestQuadrantValue) then {

                _bestQuadrantValue = _quadrantValue;
                _bestPos = [_xx, _y, 0]; };


            _y = _y - 200; };


        _xx = _xx + 200; };


    (_bestPos) breakOut "FindClosestToMarkersPos"; };



Tvtcf_Common_Functions_GetMissionTime = { scopeName "GetMissionTime";
    if (isMultiplayer) then {
        (serverTime) breakOut "GetMissionTime"; };


    (time) breakOut "GetMissionTime"; };



Tvtcf_Common_Functions_StringReplace = {  params ["_str", "_find", "_replace"]; scopeName "StringReplace";
    private _return = "";
    private _len = count _find;
    private _pos = _str find _find;

    while { (_pos != -1) && (count _str > 0) } do {

        _return = _return + (_str select [0, _pos]) + _replace;

        _str = (_str select [_pos + _len]);
        _pos = _str find _find; };


    (_return + _str) breakOut "StringReplace"; };



Tvtcf_Common_Functions_ShuffleArray = {  params ["_array"]; 
    for "_i" from 0 to (count _array) * 2 do {

        private _index1 = floor random count _array;
        private _index2 = floor random count _array;

        if (_index1 != _index2) then {

            private _item = _array select _index1;
            _array set [_index1, _array select _index2];
            _array set [_index2, _item]; }; }; };