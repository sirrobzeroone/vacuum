
-- various dirts in vacuum
local soil_convert = vacuum.soil_convert
local soil_replace = vacuum.soil_replace

minetest.register_abm({
  label = "space vacuum soil dry",
	nodenames = soil_convert,
	neighbors = {"vacuum:vacuum"},
	interval = 1,
	chance = 1,
	action = vacuum.throttle(100, function(pos)
		minetest.set_node(pos, {name = soil_replace})
	end)
})
