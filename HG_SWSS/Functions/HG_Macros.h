#include "..\UI\HG_IDCS.h"

#define HG_WEAPONS_SHOP_DISP	  findDisplay HG_WEAPONS_SHOP_IDD
#define HG_WEAPONS_ITEM_LIST	  (HG_WEAPONS_SHOP_DISP displayCtrl HG_WEAPONS_ITEM_LIST_IDC)
#define HG_WEAPONS_ITEM_TEXT	  (HG_WEAPONS_SHOP_DISP displayCtrl HG_WEAPONS_ITEM_TEXT_IDC)
#define HG_WEAPONS_ITEM_PICTURE	  (HG_WEAPONS_SHOP_DISP displayCtrl HG_WEAPONS_ITEM_PICTURE_IDC)
#define HG_WEAPONS_ITEM_SWITCH	  (HG_WEAPONS_SHOP_DISP displayCtrl HG_WEAPONS_ITEM_SWITCH_IDC)
#define HG_WEAPONS_BUY			  (HG_WEAPONS_SHOP_DISP displayCtrl HG_WEAPONS_BUY_IDC)
#define HG_WEAPONS_MC             (HG_WEAPONS_SHOP_DISP displayCtrl HG_WEAPONS_MC_IDC)

#define HG_HUD_DISP               (uiNamespace getVariable ["HG_HUD",displayNull])
#define HG_HUD_TEXT               (HG_HUD_DISP displayCtrl HG_HUD_TEXT_IDC)

#define HG_GM_DISP                findDisplay HG_GM_IDD
#define HG_GM_EDIT                (HG_GM_DISP displayCtrl HG_GM_EDIT_IDC)
