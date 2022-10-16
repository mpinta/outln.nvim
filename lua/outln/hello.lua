local M = {}

-- Holds supported languages.
local supported_languages = {
    ['go'] = true
}

-- Holds function keywords for languages.
local function_keywords = {
    ['go'] = 'func'
}

-- Checks if the given file exists.
local function file_exists(file)
    local f = io.open(file, 'rb')

    if f then
        f:close()
    end

    return f ~= nil
end

-- Reads lines from the given file.
local function read_lines(file)
    local lines = {}

    if not file_exists(file) then
        return lines
    end

    for l in io.lines(file) do
        lines[#lines+1] = l
    end

    return lines
end

-- Finds keyword in the given lines.
local function find_keyword(lines, keyword)
    local t = {}

    for k, v in pairs(lines) do
        if string.find(v, keyword) then
            t[k] = v
        end
    end

    return t
end

function M.say_hello()
    -- get current file path
    local file = vim.api.nvim_exec('echo expand("%:p")', true)

    -- read lines from file
    local lines = read_lines(file)

    if next(lines) == nil then
        error('file has no lines')
    end

    -- get file extension
    local ext = file:match('[^.]+$')

    -- check if the language is supported
    if supported_languages[ext] == nil then
        error('language is not supported')
    end

    -- find keyword in the lines
    local funcs = find_keyword(lines, function_keywords[ext])
    P(funcs)
end

return M
