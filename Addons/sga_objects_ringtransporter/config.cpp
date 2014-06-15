class CfgPatches
{
	class sga_ringtransporter
	{
		units[]=
		{
			"sga_ringtransporter_goauld",
			"sga_ringtransporter_ori"
		};
		weapons[]={};
		requiredVersion=0.1;
		version=0.1;
		requiredAddons[]=
		{
			"Extended_Eventhandlers"
		};
	};
};
class CfgSounds
{
	class sga_ringtransporter_rings_sound
	{
		name="sga_ringtransporter_sound";
		sound[]=
		{
			"\sga_objects_ringtransporter\sounds\rings",
			1,
			1
		};
		titles[]={};
	};
	class sga_ringtransporter_rings_dropring
	{
		name="sga_objects_rings_dropring";
		sound[]=
		{
			"\sga_objects_ringtransporter\sounds\dropring",
			1,
			1
		};
		titles[]={};
	};
};

class CfgVehicleClasses
{
	class sga_mod
	{
		displayName="Stargate Modification";
	};
};

class CfgVehicles
{
	class StaticWeapon;
	class Car;
	class sga_ringtransporter_rings_basic: Car
	{
		vehicleclass="";
		hiddenselections[]={};
		armor=1000000;
		scope=2;
		getinradius=0;
		accuracy=0;
		nameSound="";
		heightoffset=0;
		reversed=1;
		animated=1;
		hasDriver=0;
		hasGunner=0;
		hasCommander=0;
		dammageHalf[]={};
		dammageFull[]={};
		class Turrets
		{
		};
		class AnimationSources
		{
			class anim_c1
			{
				source="user";
				animPeriod=0.5;
				initPhase=0;
			};
			class anim_c2: anim_c1
			{
			};
			class anim_c3: anim_c1
			{
			};
			class anim_c4: anim_c1
			{
			};
			class anim_c5: anim_c1
			{
			};
			class anim_stredy1: anim_c1
			{
				initPhase=1;
			};
			class anim_stredy2: anim_stredy1
			{
			};
			class anim_stredy3: anim_stredy1
			{
			};
			class anim_stredy4: anim_stredy1
			{
			};
			class anim_stredy5: anim_stredy1
			{
			};
			class anim_dropring: anim_c1
			{
				animPeriod=2;
			};
			class anim_e1
			{
				source="user";
				animPeriod=0.0099999998;
				initPhase=1;
			};
			class anim_e2: anim_e1
			{
			};
			class anim_e3: anim_e1
			{
			};
			class anim_e4: anim_e1
			{
			};
			class anim_e5: anim_e1
			{
			};
		};
	};
	class sga_ringtransporter_rings_goauld: sga_ringtransporter_rings_basic
	{
		vehicleclass="sga_mod";
		model="\sga_objects_ringtransporter\PUMP_SG_rings_goauld";
		scope=2;
		cost=100;
		mapSize=10;
		autocenter=0;
		displayName="Ring Transporter";
		icon="\sga_objects_ringtransporter\icons\icon.paa";
	};
	class sga_ringtransporter_rings_ori: sga_ringtransporter_rings_basic
	{
		vehicleclass="sga_mod";
		model="\sga_objects_ringtransporter\PUMP_SG_rings_ori";
		scope=2;
		cost=100;
		mapSize=10;
		autocenter=0;
		side=0;
		displayName="Ring Transporter (Ori)";
		icon="\sga_objects_ringtransporter\icons\icon_ori.paa";
		class AnimationSources: AnimationSources
		{
			class anim_dropring
			{
				source="user";
				animPeriod=0.69999999;
				initPhase=0;
			};
		};
	};
	class sga_ringtransporter_rings_notOnGround: sga_ringtransporter_rings_basic
	{
		scope=1;
	};
	class sga_ringtransporter_rings_onAircrafts: sga_ringtransporter_rings_notOnGround
	{
		shipsClassName="";
	};
};

class sga_ringtransporter_events
{
	class Default
	{
		DistanceUp=1500;
		DistanceDown=1500;
		afterEvent="";
		AiLeaderFromRing="";
		AiFromRing="";
		AiToRing="";
		onEvent="";
	};
};

class CfgFunctions
{
	class sga_ringtransporter_f
	{
		tag = "sga_ringtransporter";
		
		class sga_objects_rings_f_scripts
		{
			file = "sga_objects_ringtransporter\scripts";
			class initRingtransporter {};
			class AIgetin {};
			
			// reqs
			class ringReqInUse {};
			class reqIsBlacklisted {};
			class reqPlayersOnline {};
			
			class playerActions {};
			class getRingName {};
		};
		
		class sga_objects_rings_f_transport
		{
			file = "sga_objects_ringtransporter\scripts\transport";
			class srv_begin {};
			class fn_4 {};		class fn_5 {};		class fn_6 {};		class fn_7 {};
			class fn_9 {};		class fn_10 {};		class fn_11 {};		class fn_12 {};
			class fn_13 {};		class fn_15 {};		class fn_16 {};		class fn_19 {};
			class fn_20 {};		class fn_21 {};		class fn_22 {};		class fn_23 {};
			class fn_24 {};		class fn_26 {};

		};
		
	};
};

class Extended_Init_Eventhandlers
{
	class sga_ringtransporter_rings_basic
	{
		sga_ringtransporter_rings_basic_init = "[_this select 0] call sga_ringtransporter_fnc_initRingtransporter";
	};
};












