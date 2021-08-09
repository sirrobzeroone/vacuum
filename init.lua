
vacuum = {
	space_height    = tonumber(minetest.settings:get("vacuum.space_height")) or -32000,
	air_pump_range  = tonumber(minetest.settings:get("vacuum.air_pump_range")) or 5,
	profile_mapgen  = minetest.settings:get("vacuum.profile_mapgen"),
	disable_physics = minetest.settings:get("vacuum.disable_physics"),
	disable_mapgen  = minetest.settings:get("vacuum.disable_mapgen"),
	debug           = minetest.settings:get("vacuum.debug"),
	--------------------------------	
	-- used in "airpump.lua" and "airpump_functions.lua"
	flush_bottle_usage = 99,
	--------------------------------	
	-- used in "airbottle.lua"
	air_bottle_image = "vessels_steel_bottle.png^[colorize:#0000FFAA",
	--------------------------------	
	-- used in "airpump_functions.lua"
	full_air_bottle  = "vacuum:air_bottle",
	empty_air_bottle = "vessels:steel_bottle",
	--------------------------------	
	-- used in "physics_drop.lua"
	drop_nodes = {
				  "default:torch",
				  "default:torch_wall",
				  "default:torch_ceiling",
				  "default:ladder_wood",
				  "default:ladder_steel",
				  "default:dry_shrub",
				  "default:papyrus",
				  "default:cactus",
				  "group:wool",
				  "group:wood",
				  "group:tree"
				  -- "group:mesecon", TODO: add hardcore setting for that one
				  -- TODO: maybe: group:dig_immediate
				 },
	--------------------------------
	-- used in "physics_leakage.lua"
	leaky_nodes   = {
				     "group:door",
				     "group:soil",
				     "group:pipe", 
				     "group:tube"
				    },
	node_no_leak  = {
	                 "pipeworks:entry_panel_empty",
					 "pipeworks:entry_panel_loaded",
					 "vacuum:airpump"
					},
	mesecon_leak  = {
				     "mesecons_random:ghoststone_active"
	                },
	technic_leak  = {
	                 "technic:lv_cable",
					 "technic:mv_cable",
					 "technic:hv_cable"
	                },
	debug_node = "default:cobble",
	--------------------------------
	-- used in "physics_plant.lua"
	plants_die = {
				  "group:sapling",
				  "group:plant",
				  "group:flora",
				  "group:flower",
				  "group:mushroom",
				  "group:leafdecay",
				  "farming:cotton_wild",
				  "ethereal:banana", -- ethereal compat
				  "ethereal:orange",
				  "ethereal:strawberry"
				 },
	dead_plant = "default:dry_shrub",
	--------------------------------
	-- used in "physics_soil.lua"
	soil_convert = {
				    "group:soil", -- farming
					"default:dirt",
				    "default:dirt_with_grass",
				    "default:dirt_with_snow",
				    "default:dirt_with_dry_grass",
				    "default:dirt_with_grass_footsteps",
				    "default:dirt_with_rainforest_litter",
				    "default:dirt_with_coniferous_litter",
					"default:permafrost",
					"default:permafrost_with_stones",
					"default:permafrost_with_moss"
				   },
	soil_replace = "default:gravel",	
	--------------------------------
	-- used in "physics_sublimation.lua"
	sublimate_nodes = {
	                   "group:snowy", 
	                   "group:leaves",
				       "group:seed",   -- farming					   
					   "group:water"
					  },
	sublimate_replace = "vacuum:vacuum",
	--------------------------------
	-- used in "vacuum.lua"
	vacuum_color = "#E0E0E033"
}

local MP = minetest.get_modpath("vacuum")

if minetest.get_modpath("digilines") then
	dofile(MP.."/digilines.lua")
end

dofile(MP.."/util/throttle.lua")
dofile(MP.."/common.lua")
dofile(MP.."/vacuum.lua")
dofile(MP.."/compat.lua")
dofile(MP.."/airbottle.lua")
dofile(MP.."/airpump_functions.lua")
dofile(MP.."/airpump.lua")
dofile(MP.."/airpump_abm.lua")
dofile(MP.."/dignode.lua")

if not vacuum.disable_mapgen then
	dofile(MP.."/mapgen.lua")
end

if not vacuum.disable_physics then
	dofile(MP.."/physics_drop.lua")
	dofile(MP.."/physics_leakage.lua")
	dofile(MP.."/physics_plants.lua")
	dofile(MP.."/physics_propagation.lua")
	dofile(MP.."/physics_soil.lua")
	dofile(MP.."/physics_sublimation.lua")
end

if minetest.get_modpath("spacesuit") then
	dofile(MP.."/spacesuit.lua")
end



print("[OK] Vacuum")
