/* 
 *	=== Stargate Ringtransporter ===
 *	Idea, Concept & initial code by icecoolwrx
 *	Reworked/revised by Insane
 *	www.stargatearma.com
 */

 // Debug
sga_debug = true; 
if (sga_debug) then { diag_log format["#SGA Ringtransporter (SGA_rt) geladen: %1", _this]; };


if(isnil "SGA_rt_init") then {
	
	if(isServer) then {
		(_this select 0) setDir 0;
	};
	
	// VARS
	SGA_rt_init = true;
	SGA_rt_rings_array = [];
	SGA_rt_rings_inuse = [];
	SGA_rt_rings_brokenconnections = [];
	SGA_rt_rings_AI = false; // momentan AI im Transporter
	SGA_rt_player_IsUsingRings = false;
	SGA_rt_blacklist = ["sga_ringtransporter_rings_basic"];

	// diesen Transporter eintragen
	SGA_rt_rings_array set [0, _this select 0];

	// Non-dedicated Server machines (Clients + JIP-Clients + Client-Host)
	if(!(isServer && isNull player)) then 
	{
		// Wart ma mal..
		waitUntil {player == player};
		
		// Setup Playeractions
		[] spawn sga_ringtransporter_fnc_playerActions;
	};
	
	// neuer Transport EH
	sga_ringtransporter_mp_NewTransport = [[]];
	"sga_ringtransporter_mp_NewTransport" addPublicVariableEventHandler { 
		if( (count ((_this select 1) select 0)) == 2) then { 
			[((_this select 1) select 0) + [true]] spawn sga_ringtransporter_fnc_teleport; 
		};
	};

} else 
{
	if(isServer) then {
		(_this select 0) setDir 0;
	};
	SGA_rt_rings_array set [count SGA_rt_rings_array, _this select 0];
};