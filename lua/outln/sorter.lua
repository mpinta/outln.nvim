local M = {}

-- Sorts query captures based on line numbers.
function M.sort_query_captures(qc)
    table.sort(qc, function(x, y)
        return x[2] < y[2]
    end)

    return qc
end

return M
