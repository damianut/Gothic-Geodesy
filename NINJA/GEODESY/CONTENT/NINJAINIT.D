/*
 * Initialization function called by Ninja after "Init_Global" (G2) / "Init_<Levelname>" (G1)
 */
func void Ninja_Geodesy_Init() {
	// Initialize Ikarus & Lego
	LeGo_Init(LeGo_All);
    
    // Initialize the plugin
	Ninja_Geodesy_Init_Internal();
};
