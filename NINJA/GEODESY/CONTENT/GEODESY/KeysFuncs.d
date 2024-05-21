/*
 *  KeysFuncs.d
 *   - functions binded to keys
 */


/*
 *  _NOTES
 *
 *  Dodaæ wprowadzanie danych z klawiatury.
 */

/*
 *  Ninja_Geodesy_Measurement_Position_Hero_Start
 *   - save a start position of hero
 */
const string NINJA_GEODESY_PRINT_MEASUREMENT_POSITION_HERO_START = "START,";
func void Ninja_Geodesy_Measurement_Position_Hero_Start()
{
    Ninja_Geodesy_Measurement_Position_Hero_Save(NINJA_GEODESY_PRINT_MEASUREMENT_POSITION_HERO_START);
};

/*
 *  Ninja_Geodesy_Measurement_Position_Hero_End
 *   - save an end position of hero
 */
const string NINJA_GEODESY_PRINT_MEASUREMENT_POSITION_HERO_END = "END,";
func void Ninja_Geodesy_Measurement_Position_Hero_End()
{
    Ninja_Geodesy_Measurement_Position_Hero_Save(NINJA_GEODESY_PRINT_MEASUREMENT_POSITION_HERO_END);
};
