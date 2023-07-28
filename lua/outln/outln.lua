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
}

-- Defines language-specific queries.
local queries = {
    ["go"] = [[
        (method_declaration
            name: (field_identifier) @annotation (#offset! @annotation)
        )
        (function_declaration
            name: (identifier) @annotation (#offset! @annotation)
        )
    ]];
    ["yaml"] = [[
        (block_mapping_pair
            key: (flow_node) @annotation (#offset! @annotation)
        )
    ]];
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
        local name = vim.treesitter.get_node_text(
            captures[1],
            bufnr
        )

        table.insert(n, name)
        m[name] = metadata[1]["range"][1]+1
    end

    return n, m
end

-- Cleans YAML query captures.
local function clean_yaml_captures(n, m)
    local n_clean, m_clean = {}, {}

    for _, v in pairs(n) do
        if v:sub(1, 1) == "/" then
            table.insert(n_clean, v)
            m_clean[v] = m[v]
        end
    end

    return n_clean, m_clean
end

-- Gets names and their metadata.
local function get_names_and_metadata(lang)
    local query = vim.treesitter.query.parse(
        lang,
        queries[lang]
    )

    local n, m = get_query_captures(lang, query)

    if lang == "yaml" then
        n, m = clean_yaml_captures(n, m)
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
