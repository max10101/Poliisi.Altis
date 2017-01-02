If (!IsServer) Exitwith {};
_man = _this;
_oldpos = getpos _man;
_Group = group _man;
_arr = Chasearray;
_closest = [_arr,[],{_man distance _x},"ASCEND"] call BIS_fnc_sortBy;
_current = _closest select 0;
_closest = _closest - [_closest select 0,_closest select 1,_closest select 2];
_wp1 = SelectRandom _closest;
_wp = _group addwaypoint [getpos _wp1,0];
_wp setwaypointtype "MOVE";
_wp setWaypointCompletionRadius 50;
_wp setwaypointSpeed "FULL";
_group setspeedmode "FULL";
_SITREP = [[toUpper format ["HQ: SUSPECT HAS BEEN REPORTED BEING SEEN %1",_current call BIS_fnc_locationDescription],"align = 'center' size = '1.0'","#2A3DFF"],["", "<br/>"],[toUpper format ["AND IS HEADED TOWARDS %1",_wp1 call BIS_fnc_locationDescription],"align = 'center' size = '1.0'","#2A3DFF"]];
[_SITREP,0.015 * safeZoneW + safeZoneX,0.015 * safeZoneH + safeZoneY,false] remoteExec ["BIS_fnc_typeText2",0];
["CHASESub",(getpos _wp1)] call BIS_fnc_taskSetDestination;
"CHASESub" call BIS_fnc_taskSetCurrent;
["CHASE",_oldpos] call BIS_fnc_taskSetDestination;
