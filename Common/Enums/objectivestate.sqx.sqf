


















cl_Tvtcf_Common_ObjectiveStateMeta_constructor = { _this select 0 };


Tvtcf_Common_ObjectiveStateMeta_ToLang = {  params ["_state"]; scopeName "ToLang";
    switch (_state) do {
        case 1: {("Failed") breakOut "ToLang"; };
        case 2: {("Canceled") breakOut "ToLang"; };
        case 3: {("Failed") breakOut "ToLang"; };
        case 4: {("Succeeded") breakOut "ToLang"; };
        default {("<< Objective state key not defined >>") breakOut "ToLang"; }; }; };






Tvtcf_Common_ObjectiveStateMeta_ToTaskStateString = {  params ["_taskState"]; scopeName "ToTaskStateString";
    switch (_taskState) do {
        case 1: {("CREATED") breakOut "ToTaskStateString"; };
        case 2: {("CANCELED") breakOut "ToTaskStateString"; };
        case 4: {("SUCCEEDED") breakOut "ToTaskStateString"; };
        case 3: {("FAILED") breakOut "ToTaskStateString"; };
        default {("UNKNOWN") breakOut "ToTaskStateString"; }; }; };






Tvtcf_Common_ObjectiveStateMeta_ToValue = {  params ["_taskState"]; scopeName "ToValue";
    switch (_taskState) do {
        case "CREATED": {(1) breakOut "ToValue"; };
        case "CANCELED": {(2) breakOut "ToValue"; };
        case "SUCCEEDED": {(4) breakOut "ToValue"; };
        case "FAILED": {(3) breakOut "ToValue"; };
        default {(1) breakOut "ToValue"; }; }; };