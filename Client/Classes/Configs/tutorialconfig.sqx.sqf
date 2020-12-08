










cl_Tvtcf_Client_TutorialConfig_constructor = { _this select 0 };



Tvtcf_Client_TutorialConfig_Init = { 
    Tvtcf_Client_TutorialConfig__mTutorials = [




    ([[["Tvtcf_Client_Tutorial",[]]], [1, "WELCOME!", "This is what you need to know! This information is also available in the briefing under the WELCOME tab.\n\nREAD THE BRIEFING\nWhen starting a mission, make sure you read the briefing and the task information carefully.\n\nBASE LAYOUT\nThe base contains a respawn point (where you respawn), a weapons depot (where weapons and ammunition spawn), a land vehicle area (where land vehicles spawn) and a sea area (where boats spawn).\n\nMISSION INSERTION\nAt the beginning of each mission, your squad will be deployed to the action area to begin the mission. Usually you will start a mission by doing a manual insertion. Use the action menu. Select 'Mission Menu' and then 'Perform Insertion'. The map of the insertion area is displayed. Then left-click in one of the blue insertion markers. Your group will be deployed immediately, so make sure everyone is ready. In some missions you will start the mission in the base. In these cases, the insertion takes place automatically.\n\nREMEMBER TO BRING EVERYTHING YOU NEED\nDo not forget to bring explosives if you are going to blow something up! And be sure to bring a vehicle if you will encounter travel distances. If you want to bring a vehicle, enter it and perform the insertion inside it.\n\nA successful primary objective earns 100 points for your side. A secondary and return objective 50 points each. You will lose 25 points for each lost team member during a mission, and receive a bonus of 50 points if everyone survives a successful mission. The side with the highest total score at the end of the campaign wins."]] call cl_Tvtcf_Client_Tutorial_constructor), 




    ([[["Tvtcf_Client_Tutorial",[]]], [2, "NOT INTENDED TO PLAY IN SINGLE PLAYER OR COOP!", "This campaign concept is intended to be played in TvT (or PvP) with human players on both sides. It is possible to play it anyway, if the purpose is to e.g. try it and see if the concept is interesting to play with friends.\n\nIf you only play with human players on one side, you may encounter strange behavior, such as skipped missions or prefulfilled objectives."]] call cl_Tvtcf_Client_Tutorial_constructor)]; };







Tvtcf_Client_TutorialConfig_GetTutorial = {  params ["_type"]; scopeName "GetTutorial";
    {
        private _tutorial = _x;

        if ((_tutorial select 1) == _type) then {
            (_tutorial) breakOut "GetTutorial"; };
    } forEach 
    Tvtcf_Client_TutorialConfig__mTutorials;

    (["null"]) breakOut "GetTutorial"; };