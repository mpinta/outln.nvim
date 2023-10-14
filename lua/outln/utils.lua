local M = {}

-- Checks if the character is alphabetical.
function M.is_alphabetical(c)
    if string.match(c, "%a") then
        return true
    end

    return false
end

-- Checks if the character is uppercase.
function M.is_uppercase(c)
    if c == string.upper(c) then
        return true
    end

    return false
end

return M
