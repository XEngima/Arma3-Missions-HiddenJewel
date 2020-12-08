













cl_Tvtcf_Common_MissionResultInfo_constructor = { params ["_class_fields", "_this"]; params ["_primaryObjectiveName", "_primaryObjectiveState", "_secondaryObjectiveName", "_secondaryObjectiveState", "_usingReturnObjective", "_returnObjectiveState", "_menAtStart", "_menAtEnd"]; 

    _class_fields set [1, 100];
    _class_fields set [2, 50];
    _class_fields set [3, 50];
    _class_fields set [4, 50];
    _class_fields set [5, 25];

    _class_fields set [6, _primaryObjectiveName];
    _class_fields set [7, _primaryObjectiveState];
    _class_fields set [8, _secondaryObjectiveName];
    _class_fields set [9, _secondaryObjectiveState];
    _class_fields set [10, _usingReturnObjective];
    _class_fields set [11, _returnObjectiveState];
    _class_fields set [12, _menAtStart];
    _class_fields set [13, _menAtEnd];

    private _score = 0;

    if ((_class_fields select 7) == 4) then {
        _score = _score + (_class_fields select 1); };


    if ((_class_fields select 9) == 4) then {
        _score = _score + (_class_fields select 2); };


    if ((_class_fields select 10) && (_class_fields select 11) == 4) then {
        _score = _score + (_class_fields select 3); };


    private _menLost = _menAtStart - _menAtEnd;

    if (_menLost > 0) then {
        _score = _score - ((_class_fields select 5) * _menLost); } else { 


        if (_score > 0) then {
            _score = _score + (_class_fields select 4); }; };



    if (_score < 0) then {
        _score = 0; };


    _class_fields set [14, _score]; _class_fields };


cl_Tvtcf_Common_MissionResultInfo_PrimaryObjectiveScore_PropIndex = 1;

cl_Tvtcf_Common_MissionResultInfo_SecondaryObjectiveScore_PropIndex = 2;

cl_Tvtcf_Common_MissionResultInfo_ReturnObjectiveScore_PropIndex = 3;

cl_Tvtcf_Common_MissionResultInfo_AllSurvivedBonusScore_PropIndex = 4;

cl_Tvtcf_Common_MissionResultInfo_MenLostScore_PropIndex = 5;


cl_Tvtcf_Common_MissionResultInfo_PrimaryObjectiveName_PropIndex = 6;

cl_Tvtcf_Common_MissionResultInfo_PrimaryObjectiveState_PropIndex = 7;

cl_Tvtcf_Common_MissionResultInfo_SecondaryObjectiveName_PropIndex = 8;

cl_Tvtcf_Common_MissionResultInfo_SecondaryObjectiveState_PropIndex = 9;

cl_Tvtcf_Common_MissionResultInfo_UsingReturnObjective_PropIndex = 10;

cl_Tvtcf_Common_MissionResultInfo_ReturnObjectiveState_PropIndex = 11;

cl_Tvtcf_Common_MissionResultInfo_MenAtStart_PropIndex = 12;

cl_Tvtcf_Common_MissionResultInfo_MenAtEnd_PropIndex = 13;

cl_Tvtcf_Common_MissionResultInfo_Score_PropIndex = 14;