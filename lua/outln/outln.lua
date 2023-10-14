local handler = require("outln.handler")
local preparer = require("outln.preparer")

local M = {}

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
        endpoints = true,
        components = true
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

    local captures = handler.handle(
        lang,
        lang_type,
        M.options[lang_type]
    )

    return captures
end

-- Prepares captures for display on UI.
local function prepare_captures(captures)
    local names, metadata = preparer.prepare(
        captures
    )

    return names, metadata
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

    local captures = get_captures(lang)

    local names, metadata = prepare_captures(
        captures
    )

    vim.ui.select(names, {
        prompt = "Outln Results",
     }, function(selected)
        if selected ~= nil then
            vim.cmd(":" .. metadata[selected])
            vim.cmd("norm! _")
            vim.cmd(M.options.after)
        end
    end)
end

return M
