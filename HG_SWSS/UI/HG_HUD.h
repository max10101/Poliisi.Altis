#include "HG_IDCS.h"
/*
    Author - HoverGuy
	Description - HUD
	© All Fucks Reserved
*/

class HG_HUD
{
	idd = HG_NO_IDC;
	duration = HG_INFINITE;
	fadeIn = 0;
	fadeOut = 0;
	name = "HG_HUD";
	onLoad = "uiNamespace setVariable ['HG_HUD',_this select 0]";
	onUnload = "uiNamespace setVariable ['HG_HUD',displayNull]";
	onDestroy = "uiNamespace setVariable ['HG_HUD',displayNull]";
	
	class ControlsBackground
	{
		class MoneyPicture: HG_RscPicture
		{
			text = "HG_SWSS\UI\money.paa";
			x = 55 * GUI_GRID_W + GUI_GRID_X;
			y = 30.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorText[] = {0,0,1,1};
		};
		
		class MoneyText: HG_RscText
		{
			idc = HG_HUD_TEXT_IDC;
			style = "0x01";
			x = 42 * GUI_GRID_W + GUI_GRID_X;
			y = 31 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorText[] = {0,0,1,1};
		};
	};
};
