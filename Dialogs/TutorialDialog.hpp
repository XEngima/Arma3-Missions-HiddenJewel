class IntTutorialDialog
{
    idd = -1;
    movingenable = false;

	class Controls
    {
		class IntTutorialDialog_DialogSurface : IntBaseDialog_DialogSurface {};
		class IntTutorialDialog_CloseButton : IntBaseDialog_CloseButton {};
		
		class IntTutorialDialog_Header : IntBaseDialog_Header
		{
			idc = 43;
		};
		
		class IntTutorialDialog_Text : RscText
		{
			idc = 44;
			SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			text = "Tex";
			style = ST_MULTI_NOBORDER;       // constant
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 19.5 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		
		class IntTutorialDialog_TurnOffButton : IntBaseDialog_Button
		{
			idc = 45;
			text = "Turn off tutorials";
			x = 26.5 * GUI_GRID_W + GUI_GRID_X;
			w = 8 * GUI_GRID_W;
			action = "Tvtcf_Client_TutorialDialog_DialogsTurnedOff = true; closeDialog 0; ";
		};
		
    };
};
