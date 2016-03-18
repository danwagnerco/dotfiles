-- belongs here -> C:\Users\<your_user_name>\AppData\Local\clink\git_prompt_filter.lua
function git_prompt_filter()
    for line in io.popen("git branch 2>nul"):lines() do
        local m = line:match("%* (.+)$")
        if m then
            clink.prompt.value = "["..m.."] "..clink.prompt.value
            break
        end
    end

    return false
end

clink.prompt.register_filter(git_prompt_filter, 50)
