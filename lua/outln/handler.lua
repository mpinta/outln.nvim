local queries = require("outln.queries")
local querier = require("outln.querier")
local cleaner = require("outln.cleaner")
local sorter = require("outln.sorter")

local M = {}

-- Handles getting language-specific query captures.
function M.handle(lang, lang_type, options)
    local t = {}

    for definition, enabled in pairs(options) do
        if enabled then
            local query = queries[lang_type][definition]

            if query ~= nil then
                local qc = querier.get_query_captures(
                    lang,
                    query
                )

                qc = cleaner.clean_query_captures(
                    qc,
                    lang_type,
                    definition
                )

                t[definition] = sorter.sort_query_captures(qc)
            end
        end
    end

    return t
end

return M
