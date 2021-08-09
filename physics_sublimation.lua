

-- sublimate nodes in vacuum
local sublimate_nodes = vacuum.sublimate_nodes
local sublimate_replace = vacuum.sublimate_replace

minetest.register_abm({
  label = "space vacuum sublimate",
	nodenames = sublimate_nodes,
	neighbors = {"vacuum:vacuum"},
	interval = 1,
	chance = 1,
	action = vacuum.throttle(100, function(pos)
		if not vacuum.is_pos_in_space(pos) or vacuum.near_powered_airpump(pos) then
			return
		end

		minetest.set_node(pos, {name = sublimate_replace})
	end)
})
