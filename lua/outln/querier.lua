local M = {}

-- Gets tree's root node using Treesitter.
local function get_root_node(lang)
    local bufnr = vim.api.nvim_get_current_buf()

    local language_tree = vim.treesitter.get_parser(bufnr, lang)
    local syntax_tree = language_tree:parse()

    return syntax_tree[1]:root()
end

-- Parses the query with Treesitter.
local function parse_query(lang, query)
    return vim.treesitter.query.parse(
        lang,
        query
    )
end

-- Gets given query's captures and their metadata.
function M.get_query_captures(lang, query)
    local bufnr = vim.api.nvim_get_current_buf()
    local parsed_query = parse_query(lang, query)

    local qc = {}

    for _, captures, metadata in parsed_query:iter_matches(
        get_root_node(lang),
        bufnr
    ) do
        local name = vim.treesitter.get_node_text(
            captures[1],
            bufnr
        )
        local line = metadata[1]["range"][1]+1

        table.insert(qc, {
            name,
            line
        })
    end

    return qc
end

return M
