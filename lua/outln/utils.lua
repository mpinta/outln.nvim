local M = {}

-- Cleans OpenAPI query captures.
function M.clean_openapi_captures(n, m)
    local n_clean, m_clean = {}, {}

    for _, v in pairs(n) do
        if v:sub(1, 1) == "/" then
            table.insert(n_clean, v)
            m_clean[v] = m[v]
        end
    end

    return n_clean, m_clean
end

return M
