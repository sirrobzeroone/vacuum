local has_monitoring = minetest.get_modpath("monitoring")
local has_mesecons_random = minetest.get_modpath("mesecons_random")
local has_technic = minetest.get_modpath("technic")

local metric_space_vacuum_leak_abm

if has_monitoring then
  metric_space_vacuum_leak_abm = monitoring.counter("vacuum_abm_leak_count", "number of space vacuum leak abm calls")
end

-- air leaking nodes
local leaky_nodes = vacuum.leaky_nodes
local node_no_leak = vacuum.node_no_leak
local debug_node = vacuum.debug_node

if has_mesecons_random then
	local mesecon_leak = vacuum.mesecon_leak
	for _ , node_name in pairs(mesecon_leak) do	
		table.insert(leaky_nodes, node_name)
	end
end

if has_technic then
	local technic_leak = vacuum.technic_leak
	for _ , node_name in pairs(technic_leak) do	
		table.insert(leaky_nodes, node_name)
	end
end

-- depressurize through leaky nodes
minetest.register_abm({
        label = "space vacuum depressurize",
	nodenames = leaky_nodes,
	neighbors = {"vacuum:vacuum"},
	interval = 2,
	chance = 2,
	action = vacuum.throttle(250, function(pos)
		if metric_space_vacuum_leak_abm ~= nil then metric_space_vacuum_leak_abm.inc() end

		if not vacuum.is_pos_in_space(pos) or vacuum.near_powered_airpump(pos) then
			-- on earth: TODO: replace vacuum with air
			return
		else
			local node = minetest.get_node(pos)
			
			for _ , no_leak_name in pairs(node_no_leak) do
				if node.name == no_leak_name then
					-- air tight node
					return
				end
			
			end

			-- TODO check n nodes down (multiple simple door airlock hack)
			-- in space: replace air with vacuum
			local surrounding_node = minetest.find_node_near(pos, 1, {"air"})

			if surrounding_node ~= nil then
			        if vacuum.debug then
					-- debug mode, set
					minetest.set_node(surrounding_node, {name = debug_node})
				else
					-- normal case
					minetest.set_node(surrounding_node, {name = "vacuum:vacuum"})
				end
			end
		end
	end)
})
