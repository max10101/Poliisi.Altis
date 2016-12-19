_unit = _this select 0;
_player = _this select 1;
IF (Money >= 1000) Then {
	Hint format ["MAN Purchased\nYou have $%1 Remaining",Money];Money = Money - 1000;Publicvariable "Money";[_unit] join group _player
} Else {
	Hint format ["Insufficient Funds\nYou have $%1 remaining",Money];
}