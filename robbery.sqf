IF (!IsServer) ExitWith {};
_Array = RobberyArray;
_wp1 = SelectRandom _Array;
_array = _array - [_wp1];
_wp2 = SelectRandom _Array;
_array = _array - [_wp2];
_manarr = [];
_wparr = [_wp1,_wp2];

_type = "ROBBERY";
_tmpPos = [];


_driver = [getpos _wp1] call RobberyCarInit;
_group = group _driver;
_vehicle = vehicle _driver;
_vehicle setdir (getdir _wp1);
_manarr = _manarr + [_driver];
GetawayDriver = _driver;
GetawayCar = _vehicle;

_maxcivs = 2 + (random 3);
_i = 0;
_dist = 25;
_unitArray = [];

While {_i < _maxcivs} do {
_i = _i + 1;
_pos = [(getpos _wp1 select 0)+_dist-random(_dist*2),(getpos _wp1 select 1)+_dist-random(_dist*2),0];
_Spawn = [_pos] call RobberyAccompliceInit;
[_spawn] join _driver;
_spawn domove [(getpos _wp1 select 0)+_dist-random(_dist*2),(getpos _wp1 select 1)+_dist-random(_dist*2),0];
_manarr = _manarr + [_spawn];
sleep 0.1;
};


sleep 0.1;
_wp = _group addwaypoint [getpos _wp1,0];
_wp setWaypointTimeout [60*1, 60*2, 60*3];
_wp setwaypointtype "MOVE";
_group setspeedmode "FULL";
_wp setwaypointstatements ["true","{IF (_x != driver (vehicle (leader _x))) then {_x assignascargo (vehicle (leader _x));[_x] ordergetin TRUE}} foreach units (group this);this execvm ""robberylosemoney.sqf"""];
_wp setWaypointCompletionRadius 50;
_wp setwaypointSpeed "FULL";

sleep 0.1;
_wp = _group addwaypoint [getpos _wp2,0];
_wp setwaypointtype "MOVE";
_group setspeedmode "FULL";
_wp setwaypointstatements ["true","this execvm ""NewchaseWP.sqf"""];
_wp setWaypointCompletionRadius 50;
_wp setwaypointSpeed "FULL";


[_manarr,_vehicle] execvm "chasecarcheck.sqf";

MissionStatus = [_type,_manarr,_wparr,"Init"];
Publicvariable "MissionStatus";

[[_driver,_manarr,_type,_wparr],"Briefing.sqf"] RemoteExec ["ExecVM",0];

sleep 5;
_obj = ["Stop the robbery in progress","Robbery",""];
[West,["ROBBERY"],_obj,(getpos _wp1),"ASSIGNED",3,true] call BIS_fnc_taskCreate;
[West,["ROBBERYSub","ROBBERY"],["Destination","Getaway direction",""],(getpos _wp2),"Created",3,true] call BIS_fnc_taskCreate;
["ROBBERY",true] call BIS_fnc_taskSetAlwaysVisible;
["ROBBERYSub",true] call BIS_fnc_taskSetAlwaysVisible;
CurrentTaskArray = ["ROBBERY","ROBBERYSub"];
sleep 2;
(SelectRandom PSI_CautionSounds) remoteExec ["PSI_PlaySound",0];
sleep 5;
(SelectRandom PSI_104Sounds) remoteExec ["PSI_PlaySound",0];