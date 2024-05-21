// Version of the plugin
const string NINJA_GEODESY_VERSION = "Geodesy v1.0.0"; 

// A plugin's variables and constants
const int NINJA_GEODESY_KEY_MEASURE_POSITION_HERO_START = KEY_COMMA;
const int NINJA_GEODESY_KEY_MEASURE_POSITION_HERO_END = KEY_PERIOD;

const string NINJA_GEODESY_PRINT_MEASUREMENT_POSITION__NOTCOUNTED = "Internal error: NINJA_GEODESY_PRINT_MEASUREMENT_POSITION__NOTCOUNTED";

/*
 *  Ninja_Geodesy_Measurement__Control
 *   - control measurement by keys
 */
func void Ninja_Geodesy_Measurement__Control()
{
    if (MEM_Keystate(NINJA_GEODESY_KEY_MEASURE_POSITION_HERO_START) == KEY_PRESSED)
    {
        Ninja_Geodesy_Measurement_Position_Hero_Start();
    } else if (MEM_Keystate(NINJA_GEODESY_KEY_MEASURE_POSITION_HERO_END) == KEY_PRESSED)
    {
        Ninja_Geodesy_Measurement_Position_Hero_End();
    };
};

/*
 *  Ninja_Geodesy_Measurement__Control_init
 */
func void Ninja_Geodesy_Measurement__Control_init()
{
    FF_ApplyOnceGT(Ninja_Geodesy_Measurement__Control);
};

/// Init-function called by Ninja
func void Ninja_Geodesy_Init_Internal() {
	MEM_Info(ConcatStrings(ConcatStrings("Initialize ", NINJA_GEODESY_VERSION), "."));
    
    // Init control of measurement
    Ninja_Geodesy_Measurement__Control_init();

    MEM_Info(ConcatStrings(NINJA_GEODESY_VERSION, " was initialized successfully."));
};
