local M = {}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

M.capabilities = capabilities
local function format_diagnostics(diag)
  if diag.code then
    return string.format("[%s](%s): %s", diag.source, diag.code, diag.message)
  else
    return string.format("[%s]: %s", diag.source, diag.message)
  end
end
local diagnosis_config = {
  format = format_diagnostics,
  header = {},
  scope = "cursor",
}
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  update_in_insert = false,
  float = diagnosis_config,
  virtual_text = diagnosis_config,
})

M.diagnostics = {
  underline = true,
  update_in_insert = false,
  virtual_text = diagnosis_config,
  float = diagnosis_config,
  severity_sort = true,
}
M.update_in_insert = true
M.underline = true
M.severity_sort = true
M.float = {
  focusable = false,
  style = "minimal",
  border = "rounded",
  source = "always",
  header = "",
  prefix = "",
}

return M
