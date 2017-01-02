//call with [_pos, [_target1,_target2], _type] execvm briefing.sqf
params [["_pos",[]], ["_targets",[]], ["_type",""], ["_waypoints",[]]];
/*
_pos = _this select 0;
_targets = _this select 1;
_type = _this select 2;
_waypoints = _this select 3;
*/
_text = "HQ: Catch them baddies";


IF (_type in ["RACE"]) then {
_text = format ["HQ: Multiple suspects seen %2 headed in the direction of %3",_type,(_waypoints select 0) call BIS_fnc_locationDescription,(_waypoints select 1) call BIS_fnc_locationDescription];
};
IF (_type in ["CHASE"]) then {
_text = format ["HQ: Suspect seen %2 headed in the direction of %3",_type,(_waypoints select 0) call BIS_fnc_locationDescription,(_waypoints select 1) call BIS_fnc_locationDescription];
};
IF (_type in ["RIOT"]) then {
_text = format ["HQ: We've got reports of a riot in progress %1",_pos call BIS_fnc_locationDescription];
};
IF (_type in ["ROBBERY"]) then {
_text = format ["HQ: Armed robbery in progress %1",_pos call BIS_fnc_locationDescription];
};


IF (IsServer) then {{_x setvariable ["AUDIO", false, true]} foreach AllCarArray};
titleCut ["", "BLACK OUT", 4];
sleep 4;
_Targetarray = [];
{_Targetarray = _Targetarray + [["\a3\ui_f\data\map\markers\nato\o_inf.paa", EAST call BIS_fnc_sideColor, _x, 2, 2, 0, "SUSPECT", 0]]} foreach _targets;
[_pos,_text,90,50,75,0,_Targetarray,0] spawn psi_establishingShot;
sleep 0.1;
titleCut ["", "BLACK IN", 0.5];