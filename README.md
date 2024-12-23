# Yoink.nvim (Multi-File Edition)
![Yoink](yoink.nvim.png)
## "Professionally acquired configurations"

A fun fork of [kickstart.nvim by MillerApps](https://github.com/MillerApps/kickstart.nvim).

## Introduction

**Yoink.nvim** is a **multi-file** configuration inspired by the original [kickstart.nvim](https://github.com/MillerApps/kickstart.nvim). It maintains the original goal of offering a teaching tool and reference config, but in a **more modular and maintainable** structure.

---

## Installation

### 1. Install Neovim

Yoink.nvim targets the latest [Neovim stable][nvim-stable] and [Neovim nightly][nvim-nightly].  
If you encounter issues, ensure your Neovim version is up to date.

### 2. Install External Dependencies

> [!IMPORTANT]Before proceeding, 
> [back up](#faq) any existing Neovim configuration.

**Requirements:**
- Basic utilities: `git`, `make`, `unzip`, a C compiler (e.g. `gcc`)
- [ripgrep][rg-link]
- A [Nerd Font][nerd-fonts] (optional, for icons)  
  - If installed, set `vim.g.have_nerd_font = true` in `init.lua`
- Language tooling as needed (e.g., `npm`, `go`, etc.)

For more details and install scripts, see [Install Recipes](#install-recipes).

> [!INFO] Default Neovim config paths:
>
> | OS                     | Path                                          |
> |------------------------|-----------------------------------------------|
> | Linux, MacOS          | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim`      |
> | Windows (cmd)         | `%userprofile%\AppData\Local\nvim\`            |
> | Windows (PowerShell)  | `$env:USERPROFILE\AppData\Local\nvim\`         |

### 3. Install Yoink.nvim

#### Why Fork?
Forking the repo ensures you have a personal copy to modify at will. See [GitHub docs on forking][gh-fork-docs].

Replace `MillerApps/kickstart.nvim` with **your fork URL** if you fork the repo.

#### Linux / MacOS

```bash
git clone https://github.com/MillerApps/kickstart.nvim.git \
  "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
``````

## Post Installation
### Start Neovim:

```
nvim

```

`lazy.nvim` will install all plugins automatically. Use `:Lazy` to check plugin status.

## Take a look at your init.lua and the lua folder in your Neovim config directory to see how everything is organized. Feel free to customize, remove, or add plugins.

## Adding Plugins in a Multi-File Setup

## Inside a lua/plugins folder (or wherever you prefer), place each plugin in a separate file.

### For example, if you want nvim-autopairs, create lua/plugins/autopairs.lua:
```lua
-- File: lua/plugins/autopairs.lua
return {
  "windwp/nvim-autopairs",
  dependencies = { "hrsh7th/nvim-cmp" }, -- optional
  config = function()
    require("nvim-autopairs").setup {}
    -- Auto-add '(' after function/method completion
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
```

## Additional Examples

## Autopairs (simple version)
```lua
-- File: lua/plugins/autopairs.lua
return {
  "windwp/nvim-autopairs",
  config = function()
    require("nvim-autopairs").setup {}
  end,
}
```

 Q: I already have a Neovim config. What do I do?**
 A: Back up your existing config, then remove it:

```sh 
mv ~/.config/nvim ~/.config/nvim.old
rm -rf ~/.local/share/nvim/
``````

 Q: Can I use multiple Neovim configs?
 A: Yes! Set `$NVIM_APPNAME`. For example:

# Install this config in `~/.config/nvim-Yoink`
# Then create an alias:

```sh 
alias nvim-Yoink='NVIM_APPNAME="nvim-Yoink" nvim'
```
When you run nvim-Yoink, it will use `~/.config/nvim-Yoink` and `~/.local/share/nvim-Yoink`.

 Q: How do I remove Yoink.nvim?
 A: See lazy.nvim uninstall.
 Q: Why is this multi-file instead of one file?
 A: The original Kickstart was single-file for simplicity. This fork is split into multiple files for easier maintenance and clarity.
 Q: where is the rest of the README?
 A: It has been reduced in size as most of Lua files are documented well enough. If you have any questions, feel free to ask in the issues section.


