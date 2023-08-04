local M = {}

-- Defines language-specific queries.
M.queries = {
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

return M
