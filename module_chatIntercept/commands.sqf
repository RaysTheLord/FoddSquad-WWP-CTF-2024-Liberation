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
            if (_amnt >= 1 && _amnt <= 5) then {
                //Ammo Supply Drop
                _mag_types = [];
                {
                    _mag_types pushBack (currentMagazine _x);
                } forEach allPlayers;
                
                _pos = getPos player;
                _holder = createvehicle ["CargoNet_01_box_F", [_pos select 0, _pos select 1, 75], [], 0, "CAN_COLLIDE"];
                [objNull, _holder] call BIS_fnc_curatorobjectedited;
                
                {
                    _holder addItemCargoGlobal [_x, _amnt];
                } forEach _mag_types;
                systemChat "Ammo crate dropped.";
            };
            if (_amnt >= 6 && _amnt <= 10) then {
                //Medical Supply Drop
                _pos = getPos player;
                _holder = createvehicle ["CargoNet_01_box_F", [_pos select 0, _pos select 1, 75], [], 0, "CAN_COLLIDE"];
                [objNull, _holder] call BIS_fnc_curatorobjectedited;
                
                _holder addItemCargoGlobal ["ACE_fieldDressing", (count allPlayers) * 20];
                _holder addItemCargoGlobal ["ACE_bloodIV", (count allPlayers) * 1];
                _holder addItemCargoGlobal ["ACE_morphine", (count allPlayers) * 4];
                _holder addItemCargoGlobal ["ACE_tourniquet", (count allPlayers) * 2];
                _holder addItemCargoGlobal ["ACE_personalAidKit", 4];
                systemChat "Medical crate dropped.";
            };
            if (_amnt >= 11 && _amnt <= 19) then {
                //APC Drop
                _pos = getPos player;
                _holder = createvehicle ["CFP_B_USARMY_1991_M113A3_Des_01", [_pos select 0, _pos select 1, 75], [], 0, "CAN_COLLIDE"];
                [objNull, _holder] call BIS_fnc_curatorobjectedited;
                
                systemChat "APC dropped.";            
            };
            if (_amnt >= 20 && _amnt <= 29) then {
                //Artillery Drop
                _pos = getPos player;
                _holder = createvehicle ["CFP_B_USARMY_1991_M270_MLRS_HE_Des_01", [_pos select 0, _pos select 1, 75], [], 0, "CAN_COLLIDE"];
                [objNull, _holder] call BIS_fnc_curatorobjectedited;
                
                systemChat "Artillery Vehicle dropped.";
            };
            
            if (_amnt >= 30 && _amnt <= 39) then {
                //Tank Drop
                _pos = getPos player;
                _holder = createvehicle ["CFP_B_USARMY_1991_M1A1_Abrams_Des_01", [_pos select 0, _pos select 1, 75], [], 0, "CAN_COLLIDE"];
                [objNull, _holder] call BIS_fnc_curatorobjectedited;
                
                systemChat "Tank dropped.";
            };
            
            if (_amnt >= 40 && _amnt <= 49) then {
                //Blackhawk Drop
                _pos = getPos player;
                _holder = createvehicle ["CFP_B_USARMY_1991_UH_60M_Des_01", [_pos select 0, _pos select 1, 0], [], 0, "CAN_COLLIDE"];
                player moveInDriver _holder;
                
                systemChat "Blackhawk spawned.";
            };
            
            if (_amnt >= 50 && _amnt <= 75) then {
                //Apache Attack Helicopter Drop
                _pos = getPos player;
                _holder = createvehicle ["CFP_B_USARMY_1991_AH_64D_Des_01", [_pos select 0, _pos select 1, 0], [], 0, "CAN_COLLIDE"];
                player moveInDriver _holder;
                
                systemChat "Apache spawned.";
            };
            if (_amnt >= 76 && _amnt <= 100) then {
                //Heal players
                {
                    [_x, _x] remoteExecCall ["ace_medical_treatment_fnc_fullHeal", 0];
                } forEach allPlayers;
                systemChat "Healing all players.";
            };
            if (_amnt >= 101) then {
                //Wolverine mode
                _wolv_time = 60 + (60 * (floor((_amnt - 100) / 50)));
                _wolv_time spawn {
                    _end_time = time + _this;
                    while { time < _end_time } do {
                        {
                            [paramedic, _x] remoteExecCall ["ace_medical_treatment_fnc_fullHeal", 0];
                        } forEach allPlayers;
                        sleep 0.5;
                    };
                };
                systemChat format["Wolverine mode activated for %1 seconds.", _wolv_time];
            };
		}
	]
];