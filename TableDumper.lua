local gameG = getrenv()._G
local tcPlayer = gameG.Player
local tcPlayers = gameG.Players

local out = ""

function printTable(t, indentation)
    for k, v in next, t do
        for i = 1, indentation do
            out = out.."\t"
        end

        out = out.."["

        local t_k = typeof(k)
        if t_k == "Instance" then
            out = out..k:GetFullName()
        elseif t_k == "string" then
            out = out.."\""..k.."\""
        else
            out = out..k
        end

        out = out.."] = "
        
        local t_v = typeof(v)
        if t_v == "table" then
            out = out.."{\n"
            printTable(v, indentation + 1)

            for i = 1, indentation do
                out = out.."\t"
            end
            out = out.."}"
        elseif t_v == "boolean" then
            out = out..(if v then "true" else "false")
        elseif t_v == "RBXScriptConnection" then
            out = out.."CONNECTION"
        elseif t_v == "string" then
            out = out.."\""..v.."\""
        elseif t_v == "function" then
            local info = getinfo(v)
            if info then
                out = out.."function "..info.name.."() end"
            else
                out = out.."function"
            end
        elseif t_v == "Instance" then
            out = out..v:GetFullName()
        else
            out = out..v
        end

        out = out..",\n"
    end
end

printTable(gameG, 0)

setclipboard(out)
