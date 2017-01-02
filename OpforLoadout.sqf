if(isServer) then {

	_unit = _this select 0;
	_unit setvariable ["armed",true,true];
	_unitClass = typeOf _unit;
	//IF (player == _unit) exitwith {};

	/*_unitform = ["U_BG_Guerilla1_1","U_BG_Guerilla2_1","U_BG_Guerilla2_2","U_BG_Guerilla2_3","U_BG_Guerilla3_1","U_BG_Guerilla3_2","U_BG_Guerrilla_6_1","U_BG_leader"] call BIS_fnc_selectRandom;
	_unit forceAddUniform _unitform;
	
	if(floor(random 2) == 1) then {
		_headgear = ["H_ShemagOpen_khk","none","H_Shemag_olive","H_ShemagOpen_tan","none"] call BIS_fnc_selectRandom;
		if(_headgear != "none") then { _unit addHeadgear _headgear };
	} else {
		_goggles = ["G_Balaclava_blk","none","G_Balaclava_oli"] call BIS_fnc_selectRandom;
		if(_goggles != "none") then { _unit addGoggles _goggles };
	};*/
	
	_vest = ["V_BandollierB_cbr","V_HarnessO_brn","V_Rangemaster_belt","V_HarnessOSpec_brn"] call BIS_fnc_selectRandom;
	_unit addVest _vest;
	
	_unit addItemToVest "FirstAidKit";
	
	/*if(floor(random 2) == 1) then {
		_unit addItemToVest "FirstAidKit";
		_unit addItemToVest "SmokeShellGreen";
		_unit addItemToVest "SmokeShellRed";
	} else {
		_unit addItemToVest "SmokeShell";
	};*/
	

	_weapon = ["SMG_01_F", "SMG_02_F","hgun_ACPC2_F", "hgun_ACPC2_F", "hgun_PDW2000_F", "hgun_Pistol_heavy_01_F", "hgun_Pistol_heavy_02_F"] call BIS_fnc_selectRandom;

	for "_i" from 1 to 3 do {_unit addItemToVest ((getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines")) select 0);};
	for "_i" from 1 to 3 do {_unit addItemToUniform ((getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines")) select 0);};

	_unit addWeapon _weapon;

	
	if(true) then {
		if(true) then {
			_unit addPrimaryWeaponItem "acc_flashlight";
			_unit enableGunLights "forceOn";
		} else {
			_unit linkItem "NVGoggles";
		};
	};
};




