local M = {}
M.diagnostics = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}
M.dap = {
  DapBreakpoint = "",
  DapBreakpointCondition = "",
  DapBreakpointRejected = "",
  DapLogPoint = ".>",
  DapStopped = "󰁕",
}
M.files = {
  modified = "",
  readonly = "",
}
M.separator = { left = "", right = "" }
M.separator_tab = { left = "", right = "" }
M.other = {
  command = " ",
  search = " ",
  exit = "󰗼 ",
  close = " ",
}
M.git = {
  added = "",
  removed = "",
  merged = "",
  branch = "",
  ignored = "",
  staged = "",
  renamed = "󰑕",
}
M.kinds = {
  Array = " ",
  Boolean = " ",
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Copilot = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = "󰉋 ",
  Function = " ",
  Interface = " ",
  Key = " ",
  Keyword = " ",
  Method = " ",
  Module = " ",
  Namespace = " ",
  Null = "󰟢 ",
  Number = " ",
  Object = " ",
  Operator = " ",
  Package = " ",
  Property = " ",
  Reference = " ",
  Snippet = " ",
  String = " ",
  Struct = " ",
  Text = " ",
  TypeParameter = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}
M.mode = {
  n = "",
  i = "",
  v = "󰦨",
  V = "",
  ["^V"] = "󰿦",
  c = "",
  s = "",
  R = "󰉼",
  r = "",
  ["?"] = "",
  ["!"] = "󰜎",
  t = "",
  o = "∙",
}

return M

