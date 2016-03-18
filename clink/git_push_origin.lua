-- belongs here -> C:\Users\<your_user_name>\AppData\Local\clink\git_push_origin.lua
function git_push_origin_match_generator(text, first, last)
	found_matches = false;
	if rl_state.line_buffer:find("^git push origin ") then
		has_start_branch = not rl_state.line_buffer:find("^git push origin[ ]*$")
		for line in io.popen("git branch 2>nul"):lines() do
			local m = line:match("[%* ] (.+)$")
			
			if m then
				if not has_start_branch then
					clink.add_match(m)
					found_matches = true;
				elseif #text > 0 and m:find(text) then
					clink.add_match(m)
					found_matches = true;
				end
			end
		end
	end

    return found_matches
end

clink.register_match_generator(git_push_origin_match_generator, 10)
