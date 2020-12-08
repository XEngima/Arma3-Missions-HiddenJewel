








disableSerialization;







cl_Josef_Common_MapCtrl_constructor = { params ["_class_fields", "_this"]; _class_fields };





Josef_Common_MapCtrl_DefaultMapControl = { scopeName "DefaultMapControl";
    private _defaultMainMapCtrl = (findDisplay 12) displayCtrl 51;
    ([_defaultMainMapCtrl]) breakOut "DefaultMapControl"; };





Josef_Common_MapCtrl_OpenDefaultMap = { 
    openMap true; };














Josef_Common_MapCtrl_MoveMapToRectangle = {  params ["_mapControlArray", "_rectangle", ["_padding", 50], ["_minViewDistance", 100], ["_animationTime", 0], ["_startViewDistance", 1000]]; 

    private _ctrlMap = _mapControlArray select 0;
    private _debug = false;


    private _topleft = _rectangle select 0;
    private _bottomright = _rectangle select 1;
    private _bBoxTop = (_topleft select 1) + _padding;
    private _bBoxLeft = (_topleft select 0) - _padding;
    private _bBoxBottom = (_bottomright select 1) - _padding;
    private _bBoxRight = (_bottomright select 0) + _padding;
    private _bBoxW = _bBoxRight - _bBoxLeft;
    private _bBoxH = _bBoxTop - _bBoxBottom;
    private _bBoxCenter = [(_bBoxW / 2) + _bBoxLeft, (_bBoxH / 2) + _bBoxBottom];


    private _ctrlPos = ctrlPosition _ctrlMap;
    private _ctrlW = _ctrlPos select 2;
    private _ctrlH = _ctrlPos select 3;



    private _ctrlAspectRatio = _ctrlW / (_ctrlH / (4 / 3));
    private _bBoxAspectRatio = _bBoxW / _bBoxH;
    private _viewDistance = _bBoxW;
    if (_bBoxAspectRatio < _ctrlAspectRatio) then {
        _viewDistance = _bBoxH * _ctrlAspectRatio; };



    private _minZoomLevel = _minViewDistance / (worldSize * _ctrlW);
    private _startZoom = _startViewDistance / (worldSize * _ctrlW);
    private _zoom = _viewDistance / (worldSize * _ctrlW);
    _zoom = [_zoom, _minZoomLevel] select (_zoom < _minZoomLevel);



    _ctrlMap ctrlMapAnimAdd [0, _startZoom, _bBoxCenter];
    _ctrlMap ctrlMapAnimAdd [_animationTime, _zoom, _bBoxCenter];
    ctrlMapAnimCommit _ctrlMap;
    waitUntil { ctrlMapAnimDone _ctrlMap };


    if (_debug) then {

        private _ctrlMapRight = (_ctrlPos select 0) + _ctrlW;
        private _ctrlMapBottom = (_ctrlPos select 1) + _ctrlH;
        private _mapCoordinateLeftTop = _ctrlMap ctrlMapScreenToWorld [(_ctrlPos select 0), (_ctrlPos select 1)];
        private _mapCoordinateRightBottom = _ctrlMap ctrlMapScreenToWorld [_ctrlMapRight, _ctrlMapBottom];
        private _viewW = (_mapCoordinateRightBottom select 0) - (_mapCoordinateLeftTop select 0);
        private _viewH = (_mapCoordinateLeftTop select 1) - (_mapCoordinateRightBottom select 1);

        systemChat format ["_bBoxAspectRatio: %1     _ctrlAspectRatio: %2     _distance: %3", _bBoxAspectRatio, _ctrlAspectRatio, _viewDistance];
        systemChat format ["_zoom: %1", _zoom];
        systemChat format ["_ctrlPos: %1", _ctrlPos];
        systemChat format ["_bBoxW: %1  _bBoxH: %2", _bBoxW, _bBoxH];
        systemChat format ["viewW: %1     viewH: %2", _viewW, _viewH];

        private _text = format ["ctrlPosition: %1 <br />safeZoneW: %2<br />safeZoneH: %3<br />worldSize: %4<br />getResolution: %5<br />ctrlMapScale: %6<br />_mapCoordLeftTop: %7<br />_mapCoordRightBott: %8<br />_viewW: %9<br />_viewH: %10", 
        ctrlPosition _ctrlMap, 
        safeZoneW, 
        safeZoneH, 
        worldSize, 
        getResolution, 
        ctrlMapScale _ctrlMap, 
        _mapCoordinateLeftTop, 
        _mapCoordinateRightBottom, 
        _viewW, 
        _viewH];

        copyToClipboard _text;


        [[_bBoxLeft, _bBoxTop], "hd_dot", "ColorBlack", "MarkerLeftTop", true] call Sqx_Markers_Marker_CreateIconMarkerLocal;
        [[_bBoxRight, _bBoxBottom], "hd_dot", "ColorBlack", "MarkerLeftTop", true] call Sqx_Markers_Marker_CreateIconMarkerLocal;
        [_bBoxCenter, "hd_dot", "ColorBlack", "MarkerCenter", true] call Sqx_Markers_Marker_CreateIconMarkerLocal; }; };











Josef_Common_MapCtrl_MarkersBoundingBox = {  params ["_markers"]; scopeName "MarkersBoundingBox";

    private _bBoxLeft = 0;
    private _bBoxTop = 0;
    private _bBoxRight = 0;
    private _bBoxBottom = 0;
    private _xAxis = [];
    private _yAxis = [];

    {
        private _markerPos = getMarkerPos _x;
        private _markerSize = getMarkerSize _x;
        private _markerDir = markerDir _x;

        private _leftSide = _markerPos getPos [(_markerSize select 0), (_markerDir - 90)];
        private _rightSide = _markerPos getPos [(_markerSize select 0), (_markerDir + 90)];

        private _topLeft = _leftSide getPos [(_markerSize select 1), _markerDir];
        private _topRight = _rightSide getPos [(_markerSize select 1), _markerDir];
        private _bottomLeft = _leftSide getPos [(_markerSize select 1), (_markerDir - 180)];
        private _bottomRight = _rightSide getPos [(_markerSize select 1), (_markerDir - 180)];


        {
            _xAxis pushBack (_x select 0);
            _yAxis pushBack (_x select 1);
        } forEach [_topLeft, _topRight, _bottomLeft, _bottomRight];
    } forEach 
    _markers;

    _bBoxLeft = selectMin _xAxis;
    _bBoxRight = selectMax _xAxis;
    _bBoxBottom = selectMin _yAxis;
    _bBoxTop = selectMax _yAxis;

    private _rect = [[_bBoxLeft, _bBoxTop], [_bBoxRight, _bBoxBottom]];
    (_rect) breakOut "MarkersBoundingBox"; };