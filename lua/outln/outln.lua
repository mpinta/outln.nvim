local M = {}

-- Defines default configuration options.
local defaults = {
	after = "normal zt"
}

M.options = defaults

-- Defines languages, that are supported.
local supported_languages = {
    ["go"] = "go"
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

-- Gets tree's root node using Treesitter.
local function get_root_node(lang)
    local bufnr = vim.api.nvim_get_current_buf()

    local language_tree = vim.treesitter.get_parser(bufnr, lang)
    local syntax_tree = language_tree:parse()

    return syntax_tree[1]:root()
end

-- Gets given query's captures and their metadata.
local function get_query_captures(lang, query)
    local bufnr = vim.api.nvim_get_current_buf()

    local n, m = {}, {}

    for _, captures, metadata in query:iter_matches(
        get_root_node(lang),
        bufnr
    ) do
        local name = vim.treesitter.query.get_node_text(
            captures[1],
            bufnr
        )

        table.insert(n, name)
        m[name] = metadata[1]["range"][1]+1
    end

    return n, m
end

-- Gets tree's method and function names and their positions.
local function get_methods_and_functions(lang)
    local query = vim.treesitter.parse_query(lang, [[
        (method_declaration
            name: (field_identifier) @annotation (#offset! @annotation)
        )
        (function_declaration
            name: (identifier) @annotation (#offset! @annotation)
        )
    ]])

    return get_query_captures(lang, query)
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

    local n, m = get_methods_and_functions(lang)

    vim.ui.select(n, {
        prompt = "Find Methods or Functions",
     }, function(selected)
        if selected ~= nil then
            vim.cmd(":" .. m[selected])
			vim.cmd(M.options.after)
        end
     end)
end

return M
