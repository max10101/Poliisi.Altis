#include "HG_Macros.h"
/*
    Author - HoverGuy
    Description - Called when selection in xListbox has changed
    © All Fucks Reserved
*/
params["_ctrl","_index"];
private["_shopType","_shopItems","_itemClass","_itemName","_ind"];

disableSerialization;

_shopType = _ctrl lbData _index;
_shopType = _shopType splitString "/";
_shopItems = getArray(missionConfigFile >> "CfgClient" >> "HG_WeaponsShopCfg" >> (_shopType select 0) >> (_shopType select 1) >> "items");
	
lbClear HG_WEAPONS_ITEM_LIST;
	
{
	_itemClass = [(_x select 0)] call HG_fnc_getConfig;
    _itemName = getText(configFile >> _itemClass >> (_x select 0) >> "displayName");
    _ind = HG_WEAPONS_ITEM_LIST lbAdd _itemName;
    HG_WEAPONS_ITEM_LIST lbSetData[_ind,(_x select 0)];
    HG_WEAPONS_ITEM_LIST lbSetValue[_ind,(_x select 1)];
	HG_WEAPONS_ITEM_LIST lbSetTooltip[_ind,format[(localize "STR_HG_DLG_PRICE_TAG"),([_x select 1] call BIS_fnc_numberText),(getText(missionConfigFile >> "CfgClient" >> "currencyType"))]];
} forEach _shopItems;
	
HG_WEAPONS_ITEM_LIST lbSetCurSel 0;

true;
