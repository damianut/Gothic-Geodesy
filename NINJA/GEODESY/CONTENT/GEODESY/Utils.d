/*
 *  Utils.d
 *   - functions used multiple times in the plugin
 */

/*
 *  BW_AppendTo
 *   - extension for BinaryWriter from LeGo
 *
 *  Author: neconspictor
 *  Source: https://forum.worldofplayers.de/forum/threads/1408430-Skriptpaket-LeGo-3/page11?p=25011830&highlight=BW_NewFile#post25011830
 */
const int FILE_APPEND_DATA = 4;
const int OPEN_ALWAYS = 4;

func int BW_AppendTo(var string file) {
    _bin_prefix = "BW_NewFile";
    if(!_BIN_nRunning()) { return 0; };

    _bin_open = WIN_CreateFile(file, FILE_APPEND_DATA, FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, 0, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
    if(_bin_open==-1) {
        _bin_open = 0;
        var string err; err = ConcatStrings(file, " - Datei konnte nicht erstellt werden. Fehlercode ");
        _BIN_Err(ConcatStrings(err, IntToString(WIN_GetLastError())));
        return 0;
    };

    if(!_bin_ccnt) {
        _bin_clen = _BIN_BufferLength;
        _bin_ccnt = MEM_Alloc(_bin_clen);
    };

    _bin_mode = 0;
    _bin_crsr = 0;
    return 1;
};

/*
 *  Ninja_Geodesy_Measurement_Utils_WriteToFile
 *   - write a result to file
 */
const string NINJA_GEODESY_CONST_MEASUREMENT_UTILS_WRITETOFILE_PREFIX = "Geodesy\Output_";
const string NINJA_GEODESY_CONST_MEASUREMENT_UTILS_WRITETOFILE_EXTENSION = ".csv";
func void Ninja_Geodesy_Measurement_Utils_WriteToFile(var string result)
{
    // Establish a file name with a relative directory
    var string filePath;
    filePath = NINJA_GEODESY_CONST_MEASUREMENT_UTILS_WRITETOFILE_PREFIX;
    filePath = ConcatStrings(filePath, MEM_GetGothOpt("INTERNAL", "gameStarts"));
    filePath = ConcatStrings(filePath, NINJA_GEODESY_CONST_MEASUREMENT_UTILS_WRITETOFILE_EXTENSION);

    // Append data
	if (!BW_AppendTo(filePath))
    {
        return;
    };
    
    BW_Text(result);
    BW_NextLine();
    BW_Close();
};


/*
 *  Ninja_Geodesy_Measurement_Utils_PosXYZ
 *   - get position of given vob
 */
var int Ninja_Geodesy_Measurement_Utils_PosXYZ__valid;
var int Ninja_Geodesy_Measurement_Utils_PosXYZ__value[3];
func void Ninja_Geodesy_Measurement_Utils_PosXYZ(var int vobPtr)
{
    Ninja_Geodesy_Measurement_Utils_PosXYZ__valid = zCVob_GetPositionWorldToPos (vobPtr, _@ (Ninja_Geodesy_Measurement_Utils_PosXYZ__value));
    
};

/*
 *  Ninja_Geodesy_Measurement_Utils_PosXYZ_Hero
 *   - get position of hero
 */
func void Ninja_Geodesy_Measurement_Utils_PosXYZ_Hero()
{
    Ninja_Geodesy_Measurement_Utils_PosXYZ(_@(hero));
};

/*
 *  Ninja_Geodesy_Measurement_Position_Hero
 *   - return position of hero as a string
 */
func string Ninja_Geodesy_Measurement_Position_Hero()
{
    Ninja_Geodesy_Measurement_Utils_PosXYZ_Hero();
    
    // SAFETY CHECK
    if (false == Ninja_Geodesy_Measurement_Utils_PosXYZ__valid)
    {
        return "NINJA_GEODESY_PRINT_MEASUREMENT_POSITION__NOTCOUNTED";
    };

    // Prepare message
    var string str;
    var int i;
    i = MEM_ReadIntArray(_@(Ninja_Geodesy_Measurement_Utils_PosXYZ__value), 0);
    str = toStringf(i);
    str = ConcatStrings(str, "','");
    i = MEM_ReadIntArray(_@(Ninja_Geodesy_Measurement_Utils_PosXYZ__value), 1);
    str = ConcatStrings(str, toStringf(i));
    str = ConcatStrings(str, "','");
    i = MEM_ReadIntArray(_@(Ninja_Geodesy_Measurement_Utils_PosXYZ__value), 2);
    str = ConcatStrings(str, toStringf(i));
    str = ConcatStrings(str, "'");
    
    return str;
};

/*
 *  Ninja_Geodesy_Measurement_Position_Hero_Save
 *   - save position of hero as a string
 */
func void Ninja_Geodesy_Measurement_Position_Hero_Save(var string prefix)
{
    // Prepare a position to save
    var string posStr;
    posStr = Ninja_Geodesy_Measurement_Position_Hero();
    posStr = ConcatStrings(prefix, posStr);
    
    // Print a position for user
    print(posStr);
    
    // Save position
    Ninja_Geodesy_Measurement_Utils_WriteToFile(posStr);
};