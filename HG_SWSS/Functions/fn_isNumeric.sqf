/*
    Author - HoverGuy
    © All Fucks Reserved
*/
params["_value","_in","_array","_out","_valid","_return"];

_in = str _value; 
_array = toArray(_in); 
_out = [];
_valid = ["0","1","2","3","4","5","6","7","8","9"];
_return = true;

for "_i" from 0 to (count _array)-1 do 
{
    _out pushBack toString([_array select _i]);
};

{
    if(_x in _valid) then
	{
	} else {
	    _return = false;
	};
} forEach _out;

_return;
