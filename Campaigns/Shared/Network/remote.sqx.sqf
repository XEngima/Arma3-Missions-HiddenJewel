













cl_Campaigns_Network_Remote_constructor = { _this select 0 }; cl_Campaigns_Network_Remote_Invoke = { _this call cl_Tvtcf_Communication_CampaignRemote_Invoke };









cl_Campaigns_Network_Remote_SendShowMessage = { params ["_class_fields", "_this"]; params ["_message", "_showOnSide"]; 



    ([_class_fields, ["ShowMessage", _this]] call cl_Campaigns_Network_Remote_Invoke); };