/*
    Author - HoverGuy
    © All Fucks Reserved
*/

while{alive player} do
{
    systemChat format[(localize "STR_HG_PAYCHECK_NOTF"),(getNumber(missionConfigFile >> "CfgClient" >> "HG_MoneyCfg" >> (rank player) >> "paycheckPeriod"))];
    uiSleep ((getNumber(missionConfigFile >> "CfgClient" >> "HG_MoneyCfg" >> (rank player) >> "paycheckPeriod")) * 60);
	[(getNumber(missionConfigFile >> "CfgClient" >> "HG_MoneyCfg" >> (rank player) >> "paycheck")),0] call HG_fnc_addOrSubCash;
	systemChat format[(localize "STR_HG_TIME_TO_PAY"),[(getNumber(missionConfigFile >> "CfgClient" >> "HG_MoneyCfg" >> (rank player) >> "paycheck"))] call BIS_fnc_numberText,(getText(missionConfigFile >> "CfgClient" >> "currencyType")),(getNumber(missionConfigFile >> "CfgClient" >> "HG_MoneyCfg" >> (rank player) >> "paycheckPeriod"))];
};
