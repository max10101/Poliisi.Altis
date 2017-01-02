IF (!IsServer) ExitWith {};
_Array = ChaseArray;
_3way = false;
_race = false;
_man2 = objnull;
_group2 = objnull;
_wp1 = SelectRandom _Array;
IF (FirstChase) then {_wp1 = Road_10;FirstChase = false;};
_array = _array - [_wp1];
_wp2 = SelectRandom _Array;
_array = _array - [_wp2];
_manarr = [];
_wparr = [_wp1,_wp2];

_type = "CHASE";
_tmpPos = [];

_NearRoads = (getpos _wp1) NearRoads 25;
_road1 = SelectRandom _NearRoads;
_connectedRoads = (roadsConnectedTo _road1) select 0;
IF (IsNull _connectedRoads) then {_connectedRoads = _wp2};


_NearRoads = _NearRoads - [_road1];
_road2 = SelectRandom _NearRoads;

_man = [getpos _road1] call CrimCarInit;
_group = group _man;
_vehicle = vehicle _man;
_vehicle setdir ([_vehicle,_connectedRoads] call BIS_fnc_dirTo);
_manarr = _manarr + [_man];
IF (random 1 > 0.5) then {_man2 = [getpos _road1] call CrimCarAccompliceInit};
_man2 moveincargo _vehicle;[_man2] join _man;
_manarr = _manarr + [_man2];
sleep 0.1;
IF (([typeof _vehicle] in ["psi_sportscar1","psi_sportscar2","psi_sportscar3"]) && (Random 1 > 0)) then {_race = true;};
_race = false;

IF (_race) then {
_man2 = [getpos _road2] call CrimCarInit;_group2 = group _man2;_type = "RACE";_manarr = _manarr + [_man2]
};

sleep 0.1;
_wp = _group addwaypoint [getpos _wp2,0];
_wp setwaypointtype "MOVE";
_group setspeedmode "FULL";
_wp setwaypointstatements ["true","this execvm ""NewchaseWP.sqf"""];
_wp setWaypointCompletionRadius 50;
_wp setwaypointSpeed "FULL";

IF (_race) then {
_wp = _group2 addwaypoint [getpos _wp2,0];
_wp setwaypointtype "MOVE";
_group2 setspeedmode "FULL";
_wp setwaypointstatements ["true","this execvm ""NewchaseWP.sqf"""];
_wp setWaypointCompletionRadius 50;
_wp setwaypointSpeed "FULL";
};

[_manarr,_vehicle] execvm "chasecarcheck.sqf";

MissionStatus = [_type,_manarr,_wparr,"Init"];
Publicvariable "MissionStatus";

[[_man,_manarr,_type,_wparr],"Briefing.sqf"] RemoteExec ["ExecVM",0];

sleep 5;
_obj = ["Stop and arrest the suspect","Speeding vehicle",""];
IF (_race) then {_obj = ["Stop and arrest the suspects","Racing vehicles",""]};
[West,["CHASE"],_obj,(getpos _wp1),"ASSIGNED",3,true] call BIS_fnc_taskCreate;
[West,["CHASESub","CHASE"],["Destination","Direction the suspect is heading",""],(getpos _wp2),"Created",3,true] call BIS_fnc_taskCreate;
["CHASE",true] call BIS_fnc_taskSetAlwaysVisible;
["CHASESub",true] call BIS_fnc_taskSetAlwaysVisible;
CurrentTaskArray = ["CHASE","CHASESub"];
sleep 2;
(SelectRandom PSI_PursuitSounds) remoteExec ["PSI_PlaySound",0];
sleep 4;
(SelectRandom PSI_104Sounds) remoteExec ["PSI_PlaySound",0];