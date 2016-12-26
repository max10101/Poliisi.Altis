#define false 0
#define true  1
/*
    Author - HoverGuy
	© All Fucks Reserved

    Defines available shops and their content and global config
	
	currencyType - STRING - Currency you want to use
	enableSave - BOOL - Save money?
	resetSavedMoney - BOOL - Reset saved money? Useful if you enable persistence then disable it and re-enable it, if it's set to true old saved money will be reset to startCash value, only used if enableSave is set to true
	enableHUD - BOOL - Enable money display in HUD?
	enablePaycheck - BOOL - Enable paycheck?
	
	class HG_MoneyCfg
	{
		class Rank - Can be PRIVATE/CORPORAL/SERGEANT/LIEUTENANT/CAPTAIN/MAJOR/COLONEL
		{
			paycheck - INTEGER - Paycheck amount
			paycheckPeriod - INTEGER - Time (in minutes) between each paycheck iteration, only used if enablePaycheck is set to true
			startCash - INTEGER - Obvious...
		};
	};
	
	class HG_WeaponsShopCfg
    {
		class YourShopClass - Used as a param for the call, basically the shop you want to display
		{
		    whitelisted - BOOL - Is the shop whitelisted?
		    whitelistRank - STRING - Can be PRIVATE/CORPORAL/SERGEANT/LIEUTENANT/CAPTAIN/MAJOR/COLONEL, not used when whitelisted is set to false
		
		    class YourShopCategory - Shop category, can be whatever you want (PewPewLaserGun, Weapons, BigFatGuns, etc...)
		    {
				displayName - STRING - Category display name
				items - ARRAY - Shop content
				|- 0 - STRING - Classname
				|- 1 - INTEGER - Price
		    };
		};
	};
*/

currencyType = "$";
enableSave = false;
resetSavedMoney = false;
enableHUD = false;
enablePaycheck = false;

class HG_MoneyCfg
{
	class PRIVATE
	{
		paycheck = 2000;
		paycheckPeriod = 30;
		startCash = 50000;
	};
	class CORPORAL
	{
		paycheck = 4000;
		paycheckPeriod = 30;
		startCash = 50000;
	};
	class SERGEANT
	{
		paycheck = 6000;
		paycheckPeriod = 30;
		startCash = 50000;
	};
	class LIEUTENANT
	{
		paycheck = 8000;
		paycheckPeriod = 30;
		startCash = 50000;
	};
	class CAPTAIN
	{
		paycheck = 10000;
		paycheckPeriod = 30;
		startCash = 50000;
	};
	class MAJOR
	{
		paycheck = 12000;
		paycheckPeriod = 30;
		startCash = 50000;
	};
	class COLONEL
	{
		paycheck = 14000;
		paycheckPeriod = 30;
		startCash = 50000;
	};
};


class HG_WeaponsShopCfg // Has to be left untouched
{
	class HG_DefaultShop // Default shop is just a placeholder for testing purposes, you can delete it completely and make your own
	{
		whitelisted = false;
		whitelistRank = "";
		
        class Pistols
	    {
	        displayName = "Pistols";
		    items[] =
		    {
		        {"hgun_Pistol_01_F",500},
				{"hgun_Rook40_F",1000},
                {"hgun_P07_F",1500},
				{"hgun_Pistol_heavy_02_F",3000},
		        {"hgun_ACPC2_F",4000},
				{"hgun_Pistol_heavy_01_F",5000}
		    };
	    };
		
		class Rifles
	    {
	        displayName = "Heavy Weapons";
		    items[] =
		    {
		        {"SMG_05_F",8000},
				{"SMG_01_F",10000},
                {"srifle_LRR_F",15000}
		    };
	    };
	
	    class Items
	    {
	        displayName = "$STR_HG_SHOP_ITEMS";
		    items[] =
		    {
		        {"ItemWatch",100},
			    {"ItemCompass",100},
			    {"ItemGPS",500},
			    {"ItemRadio",100},
			    {"ItemMap",100}
		    };
	    };
	
	    class Magazines
	    {
	        displayName = "Magazines";
		    items[] =
		    {
		        {"10Rnd_9x21_Mag",100},
                {"16Rnd_9x21_Mag",200},
	            {"30Rnd_9x21_Mag",600},
				{"6Rnd_45ACP_Cylinder",600},
				{"30Rnd_9x21_Mag_SMG_02",1200},
				{"30Rnd_45ACP_Mag_SMG_01",1500},
				{"7Rnd_408_Mag",1500}
		    };
	    };
		
	
	    class Scopes
	    {
	        displayName = "$STR_HG_SHOP_SCOPES";
		    items[] =
		    {
		        {"optic_Arco",1000},
			    {"optic_Hamr",1000}
		    };
	    };
		class Silencers
	    {
	        displayName = "Silencers";
		    items[] =
		    {
		        {"muzzle_snds_L",2000},
			    {"muzzle_snds_acp",2000}
		    };
	    };
		class Armor
	    {
	        displayName = "Body Armor";
		    items[] =
		    {
		        {"PSI_police_vest",1000},
			    {"PSI_swat_vest",1000},
				{"PSI_swat_helmet",1000},
				{"PSI_police_belt",200},
				{"PSI_sniper_cap",100},
				{"FirstAidKit",100}
		    };
		};
		class Accessories
	    {
	        displayName = "Accessories";
		    items[] =
		    {
				{"FirstAidKit",100},
				{"Toolkit",2000},
				{"B_AssaultPack_blk",1000}
				
		    };
	    };
	};
};