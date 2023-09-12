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

-- Sorts query captures based on line numbers.
function M.sort_query_captures(qc)
    table.sort(qc, function(a, b)
        return a[2] < b[2]
    end)

    return qc
end

return M
