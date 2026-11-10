local M = {}

function M.setup()
  local platform = require 'config.platform'
  if platform.is_linux and platform.is_ssh and vim.g.clipboard == nil then
    local osc52 = require 'vim.ui.clipboard.osc52'
    local clipboard = { name = 'OSC 52 (copy with local paste cache)', copy = {}, paste = {}, cache_enabled = 0 }

    for _, register in ipairs { '+', '*' } do
      local cached = { {}, 'v' }
      local copy = osc52.copy(register)
      clipboard.copy[register] = function(lines, regtype)
        cached = { vim.deepcopy(lines), regtype }
        copy(lines)
      end
      -- Avoid terminal clipboard-read queries, which can time out over SSH.
      -- Normal puts reuse the last copied text; paste new Mac text using the terminal.
      clipboard.paste[register] = function()
        return vim.deepcopy(cached)
      end
    end

    vim.g.clipboard = clipboard
  end

  -- A plain headless Linux console may have no clipboard provider at all.
  vim.opt.clipboard = vim.fn.has 'clipboard' == 1 and 'unnamedplus' or ''
end

return M
