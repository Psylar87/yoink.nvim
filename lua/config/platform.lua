local function env_set(name)
  return vim.env[name] ~= nil and vim.env[name] ~= ''
end

local M = {
  is_mac = vim.fn.has 'mac' == 1,
  is_linux = vim.fn.has 'linux' == 1,
  is_ssh = env_set 'SSH_CONNECTION' or env_set 'SSH_CLIENT' or env_set 'SSH_TTY',
}

function M.has_image_clipboard()
  if M.is_mac then
    return vim.fn.executable 'pngpaste' == 1
  end
  if M.is_linux and not M.is_ssh then
    if env_set 'WAYLAND_DISPLAY' then
      return vim.fn.executable 'wl-paste' == 1
    end
    return env_set 'DISPLAY' and vim.fn.executable 'xclip' == 1
  end
  return false
end

return M
