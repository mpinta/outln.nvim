local icons = require("outln.icons")

local M = {}

-- Defines display order of definitions.
local definitions = {
    "interfaces",
    "structs",
    "classes",
    "functions",
    "methods",
    "endpoints",
    "components"
}

-- Prepares names and metadata of query captures.
function M.prepare(qc)
    local names, metadata = {}, {}

    for _, definition in pairs(definitions) do
        if qc[definition] ~= nil then
            for line, name in pairs(qc[definition]) do
                local new_name = icons[definition] .. " " .. name[1]

                table.insert(names, new_name)
                metadata[new_name] = line
            end
        end
    end

    return names, metadata
end

return M
