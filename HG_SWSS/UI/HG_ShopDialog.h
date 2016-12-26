#include "HG_IDCS.h"
/*
    Author - HoverGuy
	Description - Weapon shop dialog
	© All Fucks Reserved
*/

class HG_WeaponsShopDialog
{
    idd = HG_WEAPONS_SHOP_IDD;
	enableSimulation = true;
	name = "HG_WeaponsShopDialog";
	
	class ControlsBackground
	{
		class Header: HG_RscText
		{
			colorBackground[] = {0.4,0.4,0.4,1};
			x = 3 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 34 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
		};
		
		class WhiteLine: HG_RscPicture
		{
			x = 3 * GUI_GRID_W + GUI_GRID_X;
			y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 34 * GUI_GRID_W;
			h = 0.1 * GUI_GRID_H;
		};
		
		class Background: HG_RscText
		{
			colorBackground[] = {0,0,0,0.5};
			x = 3 * GUI_GRID_W + GUI_GRID_X;
		    y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
		    w = 34 * GUI_GRID_W;
		    h = 19.5 * GUI_GRID_H;
		};
		
		class BackgroundFrame: HG_RscFrame
		{
			x = 3 * GUI_GRID_W + GUI_GRID_X;
		    y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
		    w = 34 * GUI_GRID_W;
		    h = 19.5 * GUI_GRID_H;
		};
		
		class ShopPicture: HG_RscPicture
		{
			text = "HG_SWSS\UI\gun.paa";
			tooltip = "$STR_HG_DLG_TOOLTIP";
			x = 3 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
		};
		
		class BuyBtnPicture: HG_RscPicture
		{
			text = "HG_SWSS\UI\buy.paa";
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
		};
		
		class MyCashBtnPicture: HG_RscPicture
		{
			text = "HG_SWSS\UI\mycash.paa";
			x = 30.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
		};
		
		class ExitBtnPicture: HG_RscPicture
		{
			text = "HG_SWSS\UI\close.paa";
			x = 34 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
		};
		
		class ItemText: HG_RscStructuredText
		{
			idc = HG_WEAPONS_ITEM_TEXT_IDC;
			colorBackground[] = {0,0,0,0.5};
			x = 21.5 * GUI_GRID_W + GUI_GRID_X;
			y = 11 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 12.5 * GUI_GRID_H;
		};
		
		class TextFrame: HG_RscFrame
		{
			x = 21.5 * GUI_GRID_W + GUI_GRID_X;
			y = 11 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 12.5 * GUI_GRID_H;
		};
		
		class ItemPicture: HG_RscPicture
		{
		    idc = HG_WEAPONS_ITEM_PICTURE_IDC;
			x = 21.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 5.5 * GUI_GRID_H;
		};
	};
	
	class Controls
	{
	    class ItemList: HG_RscListBox
		{
			idc = HG_WEAPONS_ITEM_LIST_IDC;
			style = "0x02 + 16";
			onLBSelChanged = "_this call HG_fnc_itemSelectionChanged";
			x = 3.5 * GUI_GRID_W + GUI_GRID_X;
			y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 17.5 * GUI_GRID_W;
			h = 17 * GUI_GRID_H;
		};
		
		class ItemSwitch: HG_RscXListBox
		{
		    idc = HG_WEAPONS_ITEM_SWITCH_IDC;
			onLBSelChanged = "_this call HG_fnc_xItemSelectionChanged";
			x = 3.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 17.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		
		class BuyButton: HG_RscButtonInvisible
		{
			idc = HG_WEAPONS_BUY_IDC;
			tooltip = "$STR_HG_DLG_BUY_TOOLTIP";
			onButtonClick = "_this call HG_fnc_buyItem";
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
		};
		
		class MyCashButton: HG_RscButtonInvisible
		{
			idc = HG_WEAPONS_MC_IDC;
			tooltip = "$STR_HG_DLG_MC_TOOLTIP";
			onButtonClick = "hint format[(localize 'STR_HG_DLG_MC'),if((getNumber(missionConfigFile >> 'CfgClient' >> 'enableSave')) isEqualTo 1) then {[(profileNamespace getVariable 'HG_Save')] call BIS_fnc_numberText} else {[(player getVariable 'HG_myCash')] call BIS_fnc_numberText},(getText(missionConfigFile >> 'CfgClient' >> 'currencyType'))]";
			x = 30.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
		};
		
		class ExitButton: HG_RscButtonInvisible
		{
			tooltip = "$STR_HG_DLG_CLOSE_TOOLTIP";
			onButtonClick = "closeDialog 0";
			x = 34 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
		};
	};
};
