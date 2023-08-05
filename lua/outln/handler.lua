local querier = require("outln.querier")
local queries = require("outln.queries")
local utils = require("outln.utils")

local M = {}

-- Handles getting language-specific query captures.
function M.handle(lang, lang_type, options)
    local query = ""

    for k, v in pairs(options) do
        if v == true then
            local q = queries[lang_type][k]

            if q ~= nil then
                query = query .. q
            end
        end
    end

    local n, m = querier.get_query_captures(
        lang,
        query
    )

    if lang_type == "openapi" then
        n, m = utils.clean_openapi_captures(n, m)
    end

    return n, m
end

return M
