--- A simple bottom terminal toggler for Neovim by @MillerApps
--- This module provides a toggleable terminal that appears at the bottom of the screen.
--- Features:
--- - Preserves terminal state between toggles
--- - Configurable height (percentage of screen)
--- - Double-Escape to exit terminal mode
--- - Bottom split layout
--- - Reuses terminal buffer

-- Global state to track terminal buffer and window
local state = {
  term_buf = nil, -- Holds the terminal buffer handle
  term_win = nil, -- Holds the terminal window handle
}

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode

-- Keybinding to exit terminal mode using double Escape
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', {
  desc = 'Exit terminal mode with <Esc><Esc>',
})

--- Toggle the bottom terminal
--- Creates a new terminal if none exists, or toggles visibility of existing one
--- Terminal persists its state between toggles
local function toggle_terminal()
  -- If terminal window exists and is valid, hide it
  if state.term_win and vim.api.nvim_win_is_valid(state.term_win) then
    vim.api.nvim_win_hide(state.term_win)
    state.term_win = nil
  else
    -- Create new terminal buffer if it doesn't exist or is invalid
    if not state.term_buf or not vim.api.nvim_buf_is_valid(state.term_buf) then
      state.term_buf = vim.api.nvim_create_buf(false, true) -- Create unlisted scratch buffer
    end

    -- Calculate terminal height (20% of total window height)
    local height = math.floor(vim.o.lines * 0.2)

    -- Create bottom split window
    vim.cmd('botright ' .. height .. 'split')
    state.term_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(state.term_win, state.term_buf)

    -- Initialize terminal if not already done
    if vim.bo[state.term_buf].buftype ~= 'terminal' then
      vim.cmd 'terminal'
    end
    vim.cmd 'startinsert' -- Enter terminal mode automatically
  end
end

-- Keybinding to toggle terminal with <A-t>
vim.keymap.set('n', '<A-t>', toggle_terminal, {
  desc = 'Toggle bottom terminal',
})

--[[ 
Usage:
1. Press <A-t> to toggle terminal visibility
2. Use <Esc><Esc> to exit terminal mode
3. Terminal state is preserved between toggles
4. Terminal height is 20% of total window height

Configuration:
- To change terminal height, modify the multiplier in:
  local height = math.floor(vim.o.lines * 0.2)
- To change keybindings, modify the vim.keymap.set calls

Requirements:
- Neovim 0.5 or later
- No additional plugins required

Example config in init.lua:
```lua
-- Load this file
require('path.to.terminal')
Notes:
	•	Terminal buffer persists until Neovim is closed
	•	Window position is always at bottom
	•	Terminal state (command history, running processes) is preserved
]]
