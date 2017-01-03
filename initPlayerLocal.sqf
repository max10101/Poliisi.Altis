/*
    Author - HoverGuy
    © All Fucks Reserved
*/
if(!hasInterface) exitWith {}; // If headless then exit
params["_player"];
sleep 2;
_player enablefatigue false;
_player addeventhandler ["Killed",{_this call PlayerKilledEH}];
[_player] execvm "spikestrip.sqf";
SpikeStripSet = false;
/*
    Init money variable
*/
if((getNumber(missionConfigFile >> "CfgClient" >> "enableSave")) isEqualTo 1) then
{
    if((isNil {profileNamespace getVariable "HG_Save"}) OR ((getNumber(missionConfigFile >> "CfgClient" >> "resetSavedMoney")) isEqualTo 1)) then
	{
	    profileNamespace setVariable["HG_Save",StartingCash];
	};
} else {
    _player setVariable["HG_myCash",StartingCash];
};

if((getNumber(missionConfigFile >> "CfgClient" >> "enableHUD")) isEqualTo 1) then
{
    [0] call HG_fnc_HUD;
};

_player addAction["<img image='HG_SWSS\UI\money.paa' size='1.5'/><t color='#FF0000'>Give Money</t>",{HG_CURSOR_OBJECT = cursorObject; createDialog "HG_GiveMoney"},"",0,false,false,"",'(alive player) AND (IsPlayer CursorObject) AND (alive cursorObject) AND (player distance cursorObject < 2) AND !dialog'];

//_player addAction["<t color='#FF0000'>Arrest</t>",{PSI_CURSOR_OBJECT = cursorObject; createDialog "HG_GiveMoney"},"",0,false,false,"",'(alive player) AND (cursorObject isKindOf "Man") AND (alive cursorObject) AND (player distance cursorObject < 2) AND (CursorObject in )'];
