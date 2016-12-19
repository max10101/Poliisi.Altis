_vehicle = _this;
ClearItemCargo _vehicle;
clearweaponcargo _vehicle;
clearmagazinecargo _vehicle;
clearbackpackcargo _vehicle;
IF (IsServer) Then {_vehicle additemcargoglobal ["FirstAidKit",4];_vehicle addbackpackcargoglobal ["B_Assaultpack_rgr_Repair",1]};