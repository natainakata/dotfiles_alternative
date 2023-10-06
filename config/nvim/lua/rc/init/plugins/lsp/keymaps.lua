local M = {}
M._keys = nil

function M.get()
  if not M._keys then
    M._keys = {
      { "<Leader>F", "<Cmd>Format<CR>", desc = "Format Document", has = "documentFormatting" },
      { "<Leader>F", "<Cmd>Format<CR>", desc = "Format Selected", mode = "v", has = "documentFormatting" },
      { "gr", "<Cmd>Ddu lsp:references<CR>", desc = "References", },
      { "gd", "<Cmd>Ddu lsp:definition<CR>", desc = "Definition", },
      { "gt", "<Cmd>Ddu lsp:type_definition<CR>", desc = "Type definition", },
      { "<Leader>a", "<Cmd>Ddu lsp:code_action<CR>", mode = { "n", "x" }, desc = "Code Action", has = "codeAction" },
      { "g]", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next Diagnostic" },
      { "g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Prev Diagnostic" },
      { "R", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
      { "<C-k>", vim.lsp.buf.signature_help, mode = { "i" }, desc = "Signature Help", has = "signatureHelp", },
    }
  end
  return M._keys
end

function M.on_attach(client, bufnr)
  plugins.ensure("lazy.core.handler.keys", function(m)
    local keymaps = {}

    for _, value in ipairs(M.get()) do
      local keys = m.parse(value)
      if keys[2] == vim.NIL or keys[2] == false then
        keymaps[keys.id] = nil
      else
        keymaps[keys.id] = keys
      end
    end

    for _, keys in pairs(keymaps) do
      if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
        local opts = m.opts(keys)
        opts.has = nil
        opts.silent = true
        opts.buffer = bufnr
        vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
      end
    end
  end)
end

return M
