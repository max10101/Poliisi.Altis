// EXECUTE SCRIPTS (ALL PLAYERS)

[] execvm "Engima\Civilians\init.sqf";
[] execvm "Engima\Traffic\init.sqf";
//IF (IsServer) then {[] execvm "radio.sqf"};
[] execvm "markers.sqf";
Bossman addAction["<t color='#FF0000'>Collect Pay cheque</t>",{_this call PayDayFnc},"",100,true,true,"",'(alive player) && !dialog',10];
Bossman addAction["<t color='#FF0000'>Skip current mission</t>",{NewMoney = 0;publicvariable "NewMoney";MissionStatus set [1,[]];MissionStatus set [3,"Completed"]},"",-1,true,true,"",'(alive player) && !dialog',10];
//************************************************
//EVENTHANLDER FOR MARKERS

addMissionEventHandler ["Draw3D",{
{
private ["_condition","_pos","_target"];
_target = _x;
_condition = [(vehicle _target), "VIEW"] checkVisibility [eyePos player, eyePos _target];
_pos = [getposATL _target select 0,getposATL _target select 1,(getposATL _target select 2)+3];
		if (_condition > 0.5 && (player distance _target) < 75) then {
			drawIcon3D ["\a3\ui_f\data\map\markers\nato\o_inf.paa", EAST call BIS_fnc_sideColor, _pos, 0.7, 0.7, 0, "SUSPECT", 0];
		};
		} Foreach (MissionStatus select 1);
	}];

//************************************************
// ALL VARIABLE INIT

AmmoBox addAction["<img image='HG_SWSS\UI\gun.paa' size='1.5'/><t color='#FF0000'>Open Weapons Shop</t>",{_this call HG_fnc_dialogOnLoadItems},"HG_DefaultShop",0,false,false,"",'(alive player) && !dialog'];
AllCarArray = [];
LastVoiceTime = 0;
SoundDelayTime = 3;
SpikeStripSet = false;
MusicSound = objnull;
CleanUpArray = [];
MissionDebrief = [0,0];
//Cartypes = ["PSI_sportscar1","PSI_sportscar2","PSI_sportscar3","C_Offroad_01_F","C_SUV_01_F","C_Van_01_transport_F"];
Cartypes = ["PSI_sportscar1","PSI_sportscar2","PSI_sportscar3"];
RobberyCartypes = ["C_Offroad_01_F","C_Van_01_transport_F"];
Enemytypes = ["C_man_p_fugitive_F","C_man_p_shorts_1_F","C_man_p_beggar_F","C_man_polo_4_F_afro","C_man_shorts_4_F_asia","c_nikos","c_orestes"];
Missiontypes = ["Chase.sqf","chase.sqf","chase.sqf"];
//Missiontypes = ["Chase.sqf","Robbery.sqf","Riot.sqf"];
Cityarray = [City,City_1,City_2,City_3,City_4,City_5,City_6,City_7,City_8,City_9];
Chasearray = [Road,Road_1,Road_2,Road_3,Road_4,Road_5,Road_6,Road_7,Road_8,Road_9,Road_10,Road_11,Road_12];
GasStationArray = [GasStation,GasStation_1,GasStation_2,GasStation_3];
ChurchArray = [Church,Church_1,Church_2,Church_3,Church_4];
RobberyArray = GasStationArray + ChurchArray;
FailChase = [];
FailRiot = [];
FailRobbery = [];
MissionStartTime = 0;
NewMission = [];
MissionComplete = true;
MinChaseDistance = 1000;
SuspectOnFoot = False;
SuspectDead = false;
SuspectArrested = false;
FirstChase = true;
StartingCash = 3000;
NewMoney = 0;
CurrentTaskArray = [];
Payday = 0;
Debug = true;
PSI_104Sounds = ["psi_104_1","psi_104_2","psi_104_3","psi_104_4","psi_104_5","psi_104_6","psi_104_7","psi_104_8","psi_104_9","psi_104_10"];
PSI_ArrestSounds = ["psi_arrest_4","psi_arrest_5","psi_arrest_6","psi_arrest_7","psi_arrest_8"];
PSI_ArresterSounds = ["psi_arrest_1","psi_arrest_2","psi_arrest_3"];
PSI_BackupSounds = ["psi_backup_1","psi_backup_2","psi_backup_3","psi_backup_4","psi_backup_5","psi_backup_6"];
PSI_BullhornSounds = ["psi_bullhorn_1","psi_bullhorn_2","psi_bullhorn_3","psi_bullhorn_4","psi_bullhorn_5"];
PSI_CautionSounds = ["psi_caution_1","psi_caution_2","psi_caution_3","psi_caution_4","psi_caution_5","psi_caution_6","psi_caution_7","psi_caution_8","psi_caution_9","psi_caution_10"];
PSI_KilledSounds = ["psi_killed_1","psi_killed_2","psi_killed_3","psi_killed_4","psi_killed_5","psi_killed_10"];
PSI_KilledByShotSounds = ["psi_killed_6","psi_killed_7","psi_killed_8","psi_killed_9"];

PSI_PursuitSounds = ["psi_pursuit_1","psi_pursuit_2","psi_pursuit_3","psi_pursuit_4","psi_pursuit_5","psi_pursuit_6","psi_pursuit_7","psi_pursuit_8","psi_pursuit_9"];
PSI_RespondSounds = ["psi_respond_1","psi_respond_2","psi_respond_3","psi_respond_4","psi_respond_5","psi_respond_6"];
PSI_SuspectDownSounds = ["psi_suspectdown_1","psi_suspectdown_2","psi_suspectdown_3","psi_suspectdown_4"];
PSI_AmbientSounds = ["psi_ambient_1","psi_ambient_2","psi_ambient_3"];
_list = [];
//mission status should be [TYPE , PERPS TO BE ARRESTED, WP/Positions , STATUS ("Init","Ongoing","Completed","None")] 
MissionStatus = ["None",[],[],"wait"];

psi_establishingShot = compile preprocessfile "psi_establishingshot.sqf";

//************************************************
//ALL CALL FUNCTIONS INIT

PayDayFnc = compile '
if (PayDay <= 0) then {hint "You have nothing to collect!\nDo some work!"} else {
(_this select 1) setvariable ["HG_myCash",((_this select 1) getvariable "HG_myCash") + PayDay];
Hint format ["You collect a cheque for $%1\nYou have $%2",PayDay,(_this select 1) getvariable "HG_myCash"];
PayDay = 0;
playsound "kaching";
[1] call HG_fnc_HUD;
};
';

PSI_PlaySound = compile '
IF (time >= (LastVoiceTime + SoundDelayTime)) then {
playsound (_this);
LastVoiceTime = time;
};
';

PaydayPayFnc = compile '
Payday = Payday + (_this select 0);
IF (Payday < 0) then {Payday = 0};
';

//this is GLOBAL killed EH
CrimKilledEH = compile '
private ["_man","_killer"];
_man = _this select 0;
_killer = _this select 2;
IF (_man getvariable ["armed",false]) then {
		removeallweapons _man;
		If (isPlayer _killer) then {
		
		//ARMED CIVILIAN KILLED BY PLAYER
		IF (local _killer) then {
		(SelectRandom PSI_SuspectDownSounds) remoteExec ["PSI_PlaySound",0];
		};
			} else {
			
		//ARMED CIVILIAN KILLED BY ACCIDENT/CAR
		
			};
	} else {
	If (isPlayer _killer) then {
	
	//UNARMED CIVILIAN KILLED BY PLAYER
	hint format ["An unarmed civilian has died.\nInternal Affairs has traced the bullets to %1s weapon.\n -$500",name _killer];
	IF (IsServer) then {NewMoney = NewMoney - 500};
	
			} else {
			
	//UNARMED CIVILIAN KILLED BY CAR/ACCIDENT
	IF (!(_man getvariable ["arrested",false])) then {
		hint format ["An unarmed civilian has died in an accident.\nLocals blame police response.\n -$100",name _killer];
		IF (IsServer) then {NewMoney = NewMoney - 100};
	};
			};
	};
';

//local EH
PlayerKilledEH = compile '
private ["_man","_killer"];
_man = _this select 0;
_killer = _this select 2;
IF (_killer == objnull) then {
(SelectRandom PSI_KilledSounds) remoteExec ["PSI_PlaySound",0];
} else {
IF (side _killer == east) then {
(SelectRandom PSI_KilledByShotSounds) remoteExec ["PSI_PlaySound",0];
} else {
(SelectRandom PSI_KilledSounds) remoteExec ["PSI_PlaySound",0];
};
};
';

//FUTURE - USE NEARESTROADS TO SPAWN CARS
//call with [_pos,_unittype,_cartype] call CrimInit OR just [pos] call crimcarinit
CrimCarInit = compile '
params [["_pos",[]],["_unittype",selectRandom EnemyTypes],["_cartype",selectRandom Cartypes]];
private ["_unittype","_cartype","_group","_car","_unit"];
_group = creategroup East;
_unit = _group createUnit [_unittype, _pos, [], 1, "NONE"];
[_unit] join _group;
[_unit,["<t color=""#FF0000"">Arrest</t>","arrest.sqf",[],10,true,true,"","CursorObject == _Target",3]] remoteExec ["AddAction",0];
_unit setvariable ["arrested",false,true];
_unit setskill 1;
_unit setskill ["aimingAccuracy",0.3];_unit setskill ["aimingshake",0.2];_unit setskill ["aimingSpeed",0.8];
_unit setbehaviour "CARELESS";
_unit setcombatmode "BLUE";
_unit addeventhandler ["GetOutMan",{(_this select 0) setbehaviour "COMBAT";(_this select 0) setcombatmode "RED";(_this select 0) setunitpos "UP";(_this select 0) disableAI "FSM"}];
_unit addMPeventhandler ["MPKilled",{_this call CrimKilledEH}];
_unit allowfleeing 0;
IF (random 1 > 0.5) then {[_unit] execvm "OpforLoadout.sqf"};
_car = _cartype createvehicle _pos;
CleanupArray = CleanupArray + [_unit];
addToRemainsCollector [_car];
_unit assignasdriver _car;
_unit moveindriver _car;
_group addvehicle _car;
[[_car],"pullout.sqf"] RemoteExec ["ExecVM",0];
_unit
';

CrimCarAccompliceInit = compile '
params [["_pos",[]],["_unittype",selectRandom EnemyTypes],["_cartype",selectRandom Cartypes]];
private ["_unittype","_cartype","_group","_car","_unit"];
_group = creategroup East;
_unit = _group createUnit [_unittype, _pos, [], 1, "NONE"];
[_unit] join _group;
[_unit,["<t color=""#FF0000"">Arrest</t>","arrest.sqf",[],10,true,true,"","CursorObject == _Target",3]] remoteExec ["AddAction",0];
_unit setvariable ["arrested",false,true];
_unit setskill 1;
_unit setskill ["aimingAccuracy",0.3];_unit setskill ["aimingshake",0.2];_unit setskill ["aimingSpeed",0.8];
_unit setbehaviour "CARELESS";
_unit setcombatmode "BLUE";
_unit addeventhandler ["GetOutMan",{(_this select 0) setbehaviour "COMBAT";(_this select 0) setcombatmode "YELLOW";(_this select 0) setunitpos "UP"}];
_unit addMPeventhandler ["MPKilled",{_this call CrimKilledEH}];
_unit allowfleeing 0;
CleanupArray = CleanupArray + [_unit];
IF (random 1 > 0.3) then {[_unit] execvm "OpforLoadout.sqf"};
_unit
';


RobberyCarInit = compile '
params [["_pos",[]],["_unittype",selectRandom EnemyTypes],["_cartype",selectRandom RobberyCartypes]];
private ["_unittype","_cartype","_group","_car","_unit"];
_group = creategroup East;
_unit = _group createUnit [_unittype, _pos, [], 1, "NONE"];
[_unit] join _group;
[_unit,["<t color=""#FF0000"">Arrest</t>","arrest.sqf",[],10,true,true,"","CursorObject == _Target",3]] remoteExec ["AddAction",0];
_unit setvariable ["arrested",false,true];
_unit setskill 1;
_unit setskill ["aimingAccuracy",0.3];_unit setskill ["aimingshake",0.2];_unit setskill ["aimingSpeed",0.8];
_unit setbehaviour "CARELESS";
_unit setcombatmode "YELLOW";
_unit addeventhandler ["GetOutMan",{(_this select 0) setbehaviour "COMBAT";(_this select 0) setcombatmode "RED";(_this select 0) setunitpos "UP";(_this select 0) disableAI "FSM"}];
_unit addMPeventhandler ["MPKilled",{_this call CrimKilledEH}];
_unit allowfleeing 0;
IF (random 1 > 0.5) then {[_unit] execvm "OpforLoadout.sqf"};
_car = _cartype createvehicle _pos;
CleanupArray = CleanupArray + [_unit];
addToRemainsCollector [_car];
_unit assignasdriver _car;
_unit moveindriver _car;
_group addvehicle _car;
[[_car],"pullout.sqf"] RemoteExec ["ExecVM",0];
_unit
';

RobberyAccompliceInit = compile '
params [["_pos",[]],["_unittype",selectRandom EnemyTypes],["_cartype",selectRandom Cartypes]];
private ["_unittype","_cartype","_group","_car","_unit"];
_group = creategroup East;
_unit = _group createUnit [_unittype, _pos, [], 1, "NONE"];
[_unit] join _group;
[_unit,["<t color=""#FF0000"">Arrest</t>","arrest.sqf",[],10,true,true,"","CursorObject == _Target",3]] remoteExec ["AddAction",0];
_unit setvariable ["arrested",false,true];
_unit setskill 1;
_unit setskill ["aimingAccuracy",0.7];_unit setskill ["aimingshake",0.7];_unit setskill ["aimingSpeed",1];
_unit setbehaviour "CARELESS";
_unit setcombatmode "BLUE";
_unit addeventhandler ["GetOutMan",{(_this select 0) setbehaviour "COMBAT";(_this select 0) setcombatmode "RED";(_this select 0) setunitpos "UP"}];
_unit addMPeventhandler ["MPKilled",{_this call CrimKilledEH}];
_unit allowfleeing 0;
CleanupArray = CleanupArray + [_unit];
IF (random 1 > 0) then {[_unit] execvm "OpforLoadout.sqf"};
_unit
';

CrimRiotInit = compile '
params [["_pos",[]],["_unittype",selectRandom EnemyTypes]];
private ["_unittype","_cartype","_group","_car","_unit"];
_group = creategroup East;
_unit = _group createUnit [_unittype, _pos, [], 1, "NONE"];
[_unit] join _group;
[_unit,["<t color=""#FF0000"">Arrest</t>","arrest.sqf",[],10,true,true,"","CursorObject == _Target",3]] remoteExec ["AddAction",0];
_unit setvariable ["arrested",false,true];
_unit setskill 1;
_unit allowfleeing 0;
_unit setskill ["aimingAccuracy",0.1];_unit setskill ["aimingshake",0.1];_unit setskill ["aimingSpeed",0.8];
_unit setbehaviour "CARELESS";
IF (random 1 > 0.7) then {[_unit] execvm "OpforLoadout.sqf";_unit setbehaviour "AWARE"};
_unit setcombatmode "YELLOW";
_unit setunitpos "UP";
CleanupArray = CleanupArray + [_unit];
_unit addMPeventhandler ["MPKilled",{_this call CrimKilledEH}];
_unit
';

CrimSucceeded = compile '

';

CrimStopped = compile '
private ["_tmp"];
_tmp = (MissionStatus select 1) - [_man];
MissionStatus set [1,_tmp];
IF (!(alive _man)) then {MissionDebrief set [1,((MissionDebrief select 1) + 1)]};
IF (_man getvariable ["arrested",false]) then {
	MissionDebrief set [0,((MissionDebrief select 0) + 1)]
};
//PublicVariable "MissionStatus";
';

ArrestFnc = CompileFinal '
(_this select 0) removeaction (_this select 2);
IF (alive (_this select 0)) then {
	(_this select 0) setvariable ["arrested",true,true];
	removeallweapons (_this select 0);
	(_this select 0) playmoveNow "AmovPercMstpSsurWnonDnon";


IF ((_this select 0) getvariable ["armed",false]) then {
	hint format ["Hero cop %1 arrests armed suspect\n$500",name (_this select 1)];
	IF (IsServer) then {NewMoney = NewMoney + 500};
} else {
NewMoney = NewMoney + 200;
};
} else {hint "Suspect has already been subdued"};
';

Distcheck = compile '
private ["_IsWithinDist"];
_IsWithinDist = false;
{IF (((_this select 0) distance _x) < (_this select 2)) then {_IsWithinDist = true}} foreach (_this select 1);
_IsWithinDist
';

DistcheckUnit = compile '
private ["_IsWithinDist","_unit"];
_IsWithinDist = false;
_unit = ObjNull;
{IF (((_this select 0) distance _x) < (_this select 2)) then {_IsWithinDist = true;_unit = _x}} foreach (_this select 1);
[_IsWithinDist,_unit]
';

CompassHeading = compile ' 
private ["_dir","_h"];
_h = "none";
_dir = _this;
IF (_dir > 337.5 || _dir < 22.5) then {_h = "N"};
IF (_dir >= 22.5 && _dir < 67.5) then {_h = "NE"};
IF (_dir >= 67.5 && _dir < 112.5) then {_h = "E"};
IF (_dir >= 112.5 && _dir < 157.5) then {_h = "SE"};
IF (_dir >= 157.5 && _dir < 202.5) then {_h = "S"};
IF (_dir >= 202.5 && _dir < 247.5) then {_h = "SW"};
IF (_dir >= 247.5 && _dir < 292.5) then {_h = "W"};
IF (_dir >= 292.5 && _dir < 337.5) then {_h = "NW"};
_h
';

//************************************************
//FIRST WAIT
sleep 1;



//************************************************
//SERVER ONLY LOOP
_i = 0;
_pay = 0;
while {IsServer} do {

sleep 5;

	Switch (MissionStatus select 3) do {
		Case "Init" : {
			MissionDebrief = [0,0];
			MissionStatus set [3,"Ongoing"];
			MissionStartTime = time;
			NewMoney = 1500;
			IF ((MissionStatus select 0) in ["RACE"]) then {NewMoney = 2500};
			IF ((MissionStatus select 0) in ["RIOT"]) then {NewMoney = 2500};
			IF ((MissionStatus select 0) in ["CHASE"]) then {NewMoney = 1500};
			IF ((MissionStatus select 0) in ["ROBBERY"]) then {NewMoney = 3000};
		};
	
		Case "Ongoing" : {

			private ["_man","_i"];
			for [{_i=0},{_i<(count (MissionStatus select 1))},{_i=_i+1}] do {
				_man = (MissionStatus select 1) select _i;
				IF (_man getvariable ["success",false]) then {_man call CrimSucceeded};
				IF ((!(alive _man)) || (_man getvariable ["arrested",false])) then {_man call CrimStopped};
			};
			
			IF (count (MissionStatus select 1) <= 0) then {
				MissionStatus set [3,"Completed"];
			};
			
		};	
	
		Case "Completed" : {

		_args = [MissionStatus,time - MissionStartTime,MissionDebrief,NewMoney];
		[_args,"debriefing.sqf"] remoteExec ["execVM",0];
		{_x call BIS_fnc_DeleteTask} foreach CurrentTaskArray;CurrentTaskArray = [];
		MissionStatus set [3,"None"];
		
		//addToRemainsCollector CleanupArray;
		
			_clean = CleanupArray spawn {
			private ["_list"];
			_list = _this;
			{dostop _x} foreach _list;
			sleep 60*3;
			{deletevehicle _x} foreach _list;
			};
		
			CleanupArray = [];
			
			
		};
		
		Case "None" : {
			[NewMoney] remoteExec ["PaydayPayFnc", 0];
			NewMoney = 0;publicvariable "NewMoney";
			MissionDebrief = [0,0];
			[] execVM "NewMission.sqf";
			MissionStatus set [3,"wait"];
		};
	
		Default {sleep 1;};
	};
};