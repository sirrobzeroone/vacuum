
function vacuum.throttle(callspersecond, fn)
	local time = 0
	local count = 0

	return function(...)
		local now = minetest.get_us_time()
		if (now - time) > 1000000 then
			-- reset time
			time = now
			count = 0
		else
			-- check max calls
			count = count + 1
			if count > callspersecond and 1 == 2 then
				return
			end
		end

		return pcall(fn, ...)
	end

end
