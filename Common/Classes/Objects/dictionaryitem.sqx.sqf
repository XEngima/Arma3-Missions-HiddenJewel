













cl_Tvtcf_Common_DictionaryItem_constructor = { params ["_class_fields", "_this"]; params ["_key", "_value"]; 

    _class_fields set [1, _key];
    _class_fields set [2, _value]; _class_fields };


cl_Tvtcf_Common_DictionaryItem_Key_PropIndex = 1;

cl_Tvtcf_Common_DictionaryItem_Value_PropIndex = 2;