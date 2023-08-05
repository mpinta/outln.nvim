local M = {}

-- Defines Go queries.
M.go = {
    methods = [[
        (method_declaration
            name: (field_identifier) @annotation (#offset! @annotation)
        )
    ]],
    functions = [[
        (function_declaration
            name: (identifier) @annotation (#offset! @annotation)
        )
    ]],
    structs = [[
        (type_declaration
            (type_spec
            	name: (type_identifier) @annotation (#offset! @annotation)
                type: (struct_type)
            )
        )
    ]],
    interfaces = [[
        (type_declaration
            (type_spec
            	name: (type_identifier) @annotation (#offset! @annotation)
                type: (interface_type)
            )
        )
    ]]
}

-- Defines OpenAPI queries.
M.openapi = {
    endpoints = [[
        (block_mapping_pair
            key: (flow_node) @annotation (#offset! @annotation)
        )
    ]]
}

-- Defines Python queries.
M.python = {
    functions = [[
        (function_definition
            name: (identifier) @annotation (#offset! @annotation)
        )
    ]],
    classes = [[
        (class_definition
            name: (identifier) @annotation (#offset! @annotation)
        )
    ]]
}

return M
