local utils = require("outln.utils")

local M = {}

-- Cleans OpenAPI query captures of endpoints.
local function clean_endpoints(qc)
    local qc_clean = {}

    for _, capture in pairs(qc) do
        local name = capture[1]
        local line = capture[2]

        if name:sub(1, 1) == "/" then
            qc_clean[line] = {}

            table.insert(
                qc_clean[line],
                name
            )
        end
    end

    return qc_clean
end

-- Cleans OpenAPI's query captures of components.
local function clean_components(qc)
    local qc_clean = {}

    for _, capture in pairs(qc) do
        local name = capture[1]
        local line = capture[2]

        local char = name:sub(1, 1)

        if utils.is_alphabetical(char) and utils.is_uppercase(char) then
            qc_clean[line] = {}

            table.insert(
                qc_clean[line],
                name
            )
        end
    end

    return qc_clean
end

-- Cleans query captures based on provided language type and option.
function M.clean_query_captures(qc, lang_type, option)
    if lang_type == "openapi" then
        if option == "endpoints" then
            return clean_endpoints(qc)
        end

        if option == "components" then
            return clean_components(qc)
        end
    end

    return qc
end

return M
