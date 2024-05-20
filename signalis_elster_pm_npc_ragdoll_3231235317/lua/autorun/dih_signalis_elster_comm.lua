list.Set( "PlayerOptionsModel", "SIGNALIS - Elster", "models/dih/commissions/signalis_elster.mdl" )
player_manager.AddValidModel("SIGNALIS - Elster", "models/dih/commissions/signalis_elster.mdl")
player_manager.AddValidHands( "SIGNALIS - Elster", "models/dih/commissions/arms/signalis_elster.mdl", 0, "0000000" ) 

local Category = "SIGNALIS"

local NPC = { 	Name = "Elster (Friendly)", 
				Class = "npc_citizen",
				Model = "models/dih/commissions/npc/signalis_elster_f.mdl",
				Health = "450",
				SpawnFlags = SF_CITIZEN_MEDIC,
				KeyValues = { citizentype = 4 },
				Weapons = { "weapon_ar2", "weapon_smg1" },
                                Category = Category    }

list.Set( "NPC", "npc_dih_signalis_elster_friend", NPC )

local NPC = { 	Name = "Elster (Enemy)", 
				Class = "npc_combine_s",
				Model = "models/dih/commissions/npc/signalis_elster_e.mdl",
				Health = "200",
				Squadname = "Killing",
				Numgrenades = "4",
				Weapons = { "weapon_ar2", "weapon_smg1" },
                                Category = Category    }

list.Set( "NPC", "npc_dih_signalis_elster_enemy", NPC )
