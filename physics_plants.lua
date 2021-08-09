

-- plants in vacuum
local plants_die = vacuum.plants_die
local dead_plant = vacuum.dead_plant

minetest.register_abm({
        label = "space vacuum plants",
	nodenames = plants_die,
	neighbors = {"vacuum:vacuum"},
	interval = 1,
	chance = 1,
	action = vacuum.throttle(100, function(pos)
		minetest.set_node(pos, {name = dead_plant})
	end)
})
