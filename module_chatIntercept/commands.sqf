pvpfw_chatIntercept_allCommands = [
	[
		"help",
		{
			_commands = "";
			{
				_commands = _commands + (pvpfw_chatIntercept_commandMarker + (_x select 0)) + ", ";
			}forEach pvpfw_chatIntercept_allCommands;
			systemChat format["Available Commands: %1",_commands];
		}
	],
	[
		"donate",
		{
			_amnt = round (parseNumber (_this select 0));
            
            //Donation reward tiers
            if (_amnt <= 0) then {
                //Invalid
                systemChat "Invalid donation amount.";
            };
            if (_amnt >= 1 && _amnt <= 10) then {
                _resources = _amnt * 100;
                [KP_liberation_supply_crate, _resources] call KPLIB_fnc_createCrate;
                [KP_liberation_ammo_crate, _resources] call KPLIB_fnc_createCrate;
                [KP_liberation_fuel_crate, _resources] call KPLIB_fnc_createCrate;
                systemChat "Supply, ammo, and fuel dropped.";
            };
            if (_amnt > 10 && _amnt <= 15) then {
                //Rep changes
                [2 * _amnt, false] remoteExec ["F_cr_changeCR", 2];
                combat_readiness = combat_readiness - (2 * _amnt) max 0;
                if (!isServer) then {
                    publicVariableServer "combat_readiness";
                };
                systemChat "Awareness and civilian reputation assuaged.";
            };
            if (_amnt > 15 && _amnt < 30) then {
                //APC Drop
                _pos = getPos player;
                _holder = createvehicle ["CFP_B_USARMY_1991_M113A3_Des_01", [_pos select 0, _pos select 1, 75], [], 0, "CAN_COLLIDE"];
                [objNull, _holder] call BIS_fnc_curatorobjectedited;
                
                systemChat "APC dropped.";            
            };
            if (_amnt >= 30 && _amnt < 40) then {
                //Tank Drop
                _pos = getPos player;
                _holder = createvehicle ["CFP_B_USARMY_1991_M1A1_Abrams_Des_01", [_pos select 0, _pos select 1, 75], [], 0, "CAN_COLLIDE"];
                [objNull, _holder] call BIS_fnc_curatorobjectedited;
                
                systemChat "Tank dropped.";
            };
            
            if (_amnt >= 40 && _amnt < 50) then {
                //Artillery Drop
                _pos = getPos player;
                _holder = createvehicle ["CFP_B_USARMY_1991_M270_MLRS_HE_Des_01", [_pos select 0, _pos select 1, 75], [], 0, "CAN_COLLIDE"];
                [objNull, _holder] call BIS_fnc_curatorobjectedited;
                
                systemChat "Artillery Vehicle dropped.";

            };
            
            if (_amnt >= 50 && _amnt < 76) then {
                //Apache Attack Helicopter Drop
                _pos = getPos player;
                _holder = createvehicle ["CFP_B_USARMY_1991_AH_64D_Des_01", [_pos select 0, _pos select 1, 0], [], 0, "CAN_COLLIDE"];
                player moveInDriver _holder;
                
                systemChat "Apache spawned.";

            };
            
            if (_amnt >= 76 && _amnt < 100) then {
                //Heal players
                {
                    [_x, _x] remoteExecCall ["ace_medical_treatment_fnc_fullHeal", 0];
                } forEach allPlayers;
                systemChat "Healing all players.";
            };
            if (_amnt >= 100) then {
                //Wolverine mode
                _wolv_time = 60 + (60 * (floor((_amnt - 100) / 50)));
                _wolv_time spawn {
                    _end_time = time + _this;
                    while { time < _end_time } do {
                        {
                            [_x, _x] remoteExecCall ["ace_medical_treatment_fnc_fullHeal", 0];
                        } forEach allPlayers;
                        sleep 0.5;
                    };
                };
                systemChat format["Wolverine mode activated for %1 seconds.", _wolv_time];
            };
		}
	]
];