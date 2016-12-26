#include "HG_Macros.h"
/*
    Author - HoverGuy
    © All Fucks Reserved
*/
private "_value";

_value = parseNumber(ctrlText HG_GM_EDIT);

if(!([_value] call HG_fnc_isNumeric)) exitWith {hint (localize "STR_HG_NOT_A_NUMBER");};
if(_value <= 0) exitWith {hint (localize "STR_HG_NEGATIVE_OR_ZERO");};

private _cash = if((getNumber(missionConfigFile >> "CfgClient" >> "enableSave")) isEqualTo 1) then {(profileNamespace getVariable "HG_Save")} else {(player getVariable "HG_myCash")};
if(_value > _cash) exitWith {hint (localize "STR_HG_TOO_MUCH");};

[_value,0] remoteExecCall ["HG_fnc_addOrSubCash",HG_CURSOR_OBJECT,false];
hint format[(localize "STR_HG_SENT_MONEY"),([_value] call BIS_fnc_numberText),(name HG_CURSOR_OBJECT),(getText(missionConfigFile >> "CfgClient" >> "currencyType"))];
[_value,1] call HG_fnc_addOrSubCash;

private _msg = format[(localize "STR_HG_RECEIVED_MONEY"),([_value] call BIS_fnc_numberText),profileName,(getText(missionConfigFile >> "CfgClient" >> "currencyType"))];
_msg remoteExecCall ["hint",HG_CURSOR_OBJECT,false];

closeDialog 0;

true;
