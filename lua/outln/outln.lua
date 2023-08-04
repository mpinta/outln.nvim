local utils = require("outln.utils")
local querier = require("outln.querier")
local queries = require("outln.queries")

local M = {}

-- Defines default configuration options.
local defaults = {
    after = "normal zt"
}

M.options = defaults

-- Defines languages, that are supported.
local supported_languages = {
    ["go"] = "go";
    ["yml"] = "yaml";
    ["yaml"] = "yaml";
    ["py"] = "python";
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

-- Gets node names and their metadata.
local function get_names_and_metadata(lang)
    local n, m = querier.get_query_captures(
        lang,
        queries.queries[lang]
    )

    if lang == "yaml" then
        return utils.clean_yaml_captures(n, m)
    end

    return n, m
end

-- Sets user configured options.
function M.setup(options)
    if options ~= nil and next(options) ~= nil then
        M.options = options
    end
end

-- Opens and populates an Outln window.
function M.open_outln()
    local lang = get_language()

    if lang == "" then
        error("Language is not supported.")
    end

    local n, m = get_names_and_metadata(lang)

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
