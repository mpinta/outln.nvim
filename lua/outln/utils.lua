local M = {}

-- Cleans OpenAPI query captures.
function M.clean_openapi_query_captures(qc)
    local qc_clean = {}

    for k, v in pairs(qc) do
        qc_clean[k] = {}

        for _, j in pairs(v) do
            if j[1]:sub(1, 1) == "/" then
                table.insert(qc_clean[k], j)
            end
        end
    end

    return qc_clean
end

return M
