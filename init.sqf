Money = 1500;
NewMoney = 0;
IF (true) ExitWith {};

Cartypes = ["poliisi_sportscar1","poliisi_sportscar2","poliisi_sportscar3","C_Offroad_01_F","C_SUV_01_F","C_Van_01_transport_F"];
Enemytypes = ["C_man_p_fugitive_F","C_man_p_shorts_1_F","C_man_p_beggar_F","C_man_polo_4_F_afro","C_man_shorts_4_F_asia"];
Missiontypes = ["Chase.sqf","chase.sqf","chase.sqf"];
//Missiontypes = ["Chase.sqf","Robbery.sqf","Riot.sqf"];
Chasearray = [City1,City2,City3];
FailChase = [];
FailRiot = [];
FailRobbery = [];
NewMission = [];
MissionComplete = true;
MinChaseDistance = 15;
SuspectOnFoot = False;
SuspectDead = false;
SuspectArrested = false;
_i = 0;
_pay = 0;
Payday = 0;
while {true} do
	{
	sleep 1;
	IF (Payday > 0) then {_pay = Payday; Payday = 0; 0=_pay execvm "pay.sqf"};
	IF (SuspectArrested) then {[West,"HQ"] sidechat "SUSPECT HAS BEEN ARRESTED";SuspectArrested = false;};
	IF (SuspectDead) then {[West,"HQ"] sidechat "SUSPECT HAS BEEN SUBDUED";SuspectDead = false;};
	IF (SuspectOnFoot) then {[West,"HQ"] sidechat "SUSPECT IS ON FOOT";SuspectOnFoot = false;};
	IF (Count FailChase > 0) then {sleep 0.1;_r = FailChase execvm "FailChase.sqf";FailChase = [];};
	//IF (Count FailRiot > 0) then {_r = FailRiot execvm "FailRiot.sqf";FailRiot = [];};
	//IF (Count FailRobbery > 0) then {_r = FailRobbery execvm "FailRobbery.sqf";FailRobbery = [];};
	IF (Count NewMission > 0) then {_r = NewMission execvm "NewMission.sqf";NewMission = [];};
	IF (IsServer && MissionComplete) then {Sleep 1;_mission = [] execvm (Missiontypes select random ((Count Missiontypes)-1));MissionComplete = false;};
	};