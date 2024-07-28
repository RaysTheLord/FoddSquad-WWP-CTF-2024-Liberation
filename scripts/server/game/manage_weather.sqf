private _weathers = [
    [0],
    [0],
    [0]
] select (GRLIB_weather_param - 1);

private _newWeather = selectRandom _weathers;
0 setOvercast _newWeather;
forceWeatherChange;

[format ["Set initial weather to: %1 - Param Value: %2 - Time: %3", _newWeather, GRLIB_weather_param, diag_tickTime], "WEATHER"] call KPLIB_fnc_log;

while {GRLIB_endgame == 0} do {
    _newWeather = selectRandom _weathers;
    (3600 * timeMultiplier) setOvercast _newWeather;
    [format ["Set next weather transition to: %1 - Time: %2", _newWeather, diag_tickTime], "WEATHER"] call KPLIB_fnc_log;
    sleep 3000; // Slighty less than weather transition time, as sleep duration is depending on FPS
};
