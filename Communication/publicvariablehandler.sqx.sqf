

















cl_Tvtcf_Communication_PublicVariableHandler_constructor = { _this select 0 };




Tvtcf_Communication_PublicVariableHandler_BroadcastMissionMarkersInfo = {  params ["_missionMarkersInfo"]; 
    PUBVAR_MissionMarkersInfo = _missionMarkersInfo;
    publicVariable "PUBVAR_MissionMarkersInfo"; };



Tvtcf_Communication_PublicVariableHandler_HasValueMissionMarkersInfo = { scopeName "HasValueMissionMarkersInfo";
    (!isNil "PUBVAR_MissionMarkersInfo") breakOut "HasValueMissionMarkersInfo"; };





Tvtcf_Communication_PublicVariableHandler_GetMissionMarkersInfo = { scopeName "GetMissionMarkersInfo";
    if (call Tvtcf_Communication_PublicVariableHandler_HasValueMissionMarkersInfo) then {
        (PUBVAR_MissionMarkersInfo) breakOut "GetMissionMarkersInfo"; };


    (["null"]) breakOut "GetMissionMarkersInfo"; };






Tvtcf_Communication_PublicVariableHandler_BroadcastMissionBriefing = {  params ["_missionBriefing"]; 
    PUBVAR_MissionBriefing = _missionBriefing;
    publicVariable "PUBVAR_MissionBriefing"; };



Tvtcf_Communication_PublicVariableHandler_HasValueMissionBriefing = { scopeName "HasValueMissionBriefing";
    (!isNil "PUBVAR_MissionBriefing") breakOut "HasValueMissionBriefing"; };





Tvtcf_Communication_PublicVariableHandler_GetMissionBriefing = { scopeName "GetMissionBriefing";
    if (call Tvtcf_Communication_PublicVariableHandler_HasValueMissionBriefing) then {
        (PUBVAR_MissionBriefing) breakOut "GetMissionBriefing"; };


    (["null"]) breakOut "GetMissionBriefing"; };






Tvtcf_Communication_PublicVariableHandler_BroadcastWestHasInserted = {  params ["_hasInserted"]; 
    PUBVAR_WestHasInserted = _hasInserted;
    publicVariable "PUBVAR_WestHasInserted"; };



Tvtcf_Communication_PublicVariableHandler_HasValueWestHasInserted = { scopeName "HasValueWestHasInserted";
    (!isNil "PUBVAR_WestHasInserted") breakOut "HasValueWestHasInserted"; };





Tvtcf_Communication_PublicVariableHandler_GetWestHasInserted = { scopeName "GetWestHasInserted";
    if (call Tvtcf_Communication_PublicVariableHandler_HasValueWestHasInserted) then {
        (PUBVAR_WestHasInserted) breakOut "GetWestHasInserted"; };


    (false) breakOut "GetWestHasInserted"; };






Tvtcf_Communication_PublicVariableHandler_BroadcastEastHasInserted = {  params ["_hasInserted"]; 
    PUBVAR_EastHasInserted = _hasInserted;
    publicVariable "PUBVAR_EastHasInserted"; };



Tvtcf_Communication_PublicVariableHandler_HasValueEastHasInserted = { scopeName "HasValueEastHasInserted";
    (!isNil "PUBVAR_EastHasInserted") breakOut "HasValueEastHasInserted"; };





Tvtcf_Communication_PublicVariableHandler_GetEastHasInserted = { scopeName "GetEastHasInserted";
    if (call Tvtcf_Communication_PublicVariableHandler_HasValueEastHasInserted) then {
        (PUBVAR_EastHasInserted) breakOut "GetEastHasInserted"; };


    (false) breakOut "GetEastHasInserted"; };






Tvtcf_Communication_PublicVariableHandler_BroadcastWestHasReturned = {  params ["_hasReturned"]; 
    PUBVAR_WestHasReturned = _hasReturned;
    publicVariable "PUBVAR_WestHasReturned"; };



Tvtcf_Communication_PublicVariableHandler_HasValueWestHasReturned = { scopeName "HasValueWestHasReturned";
    (!isNil "PUBVAR_WestHasReturned") breakOut "HasValueWestHasReturned"; };





Tvtcf_Communication_PublicVariableHandler_GetWestHasReturned = { scopeName "GetWestHasReturned";
    if (call Tvtcf_Communication_PublicVariableHandler_HasValueWestHasReturned) then {
        (PUBVAR_WestHasReturned) breakOut "GetWestHasReturned"; };


    (false) breakOut "GetWestHasReturned"; };






Tvtcf_Communication_PublicVariableHandler_BroadcastEastHasReturned = {  params ["_hasReturned"]; 
    PUBVAR_EastHasReturned = _hasReturned;
    publicVariable "PUBVAR_EastHasReturned"; };



Tvtcf_Communication_PublicVariableHandler_HasValueEastHasReturned = { scopeName "HasValueEastHasReturned";
    (!isNil "PUBVAR_EastHasReturned") breakOut "HasValueEastHasReturned"; };





Tvtcf_Communication_PublicVariableHandler_GetEastHasReturned = { scopeName "GetEastHasReturned";
    if (call Tvtcf_Communication_PublicVariableHandler_HasValueEastHasReturned) then {
        (PUBVAR_EastHasReturned) breakOut "GetEastHasReturned"; };


    (false) breakOut "GetEastHasReturned"; };




Tvtcf_Communication_PublicVariableHandler_BroadcastWestInsertionPos = {  params ["_westInsertionPos"]; 
    PUBVAR_WestInsertionPos = _westInsertionPos;
    publicVariable "PUBVAR_WestInsertionPos"; };


Tvtcf_Communication_PublicVariableHandler_HasValueWestInsertionPos = { scopeName "HasValueWestInsertionPos";
    (!isNil "PUBVAR_WestInsertionPos") breakOut "HasValueWestInsertionPos"; };



Tvtcf_Communication_PublicVariableHandler_GetWestInsertionPos = { scopeName "GetWestInsertionPos";
    if (call Tvtcf_Communication_PublicVariableHandler_HasValueWestInsertionPos) then {
        (PUBVAR_WestInsertionPos) breakOut "GetWestInsertionPos"; };


    ([0, 0, 0]) breakOut "GetWestInsertionPos"; };




Tvtcf_Communication_PublicVariableHandler_BroadcastEastInsertionPos = {  params ["_eastInsertionPos"]; 
    PUBVAR_EastInsertionPos = _eastInsertionPos;
    publicVariable "PUBVAR_EastInsertionPos"; };


Tvtcf_Communication_PublicVariableHandler_HasValueEastInsertionPos = { scopeName "HasValueEastInsertionPos";
    (!isNil "PUBVAR_EastInsertionPos") breakOut "HasValueEastInsertionPos"; };



Tvtcf_Communication_PublicVariableHandler_GetEastInsertionPos = { scopeName "GetEastInsertionPos";
    if (call Tvtcf_Communication_PublicVariableHandler_HasValueEastInsertionPos) then {
        (PUBVAR_EastInsertionPos) breakOut "GetEastInsertionPos"; };


    ([0, 0, 0]) breakOut "GetEastInsertionPos"; };




Tvtcf_Communication_PublicVariableHandler_BroadcastInsertedWestlyUnits = {  params ["_insertedWestlyUnits"]; 
    PUBVAR_InsertedWestlyUnits = _insertedWestlyUnits;
    publicVariable "PUBVAR_InsertedWestlyUnits"; };


Tvtcf_Communication_PublicVariableHandler_HasValueInsertedWestlyUnits = { scopeName "HasValueInsertedWestlyUnits";
    (!isNil "PUBVAR_InsertedWestlyUnits") breakOut "HasValueInsertedWestlyUnits"; };



Tvtcf_Communication_PublicVariableHandler_GetInsertedWestlyUnits = { scopeName "GetInsertedWestlyUnits";
    if (call Tvtcf_Communication_PublicVariableHandler_HasValueInsertedWestlyUnits) then {
        (PUBVAR_InsertedWestlyUnits) breakOut "GetInsertedWestlyUnits"; };


    ([]) breakOut "GetInsertedWestlyUnits"; };




Tvtcf_Communication_PublicVariableHandler_BroadcastInsertedEastlyUnits = {  params ["_insertedEastlyUnits"]; 
    PUBVAR_InsertedEastlyUnits = _insertedEastlyUnits;
    publicVariable "PUBVAR_InsertedEastlyUnits"; };


Tvtcf_Communication_PublicVariableHandler_HasValueInsertedEastlyUnits = { scopeName "HasValueInsertedEastlyUnits";
    (!isNil "PUBVAR_InsertedEastlyUnits") breakOut "HasValueInsertedEastlyUnits"; };



Tvtcf_Communication_PublicVariableHandler_GetInsertedEastlyUnits = { scopeName "GetInsertedEastlyUnits";
    if (call Tvtcf_Communication_PublicVariableHandler_HasValueInsertedEastlyUnits) then {
        (PUBVAR_InsertedEastlyUnits) breakOut "GetInsertedEastlyUnits"; };


    ([]) breakOut "GetInsertedEastlyUnits"; };




Tvtcf_Communication_PublicVariableHandler_BroadcastBriefingEndTime = {  params ["_briefingEndTime"]; 
    PUBVAR_BriefingEndTime = _briefingEndTime;
    publicVariable "PUBVAR_BriefingEndTime"; };


Tvtcf_Communication_PublicVariableHandler_HasValueBriefingEndTime = { scopeName "HasValueBriefingEndTime";
    (!isNil "PUBVAR_BriefingEndTime") breakOut "HasValueBriefingEndTime"; };



Tvtcf_Communication_PublicVariableHandler_GetBriefingEndTime = { scopeName "GetBriefingEndTime";
    if (call Tvtcf_Communication_PublicVariableHandler_HasValueBriefingEndTime) then {
        (PUBVAR_BriefingEndTime) breakOut "GetBriefingEndTime"; };


    (0) breakOut "GetBriefingEndTime"; };




Tvtcf_Communication_PublicVariableHandler_BroadcastMissionHasStarted = {  params ["_missionHasStarted"]; 
    PUBVAR_MissionHasStarted = _missionHasStarted;
    publicVariable "PUBVAR_MissionHasStarted"; };


Tvtcf_Communication_PublicVariableHandler_HasValueMissionHasStarted = { scopeName "HasValueMissionHasStarted";
    (!isNil "PUBVAR_MissionHasStarted") breakOut "HasValueMissionHasStarted"; };



Tvtcf_Communication_PublicVariableHandler_GetMissionHasStarted = { scopeName "GetMissionHasStarted";
    if (call Tvtcf_Communication_PublicVariableHandler_HasValueMissionHasStarted) then {
        (PUBVAR_MissionHasStarted) breakOut "GetMissionHasStarted"; };


    (false) breakOut "GetMissionHasStarted"; };




Tvtcf_Communication_PublicVariableHandler_BroadcastNextMissionStartTime = {  params ["_nextMissionStartTime"]; 
    PUBVAR_NextMissionStartTime = _nextMissionStartTime;
    publicVariable "PUBVAR_NextMissionStartTime"; };


Tvtcf_Communication_PublicVariableHandler_HasValueNextMissionStartTime = { scopeName "HasValueNextMissionStartTime";
    (!isNil "PUBVAR_NextMissionStartTime") breakOut "HasValueNextMissionStartTime"; };



Tvtcf_Communication_PublicVariableHandler_GetNextMissionStartTime = { scopeName "GetNextMissionStartTime";
    if (call Tvtcf_Communication_PublicVariableHandler_HasValueNextMissionStartTime) then {
        (PUBVAR_NextMissionStartTime) breakOut "GetNextMissionStartTime"; };


    (0) breakOut "GetNextMissionStartTime"; };




Tvtcf_Communication_PublicVariableHandler_BroadcastObjectiveChangeCollection = {  params ["_objectiveChangeCollection"]; 
    PUBVAR_ObjectiveChangeCollection = _objectiveChangeCollection;
    publicVariable "PUBVAR_ObjectiveChangeCollection"; };


Tvtcf_Communication_PublicVariableHandler_HasValueObjectiveChangeCollection = { scopeName "HasValueObjectiveChangeCollection";
    (!isNil "PUBVAR_ObjectiveChangeCollection") breakOut "HasValueObjectiveChangeCollection"; };



Tvtcf_Communication_PublicVariableHandler_GetObjectiveChangeCollection = { scopeName "GetObjectiveChangeCollection";
    if (call Tvtcf_Communication_PublicVariableHandler_HasValueObjectiveChangeCollection) then {
        (PUBVAR_ObjectiveChangeCollection) breakOut "GetObjectiveChangeCollection"; };


    (["null"]) breakOut "GetObjectiveChangeCollection"; };




Tvtcf_Communication_PublicVariableHandler_BroadcastMissionResultArray = {  params ["_missionResultArray"]; 
    PUBVAR_MissionResultArray = _missionResultArray;
    publicVariable "PUBVAR_MissionResultArray"; };


Tvtcf_Communication_PublicVariableHandler_HasValueMissionResultArray = { scopeName "HasValueMissionResultArray";
    (!isNil "PUBVAR_MissionResultArray") breakOut "HasValueMissionResultArray"; };



Tvtcf_Communication_PublicVariableHandler_GetMissionResultArray = { scopeName "GetMissionResultArray";
    if (call Tvtcf_Communication_PublicVariableHandler_HasValueMissionResultArray) then {
        (PUBVAR_MissionResultArray) breakOut "GetMissionResultArray"; };


    ([]) breakOut "GetMissionResultArray"; };