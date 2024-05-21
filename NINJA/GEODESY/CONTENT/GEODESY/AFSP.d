/*
 *  AFSP.d
 *   - functions from AF Script Packet
 *
 *  Authors: Fawkes & Auronen & more (read on below site)
 *  Source: https://github.com/Bad-Scientists/AF-Script-Packet
 */

func int FileExists (var string filePath) {
	var int b; b = WIN_CreateFile (filePath, GENERIC_READ, FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);

	if (b == -1) {
		return FALSE;
	};

	WIN_CloseHandle (b);
	return TRUE;
};

func int zCVob_GetPositionWorld (var int vobPtr) {
	//0x0051B3C0 public: class zVEC3 __thiscall zCVob::GetPositionWorld(void)const
	const int zCVob__GetPositionWorld_G1 = 5354432;

	//0x0052DC90 public: class zVEC3 __thiscall zCVob::GetPositionWorld(void)const
	const int zCVob__GetPositionWorld_G2 = 5430416;

	if (!vobPtr) { return 0; };

	CALL_RetValIsStruct (12);
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCVob__GetPositionWorld_G1, zCVob__GetPositionWorld_G2));
	return CALL_RetValAsPtr ();
};

//Wrapper function that frees allocated memory
//return TRUE if everything went ok
func int zCVob_GetPositionWorldToPos (var int vobPtr, var int posPtr) {
	if (!posPtr) { return FALSE; };

	var int vobPosPtr; vobPosPtr = zCVob_GetPositionWorld (vobPtr);
	if (!vobPosPtr) { return FALSE; };

	MEM_CopyBytes (vobPosPtr, posPtr, 12);
	MEM_Free (vobPosPtr);

	return TRUE;
};
