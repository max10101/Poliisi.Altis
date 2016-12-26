// EXECUTE SCRIPTS (ALL PLAYERS)

//[] execvm "Engima\Civilians\init.sqf";
//[] execvm "Engima\Traffic\init.sqf";
IF (IsServer) then {[] execvm "radio.sqf"};

//************************************************
//EVENTHANLDER FOR MARKERS

addMissionEventHandler ["Draw3D",{
{
private ["_condition","_pos","_target"];
_target = _x;
_condition = [(vehicle _target), "VIEW"] checkVisibility [eyePos player, eyePos _target];
_pos = [getposATL _target select 0,getposATL _target select 1,(getposATL _target select 2)+3];
		if (_condition > 0.5 && (player distance _target) < 50) then {
			drawIcon3D ["\a3\ui_f\data\map\markers\nato\o_inf.paa", EAST call BIS_fnc_sideColor, _pos, 1, 1, 0, "SUSPECT", 0];
		};
		} Foreach (MissionStatus select 1);
	}];

//************************************************
// ALL VARIABLE INIT

AmmoBox addAction["<img image='HG_SWSS\UI\gun.paa' size='1.5'/><t color='#FF0000'>Open Weapons Shop</t>",{_this call HG_fnc_dialogOnLoadItems},"HG_DefaultShop",0,false,false,"",'(alive player) && !dialog'];
player addAction["<img image='HG_SWSS\UI\money.paa' size='1.5'/><t color='#FF0000'>Give Money</t>",{HG_CURSOR_OBJECT = cursorObject; createDialog "HG_GiveMoney"},"",0,false,false,"",'(alive player) AND (IsPlayer cursorObject) AND (alive cursorObject) AND (player distance cursorObject < 2) AND !dialog'];

MissionDebrief = [0,0];
//Cartypes = ["PSI_sportscar1","PSI_sportscar2","PSI_sportscar3","C_Offroad_01_F","C_SUV_01_F","C_Van_01_transport_F"];
Cartypes = ["PSI_sportscar1","PSI_sportscar2","PSI_sportscar3"];
Enemytypes = ["C_man_p_fugitive_F","C_man_p_shorts_1_F","C_man_p_beggar_F","C_man_polo_4_F_afro","C_man_shorts_4_F_asia","c_nikos","c_orestes"];
Missiontypes = ["Chase.sqf","chase.sqf","chase.sqf"];
//Missiontypes = ["Chase.sqf","Robbery.sqf","Riot.sqf"];
Cityarray = [City,City_1,City_2,City_3,City_4,City_5,City_6,City_7,City_8,City_9];
Chasearray = [Road,Road_1,Road_2,Road_3,Road_4,Road_5,Road_6,Road_7,Road_8,Road_9,Road_10,Road_11,Road_12];
GasStationArray = [GasStation,GasStation_1,GasStation_2,GasStation_3];
FailChase = [];
FailRiot = [];
FailRobbery = [];
NewMission = [];
MissionComplete = true;
MinChaseDistance = 2000;
SuspectOnFoot = False;
SuspectDead = false;
SuspectArrested = false;
FirstChase = true;
StartingCash = 1500;
NewMoney = 0;
CurrentTaskArray = [];
Payday = 0;
Debug = true;
PSI_104Sounds = ["psi_104_1","psi_104_2","psi_104_3","psi_104_4","psi_104_5","psi_104_6","psi_104_7","psi_104_8","psi_104_9","psi_104_10"];
PSI_ArrestSounds = ["psi_arrest_1","psi_arrest_2","psi_arrest_3","psi_arrest_4","psi_arrest_5","psi_arrest_6","psi_arrest_7","psi_arrest_8"];
PSI_BackupSounds = ["psi_backup_1","psi_backup_2","psi_backup_3","psi_backup_4","psi_backup_5","psi_backup_6"];
PSI_BullhornSounds = ["psi_bullhorn_1","psi_bullhorn_2","psi_bullhorn_3","psi_bullhorn_4","psi_bullhorn_5"];
PSI_CautionSounds = ["psi_caution_1","psi_caution_2","psi_caution_3","psi_caution_4","psi_caution_5","psi_caution_6","psi_caution_7","psi_caution_8","psi_caution_9","psi_caution_10"];
PSI_KilledSounds = ["psi_killed_1","psi_killed_2","psi_killed_3","psi_killed_4","psi_killed_5","psi_killed_6","psi_killed_7","psi_killed_8","psi_killed_9","psi_killed_10"];
PSI_PursuitSounds = ["psi_pursuit_1","psi_pursuit_2","psi_pursuit_3","psi_pursuit_4","psi_pursuit_5","psi_pursuit_6","psi_pursuit_7","psi_pursuit_8","psi_pursuit_9"];
PSI_RespondSounds = ["psi_respond_1","psi_respond_2","psi_respond_3","psi_respond_4","psi_respond_5","psi_respond_6"];
PSI_SuspectDownSounds = ["psi_suspectdown_1","psi_suspectdown_2","psi_suspectdown_3","psi_suspectdown_4"];
PSI_AmbientSounds = ["psi_ambient_1","psi_ambient_2","psi_ambient_3"];

//mission status should be [TYPE , PERPS TO BE ARRESTED, WP/Positions , STATUS ("Init","Ongoing","Completed","None")] 
MissionStatus = ["None",[],[],"None"];

psi_establishingShot = compile preprocessfile "psi_establishingshot.sqf";

//************************************************
//ALL CALL FUNCTIONS INIT

//FUTURE - USE NEARESTROADS TO SPAWN CARS
//call with [_pos,_unittype,_cartype] call CrimInit OR just [pos] call crimcarinit
CrimCarInit = compile '
params [["_pos",[]],["_unittype",selectRandom EnemyTypes],["_cartype",selectRandom Cartypes]];
private ["_unittype","_cartype","_group","_car","_unit"];
_group = creategroup East;
_unit = _group createUnit [_unittype, _pos, [], 1, "NONE"];
[_unit,["Arrest","arrest.sqf",true,10]] remoteExec ["AddAction",0];
_unit setvariable ["arrested",false,true];
_unit setskill 1;
_unit setskill ["aimingAccuracy",0.3];_unit setskill ["aimingshake",0.2];_unit setskill ["aimingSpeed",0.8];
_unit setbehaviour "CARELESS";
_unit setcombatmode "BLUE";
_unit addeventhandler ["GetOutMan",{(_this select 0) setbehaviour "COMBAT";(_this select 0) setcombatmode "RED";(_this select 0) setunitpos "UP"}];


_car = _cartype createvehicle _pos;
_unit assignasdriver _car;
_unit moveindriver _car;
_group addvehicle _car;
_unit
';

CrimSucceeded = compile '

';

CrimStopped = compile '
private ["_tmp"];
_tmp = (MissionStatus select 1) - [_man];
MissionStatus set [1,_tmp];
IF (!(alive _man)) then {MissionDebrief set [1,((MissionDebrief select 1) + 1)]};
IF (_man getvariable ["arrested",false]) then {MissionDebrief set [0,((MissionDebrief select 0) + 1)]};
IF (Debug) then {Systemchat format ["%1 removed from MissionStatus due to killed/arrested - %2",_man,MissionStatus select 1]}
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

			MissionStatus set [3,"Ongoing"];
			MissionStartTime = time;
			//MissionStatus execVM "Briefing.sqf";
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

		_args = [MissionStatus,time - MissionStartTime,MissionDebrief];
		[_args,"debriefing.sqf"] remoteExec ["execVM",0];
		{_x call BIS_fnc_DeleteTask} foreach CurrentTaskArray;CurrentTaskArray = [];
		MissionStatus set [3,"None"];
		};
	
		Case "None" : {

			//MissionStatus execVM "NewMission.sqf";
			MissionDebrief = [0,0];
		};
	
		Default {sleep 1;};
	};
};
