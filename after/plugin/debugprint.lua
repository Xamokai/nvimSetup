opts = {
    create_keymaps = false,
    create_commands = false
}

require("debugprint").setup(opts)

vim.keymap.set("n", "<Leader>d", function()
    -- Note: setting `expr=true` and returning the value are essential
    return require('debugprint').debugprint()
end, {
    expr = true,
})

vim.keymap.set("n", "<Leader>D", function()
    -- Note: setting `expr=true` and returning the value are essential
    return require('debugprint').debugprint({ above = true })
end, {
    expr = true,
})

vim.keymap.set("n", "<Leader>dq", function()
    -- Note: setting `expr=true` and returning the value are essential
    return require('debugprint').debugprint({ variable = true })
end, {
    expr = true,
})

vim.keymap.set("n", "<Leader>Dq", function()
    -- Note: setting `expr=true` and returning the value are essential
    return require('debugprint').debugprint({ above = true, variable = true })
end, {
    expr = true,
})

vim.keymap.set("n", "<Leader>do", function()
    -- Note: setting `expr=true` and returning the value are essential
    -- It's also important to use motion = true for operator-pending motions
    return require('debugprint').debugprint({ motion = true })
end, {
    expr = true,
})

vim.api.nvim_create_user_command("DeleteDebugs", function()
    return require('debugprint').deleteprints()
    -- Note: you must set `range=true` and pass through opts for ranges to work
end, {
    range = true})
