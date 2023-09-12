local icons = require("outln.icons")

local M = {}

-- Defines display order of definitions.
local definitions = {
    "interfaces",
    "structs",
    "classes",
    "functions",
    "methods",
    "endpoints"
}

-- Prepares names and metadata of captures.
function M.prepare(c)
    local n, m = {}, {}

    for _, v in pairs(definitions) do
        if c[v] ~= nil and #c[v] ~= 0 then
            for _, j in pairs(c[v]) do
                local name = j[1]
                local line = j[2]

                name = icons[v] .. " " .. name

                table.insert(n, name)
                m[name] = line
            end
        end
    end

    return n, m
end

return M
