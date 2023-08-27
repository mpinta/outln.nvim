local querier = require("outln.querier")
local queries = require("outln.queries")
local utils = require("outln.utils")

local M = {}

-- Handles getting language-specific query captures.
function M.handle(lang, lang_type, options)
    local qc = {}

    for k, v in pairs(options) do
        if v == true then
            local query = queries[lang_type][k]

            if query ~= nil then
                qc[k] = querier.get_query_captures(
                    lang,
                    query
                )
            end
        end
    end

    if lang_type == "openapi" then
        qc = utils.clean_openapi_query_captures(qc)
    end

    return qc
end

return M
