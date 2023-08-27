local handler = require("outln.handler")

local M = {}

-- Defines definitions of all supported languages.
local definitions = {
    "interfaces",
    "structs",
    "classes",
    "functions",
    "methods",
    "endpoints"
}

-- Defines default configuration options.
local defaults = {
    after = "normal zt",
    go = {
        methods = true,
        functions = true,
        structs = true,
        interfaces = true
    },
    openapi = {
        endpoints = true
    },
    python = {
        functions = true,
        classes = true
    }
}

M.options = defaults

-- Defines languages, that are supported.
local supported_languages = {
    go = "go",
    yml = "yaml",
    yaml = "yaml",
    py = "python"
}

-- Gets current file's language.
local function get_language()
    local ext = vim.api.nvim_exec(
        "echo expand('%:p')",
        true
    ):match("[^.]+$")

    local lang = supported_languages[ext]

    if lang == nil then
        return ""
    end

    return lang
end

-- Gets captures of language-specific definitions.
local function get_captures(lang)
    local lang_type = lang

    if lang == "yaml" then
        lang_type = "openapi"
    end

    local c = handler.handle(
        lang,
        lang_type,
        M.options[lang_type]
    )

    return c
end

-- Gets names and metadata from captures.
local function get_names_and_metadata(c)
    local n, m = {}, {}

    for _, v in pairs(definitions) do
        if c[v] ~= nil and #c[v] ~= 0 then
            for _, j in pairs(c[v]) do
                local name = j[1]
                local line = j[2]

                table.insert(n, name)
                m[name] = line
            end
        end
    end

    return n, m
end

-- Sets user configured options.
function M.setup(options)
    if options ~= nil and next(options) ~= nil then
        for k, v in pairs(options) do
            M.options[k] = v
        end
    end
end

-- Opens and populates an Outln window.
function M.open_outln()
    local lang = get_language()

    if lang == "" then
        error("Language is not supported.")
    end

    local c = get_captures(lang)
    local n, m = get_names_and_metadata(c)

    vim.ui.select(n, {
        prompt = "Outln Results",
     }, function(selected)
        if selected ~= nil then
            vim.cmd(":" .. m[selected])
            vim.cmd("norm! _")
            vim.cmd(M.options.after)
        end
    end)
end

return M
