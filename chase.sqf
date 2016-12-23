_Array = ChaseArray;
_3way = false;
_race = false;
_man2 = objnull;
_group2 = objnull;
_wp1 = SelectRandom _Array;
_array = _array - [_wp1];
_wp2 = SelectRandom _Array;
_array = _array - [_wp2];
_wp3 = SelectRandom _Array;
_manarr = [];
_wparr = [_wp1,_wp2];
_type = "CHASE";
_tmpPos = [];

IF (_wp1 distance2d _wp2 < MinChaseDistance) then {_3way = true;_wparr = _wparr + [_wp3]};
_man = [getpos _wp1] call CrimCarInit;
_group = group _man;
_vehicle = vehicle _man;
_manarr = _manarr + [_man];
sleep 1;
IF (([typeof _vehicle] in ["psi_sportscar1","psi_sportscar2","psi_sportscar3"]) && (Random 1 > 0)) then {_race = true;};
_race = true;
IF (_race) then {
_tmpPos = (getpos _wp1) findemptyposition [10,100,typeof _vehicle];
_man2 = [_tmpPos] call CrimCarInit;_group2 = group _man2;_type = "RACE";_manarr = _manarr + [_man2]
};

sleep 1;
_wp = _group addwaypoint [getpos _wp2,0];
[_group,0] setwaypointtype "MOVE";
_group setspeedmode "FULL";

IF (_race) then {
_wp = _group2 addwaypoint [getpos _wp2,0];
[_group2,0] setwaypointtype "MOVE";
_group2 setspeedmode "FULL";
};


if (_3way) then {
  _group addwaypoint [getpos _wp3,5,1];
  [_group,1] setwaypointtype "MOVE";
  [_group,1] setwaypointstatements ["true",""];
  IF (_race) then {
    _group2 addwaypoint [getpos _wp3,5,1];
    [_group2,1] setwaypointtype "MOVE";
    [_grou2p,1] setwaypointstatements ["true",""];
  };
} else {
  [_group,1] setwaypointstatements ["true","this setvariable [""success"",true,true];"];
  IF (_race) then {
     [_group2,1] setwaypointstatements ["true","this setvariable [""success"",true,true];"];
  };
};


MissionStatus = [_type,_manarr,_wparr,"Init"];
Publicvariable "MissionStatus";
titleCut ["", "BLACK OUT", 5];
systemchat format ["%4 START %1 THROUGH %2 TO %3 (3way %5)",_wp1 call BIS_fnc_locationDescription,_wp2 call BIS_fnc_locationDescription,_wp3 call BIS_fnc_locationDescription,MissionStatus select 0,_3way];
sleep 5;
[_man,_manarr,_type,_wparr] execvm "Briefing.sqf";
sleep 0.1;
titleCut ["", "BLACK IN", 0.5];



