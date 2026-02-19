# Yoink.nvim (Multi-File Edition)
![Yoink](yoink.nvim.png)
## "Professionally acquired configurations"
<a href="https://dotfyle.com/MillerApps/yoinknvim"><img src="https://dotfyle.com/MillerApps/yoinknvim/badges/plugins?style=for-the-badge" /></a>
<a href="https://dotfyle.com/MillerApps/yoinknvim"><img src="https://dotfyle.com/MillerApps/yoinknvim/badges/leaderkey?style=for-the-badge" /></a>
<a href="https://dotfyle.com/MillerApps/yoinknvim"><img src="https://dotfyle.com/MillerApps/yoinknvim/badges/plugin-manager?style=for-the-badge" /></a>

A fun fork of [kickstart.nvim by MillerApps](https://github.com/nvim-lua/kickstart.nvim).

## Introduction

**Yoink.nvim** is a **multi-file** configuration inspired by the original [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It maintains the original goal of offering a teaching tool and reference config, but in a **more modular and maintainable** structure.

> [!NOTE] 
> Default Neovim config paths:
>

 | OS                     | Path                                          |
 |------------------------|-----------------------------------------------|
 | Linux, MacOS          | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim`      |
 | Windows (cmd)         | `%userprofile%\AppData\Local\nvim\`            |
 | Windows (PowerShell)  | `$env:USERPROFILE\AppData\Local\nvim\`         |


#### Why Fork?
Forking the repo ensures you have a personal copy to modify at will. See [GitHub docs on forking][gh-fork-docs].

Replace `MillerApps/kickstart.nvim` with **your fork URL** if you fork the repo.

> Q: I already have a Neovim config. What do I do?
>
> A: Back up your existing config, then remove it:

```sh 
mv ~/.config/nvim ~/.config/nvim.old
rm -rf ~/.local/share/nvim/
```

> Q: Can I use multiple Neovim configs?
>
> A: Yes! Set `$NVIM_APPNAME`. For example:

# Install this config in `~/.config/nvim-Yoink`
# Then create an alias:

```sh 
alias nvim-Yoink='NVIM_APPNAME="nvim-Yoink" nvim'
```
When you run nvim-Yoink, it will use `~/.config/nvim-Yoink` and `~/.local/share/nvim-Yoink`.

## Install Instructions

 > Install requires Neovim 0.9+. Always review the code before installing a configuration.

Clone the repository and install the plugins:

```sh
git clone git@github.com:MillerApps/yoink.nvim ~/.config/MillerApps/yoink.nvim
```

Open Neovim with this config:

```sh
NVIM_APPNAME=MillerApps/yoink.nvim/ nvim
```

## Keybindings

### General
| Key | Mode | Action |
|-----|------|--------|
| `<Space>` | N | Leader key |
| `<Esc>` | N | Clear search highlighting |
| `<C-s>` | N | Save file |
| `<C-x>` | N | Save and quit |
| `<C-q>` | N | Quit all |
| `<C-h/j/k/l>` | N | Navigate windows |
| `<C-Arrow>` | N | Resize windows |
| `<` / `>` | V | Indent and keep selection |
| `J` / `K` | X | Move selected text down/up |

### Telescope (Fuzzy Finder)
| Key | Action |
|-----|--------|
| `<leader>sh` | Search Help |
| `<leader>sk` | Search Keymaps |
| `<leader>sf` | Search Files |
| `<leader>ss` | Search Telescope pickers |
| `<leader>sw` | Search current Word |
| `<leader>sg` | Search by Grep |
| `<leader>sd` | Search Diagnostics |
| `<leader>sr` | Search Resume |
| `<leader>s.` | Search Recent Files |
| `<leader><leader>` | Find existing buffers |
| `<leader>/` | Fuzzy search in current buffer |
| `<leader>s/` | Live grep in open files |
| `<leader>sn` | Search Neovim config files |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to Definition |
| `gr` | Go to References |
| `gI` | Go to Implementation |
| `gD` | Go to Declaration |
| `K` | Hover Documentation |
| `<leader>D` | Type Definition |
| `<leader>rn` | Rename |
| `<leader>ca` | Code Action |
| `<leader>ds` | Document Symbols |
| `<leader>ws` | Workspace Symbols |
| `<leader>f` | Format code |

### Diagnostics
| Key | Action |
|-----|--------|
| `<leader>ee` | Show diagnostic float |
| `<leader>q` | Open diagnostic quickfix |
| `[d` / `]d` | Previous/Next diagnostic |

### File Explorer (nvim-tree)
| Key | Action |
|-----|--------|
| `<C-f>` | Toggle file tree |
| `<leader>nt` | Focus file tree |
| `<leader>nf` | Find current file |

### Buffer Management (Barbar)
| Key | Action |
|-----|--------|
| `<A-,>` / `<A-.>` | Previous/Next buffer |
| `<A-<>` / `<A->>` | Move buffer left/right |
| `<A-1-9>` | Go to buffer 1-9 |
| `<A-0>` | Go to last buffer |
| `<A-p>` | Pin buffer |
| `<A-q>` | Close buffer |
| `<C-p>` | Pick buffer |
| `<leader>bb` | Sort by buffer number |
| `<leader>bd` | Sort by directory |
| `<leader>bl` | Sort by language |

### Git (Gitsigns)
| Key | Action |
|-----|--------|
| `<leader>gb` | Toggle git blame |
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gp` | Preview hunk |
| `[g` / `]g` | Previous/Next hunk |

### Git (Snacks/Lazygit)
| Key | Action |
|-----|--------|
| `<leader>gg` | Open Lazygit |
| `<leader>gl` | Lazygit log (cwd) |
| `<leader>gf` | Lazygit file history |
| `<leader>gB` | Git browse (open in browser) |

### Debugging (DAP)
| Key | Action |
|-----|--------|
| `<leader>bt` | Toggle breakpoint |
| `<leader>bC` | Conditional breakpoint |
| `<leader>bc` | Continue |
| `<leader>bx` | Terminate |
| `<leader>bo` | Step over |
| `<leader>bi` | Step into |
| `<leader>bu` | Step out |
| `<leader>br` | Restart |
| `<leader>bv` | Evaluate expression |

### Mini.nvim
| Key | Action |
|-----|--------|
| `sa` | Add surround |
| `sd` | Delete surround |
| `sr` | Replace surround |
| `sh` | Highlight surround |
| `gS` | Toggle split/join |
| `<leader>bd` | Delete buffer (mini.bufremove) |
| `<M-h/j/k/l>` | Move lines/selection |

### Treesitter
| Key | Action |
|-----|--------|
| `<C-space>` | Init/increment selection |
| `<C-s>` | Scope incremental |
| `<C-backspace>` | Decrement selection |
| `af` / `if` | Select around/inside function |
| `ac` / `ic` | Select around/inside class |
| `]m` / `[m` | Next/Previous function start |
| `]]` / `[[` | Next/Previous class start |

### Terminal (Snacks)
| Key | Action |
|-----|--------|
| `<A-t>` | Toggle terminal |
| `<Esc>` | Exit terminal mode |
| `<C-h/j/k/l>` | Navigate from terminal |

### Quickfix
| Key | Action |
|-----|--------|
| `[q` / `]q` | Previous/Next quickfix item |
| `<leader>qf` | Open quickfix |
| `<leader>qc` | Close quickfix |

### Plugin Manager
| Key | Action |
|-----|--------|
| `<leader>l` | Open Lazy |

## Plugins

### colorscheme
+ [catppuccin/nvim](https://dotfyle.com/plugins/catppuccin/nvim)

### comment
+ [folke/todo-comments.nvim](https://dotfyle.com/plugins/folke/todo-comments.nvim)

### completion
+ [Saghen/blink.cmp](https://dotfyle.com/plugins/Saghen/blink.cmp)

### debugging
+ [mfussenegger/nvim-dap](https://dotfyle.com/plugins/mfussenegger/nvim-dap)
+ [rcarriga/nvim-dap-ui](https://dotfyle.com/plugins/rcarriga/nvim-dap-ui)

### editing-support
+ [echasnovski/mini.nvim](https://dotfyle.com/plugins/echasnovski/mini.nvim) (surround, pairs, comment, move, etc.)

### file-explorer
+ [nvim-tree/nvim-tree.lua](https://dotfyle.com/plugins/nvim-tree/nvim-tree.lua)
+ [stevearc/oil.nvim](https://dotfyle.com/plugins/stevearc/oil.nvim)
+ [mikavilpas/yazi.nvim](https://dotfyle.com/plugins/mikavilpas/yazi.nvim)

### formatting
+ [stevearc/conform.nvim](https://dotfyle.com/plugins/stevearc/conform.nvim)

### fuzzy-finder
+ [nvim-telescope/telescope.nvim](https://dotfyle.com/plugins/nvim-telescope/telescope.nvim)

### git
+ [lewis6991/gitsigns.nvim](https://dotfyle.com/plugins/lewis6991/gitsigns.nvim)

### icon
+ [nvim-tree/nvim-web-devicons](https://dotfyle.com/plugins/nvim-tree/nvim-web-devicons)

### keybinding
+ [folke/which-key.nvim](https://dotfyle.com/plugins/folke/which-key.nvim)

### lsp
+ [j-hui/fidget.nvim](https://dotfyle.com/plugins/j-hui/fidget.nvim)
+ [neovim/nvim-lspconfig](https://dotfyle.com/plugins/neovim/nvim-lspconfig)

### lsp-installer
+ [williamboman/mason.nvim](https://dotfyle.com/plugins/williamboman/mason.nvim)

### markdown-and-latex
+ [MeanderingProgrammer/render-markdown.nvim](https://dotfyle.com/plugins/MeanderingProgrammer/render-markdown.nvim)

### media
+ [HakonHarnes/img-clip.nvim](https://dotfyle.com/plugins/HakonHarnes/img-clip.nvim)
+ [3rd/image.nvim](https://dotfyle.com/plugins/3rd/image.nvim)

### note-taking
+ [epwalsh/obsidian.nvim](https://dotfyle.com/plugins/epwalsh/obsidian.nvim)

### nvim-dev
+ [nvim-lua/plenary.nvim](https://dotfyle.com/plugins/nvim-lua/plenary.nvim)
+ [MunifTanjim/nui.nvim](https://dotfyle.com/plugins/MunifTanjim/nui.nvim)
+ [folke/lazydev.nvim](https://dotfyle.com/plugins/folke/lazydev.nvim)

### plugin-manager
+ [folke/lazy.nvim](https://dotfyle.com/plugins/folke/lazy.nvim)

### snippet
+ [rafamadriz/friendly-snippets](https://dotfyle.com/plugins/rafamadriz/friendly-snippets)

### startup
+ [folke/snacks.nvim](https://dotfyle.com/plugins/folke/snacks.nvim) (dashboard)

### syntax
+ [nvim-treesitter/nvim-treesitter](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter)
+ [nvim-treesitter/nvim-treesitter-textobjects](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter-textobjects)

### tabline
+ [romgrk/barbar.nvim](https://dotfyle.com/plugins/romgrk/barbar.nvim)

### utility
+ [folke/noice.nvim](https://dotfyle.com/plugins/folke/noice.nvim)
+ [rcarriga/nvim-notify](https://dotfyle.com/plugins/rcarriga/nvim-notify)
+ [folke/snacks.nvim](https://dotfyle.com/plugins/folke/snacks.nvim) (terminal, git, dim, scroll, words, etc.)

## Language Servers

Configured LSP servers via Mason:
+ bashls (Bash)
+ lua_ls (Lua)
+ rust_analyzer (Rust)
+ gopls (Go)
+ pyright (Python)

## Formatters (via conform.nvim)

Configured via Mason:
+ stylua (Lua)
+ prettierd (JS/TS/HTML/CSS/JSON)
+ ruff (Python)
+ shfmt (Shell)
+ yamlfmt (YAML)

 This readme was generated by [Dotfyle](https://dotfyle.com)
