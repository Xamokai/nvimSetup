local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'rust_analyzer',
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  require("lspsaga").setup({})

  local keymap = vim.keymap.set

  -- LSP finder - Find the symbol's definition
  -- If there is no definition, it will instead be hidden
  -- When you use an action in finder like "open vsplit",
  -- you can use <C-t> to jump back
  keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

  -- Code action
  keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

  -- Rename all occurrences of the hovered word for the entire file
  keymap("n", "gr", "<cmd>Lspsaga rename<CR>")

  -- Rename all occurrences of the hovered word for the selected files
  keymap("n", "gr", "<cmd>Lspsaga rename ++project<CR>")

  -- Peek definition
  -- You can edit the file containing the definition in the floating window
  -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
  -- It also supports tagstack
  -- Use <C-t> to jump back
  keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>")

  -- Go to definition
  keymap("n","gd", "<cmd>Lspsaga goto_definition<CR>")

  -- Peek type definition
  -- You can edit the file containing the type definition in the floating window
  -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
  -- It also supports tagstack
  -- Use <C-t> to jump back
  keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")

  -- Go to type definition
  keymap("n","gt", "<cmd>Lspsaga goto_type_definition<CR>")


  -- Show line diagnostics
  -- You can pass argument ++unfocus to
  -- unfocus the show_line_diagnostics floating window
  keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

  -- Show buffer diagnostics
  keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

  -- Show workspace diagnostics
  keymap("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")

  -- Show cursor diagnostics
  keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

  -- Diagnostic jump
  -- You can use <C-o> to jump back to your previous location
  keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
  keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

  -- Diagnostic jump with filters such as only jumping to an error
  keymap("n", "[E", function()
      require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end)
  keymap("n", "]E", function()
      require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
  end)

  -- Toggle outline
  keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>")

  -- Hover Doc
  -- If there is no hover doc,
  -- there will be a notification stating that
  -- there is no information available.
  -- To disable it just use ":Lspsaga hover_doc ++quiet"
  -- Pressing the key twice will enter the hover window
  keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

  -- If you want to keep the hover window in the top right hand corner,
  -- you can pass the ++keep argument
  -- Note that if you use hover with ++keep, pressing this key again will
  -- close the hover window. If you want to jump to the hover window
  -- you should use the wincmd command "<C-w>w"
  keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")

  -- Call hierarchy
  keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
  keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

  -- Floating terminal
  keymap({"n", "t"}, "<esc>", "<cmd>Lspsaga term_toggle<CR>")

end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

