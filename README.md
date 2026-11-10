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
Forking the repo ensures you have a personal copy to modify at will. See [GitHub docs on forking](https://docs.github.com/en/get-started/quickstart/fork-a-repo).

Replace `Psylar87/yoink.nvim` with **your fork URL** if you fork the repo.

> Q: I already have a Neovim config. What do I do?
>
> A: Back up your existing config:

```sh
mv ~/.config/nvim ~/.config/nvim.old
```

> Q: Can I use multiple Neovim configs?
>
> A: Yes! Set `$NVIM_APPNAME`. For example:

Install this config in `~/.config/nvim-yoink`, then create an alias:

```sh
alias nvim-yoink='NVIM_APPNAME="nvim-yoink" nvim'
```
When you run `nvim-yoink`, it will use `~/.config/nvim-yoink` and `~/.local/share/nvim-yoink`.

## Install Instructions

Requires **Neovim 0.11.3+**. The current Mac setup is tested with **0.12.6**; use the same release on Proxmox initially. The Linux/SSH settings have simulated coverage on the Mac; the final terminal and tool checks must run on the server.

### Mac prerequisites

Install the command-line developer tools (`xcode-select --install`) if needed, then install dependencies with Homebrew:

```sh
brew install neovim git ripgrep fd node python go yazi lazygit pngpaste imagemagick
```

Install a current Rust toolchain with [rustup](https://rustup.rs/) if you use Rust or Clippy. Use a Nerd Font in your Mac terminal for the configured icons.

### Proxmox host prerequisites

Run the package commands as root on the Debian-based Proxmox host (or prefix them with `sudo` when available):

```sh
apt update
apt install -y git curl unzip tar gzip build-essential ripgrep fd-find nodejs npm python3 python3-venv python3-pip
```

Debian names the fd executable `fdfind`; Telescope supports it. Node/npm are used by servers and formatters such as Pyright and Prettierd. Python's venv support is needed for Mason's isolated Debugpy environment.

Run the remaining commands as the account that will use Neovim. If the packaged Neovim is too old, install the selected official release in that account's home directory:

```sh
NVIM_VERSION=v0.12.6
case "$(uname -m)" in
  x86_64) NVIM_ARCH=x86_64 ;;
  aarch64|arm64) NVIM_ARCH=arm64 ;;
  *) printf 'Unsupported architecture: %s\n' "$(uname -m)"; exit 1 ;;
esac
mkdir -p "$HOME/.local/opt" "$HOME/.local/bin"
curl -fL "https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux-$NVIM_ARCH.tar.gz" \
  -o "/tmp/nvim-linux-$NVIM_ARCH.tar.gz"
tar -xzf "/tmp/nvim-linux-$NVIM_ARCH.tar.gz" -C "$HOME/.local/opt"
ln -sfn "$HOME/.local/opt/nvim-linux-$NVIM_ARCH/bin/nvim" "$HOME/.local/bin/nvim"
export PATH="$HOME/.local/bin:$PATH"
nvim --version
```

Add `$HOME/.local/bin` to your shell's persistent `PATH`. Install current [Go](https://go.dev/doc/install) and [Rust](https://rustup.rs/) toolchains for Go/Rust development and building the optional utilities below. Check that your Node release meets the requirements reported by `:checkhealth mason`.

Install Yazi and Lazygit using their [Yazi installation guide](https://yazi-rs.github.io/docs/installation/) and [Lazygit installation guide](https://github.com/jesseduffield/lazygit#installation), or build them with those toolchains:

```sh
cargo install --locked yazi-fm yazi-cli
go install github.com/jesseduffield/lazygit@latest
export PATH="$HOME/.cargo/bin:$HOME/go/bin:$PATH"
```

Persist those paths too, adjusting `$HOME/go/bin` if you use a custom `GOBIN` or `GOPATH`. Both `yazi` and its companion `ya` must be on `PATH`.

### Install the shared configuration

Back up an existing config first, then clone using HTTPS (no GitHub SSH key is needed):

```sh
git clone https://github.com/Psylar87/yoink.nvim.git ~/.config/nvim
nvim
```

After Lazy finishes installing plugins, run these commands inside Neovim:

```vim
:MasonToolsInstall
:TSUpdate
```

Wait for tool installation to finish, then restart Neovim. `:MasonToolsInstall` installs the configured language servers (including Lua), formatters, Debugpy, Delve, and CodeLLDB. `:Mason` shows installation status; `:MasonLog` explains installation failures. The general tool installer does not run automatically at startup; Mason's LSP integration can still install missing configured servers.

Share this repository and `lazy-lock.json` between machines. Install plugins and Mason tools on each machine so their native binaries match its OS and CPU; do not copy the Mac's Neovim data directory to Linux. `:Lazy restore` restores the versions in the lockfile.

For a side-by-side installation:

```sh
git clone https://github.com/Psylar87/yoink.nvim.git ~/.config/nvim-yoink
NVIM_APPNAME=nvim-yoink nvim
```

### Mac and Linux behavior

| Feature | Mac | Proxmox over SSH |
|---------|-----|------------------|
| Obsidian | Existing iCloud `Dev` vault; local data-directory fallback if unavailable | Disabled, including shortcuts |
| Text clipboard | Native macOS clipboard | OSC52 copying to the client terminal; cached text for Neovim puts |
| Clipboard image paste | Enabled when `pngpaste` is installed | Disabled |
| Image previews | Snacks terminal capability detection | Same detection; supported terminals can receive images over SSH |
| Yazi directory shortcuts | Open the requested directory | Fall back to home if Desktop/Downloads/etc. is absent |

Over SSH, yanking copies to your Mac clipboard **if your terminal supports and permits OSC52**. Use your Mac terminal's paste shortcut (usually `Cmd-V`) to insert newly copied Mac text. Normal Neovim `p`/`P` reuses the last text copied in that Neovim session; the configuration does not query your Mac clipboard. A custom `vim.g.clipboard` set before initialization takes precedence.

Image previews require a compatible terminal such as Kitty or Ghostty; WezTerm support is limited. They are separate from image clipboard access. Set `vim.g.yoink_images = false` before initialization to disable previews. A Linux desktop session can enable image clipboard paste when its Wayland `wl-paste` or X11 `xclip` provider is present.

Fonts are rendered by the terminal on your Mac, including over SSH. Set `vim.g.have_nerd_font = false` before initialization if that terminal does not use a Nerd Font; some explicitly configured decorative glyphs still require one.

## Startup / Loading Notes

- Telescope and DAP load on demand from keys/commands (faster startup).
- Gitsigns and Conform load when opening/creating files.
- Mason tool installer no longer auto-runs at startup (`run_on_start = false`).
- Treesitter and textobjects explicitly use the legacy `master` branches. The existing Neovim 0.12 compatibility guards remain: Markdown Treesitter highlighting, render-markdown, and document image previews are disabled on 0.12+. The legacy Treesitter branch is not officially supported upstream on 0.12; a migration to its rewritten API is a separate future change.
- Format-on-save skips Markdown, plain text, and Git commit messages. Manual formatting uses Conform with LSP fallback; generic whitespace cleanup also skips Markdown.

## Verification after installation

On each machine, open representative Lua, Python, Go, and Rust projects and check:

- `:checkhealth mason` and `:checkhealth vim.lsp` for dependencies and attached servers.
- `:ConformInfo`, `<leader>f`, and saving a code file for formatter availability and behavior.
- `<leader>sf` / `<leader>sg` for file search and grep, `<leader>-` for Yazi, and `<leader>gg` for Lazygit.
- `<leader>bt` / `<leader>bc` for a breakpoint and debug launch in a supported project. Rust/C/C++ programs need a compiled debug build selected at launch.
- `Alt-l` still moves a line right, including after invoking `:LuaOutput`.

On the Mac, verify the Obsidian shortcuts and metadata on a test note, plus clipboard/image behavior. On Proxmox, verify that Obsidian shortcuts are absent, yank text and paste it into a Mac app, then copy text on the Mac and paste it into Neovim using the terminal. These SSH clipboard and graphics checks require your actual terminal session.

## Yoink Quick Start

Your "I just opened Neovim, let's go" keys:

| Key | Action |
|-----|--------|
| `<C-f>` | Toggle NvimTree |
| `<leader>nt` | Focus NvimTree |
| `<leader>sf` | Telescope find files |
| `<leader>sg` | Telescope live grep |
| `<leader>gg` | Open Lazygit |
| `<leader>f` | Format current buffer |
| `<leader>bd` | Delete buffer (mini.bufremove) |
| `<leader>on` | New Obsidian note (Mac only) |

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
| `<leader>gt` | Go: run all tests |

### Diagnostics
| Key | Action |
|-----|--------|
| `<leader>ee` | Show diagnostic float |
| `<leader>qd` | Open diagnostic location list |
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
| `<leader>bod` | Sort by directory |
| `<leader>bl` | Sort by language |
| `<leader>bw` | Sort by window number |

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

### Obsidian
Available on macOS only.

| Key | Action |
|-----|--------|
| `<leader>of` | Search notes |
| `<leader>os` | Quick switch note |
| `<leader>on` | New note |
| `<leader>ol` | Follow link |
| `<leader>ob` | Show backlinks |
| `<leader>ot` | Browse tags |

### Yazi
| Key | Action |
|-----|--------|
| `<leader>-` | Open yazi at current file |
| `<leader>cw` | Open yazi in current working directory |
| `<C-y>` | Resume/toggle last yazi session |
| `<leader>yh` | Open yazi in home directory |
| `<leader>yn` | Open yazi in Neovim config directory |
| `<leader>yw` | Open yazi in Downloads |
| `<leader>yk` | Open yazi in Desktop |
| `<leader>yc` | Open yazi in `.config` |

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

### Snacks (UI Helpers)
| Key | Action |
|-----|--------|
| `<leader>un` | Dismiss all notifications |
| `<leader>dd` | Dim on |
| `<leader>do` | Dim off |

### Noice
| Key | Action |
|-----|--------|
| `<leader>nl` | Show last Noice message |
| `<leader>nh` | Show Noice history |

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

### LuaOutput
| Key | Action |
|-----|--------|
| `<leader>xl` | Execute the current buffer as Lua and show its output |

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
+ [folke/snacks.nvim](https://dotfyle.com/plugins/folke/snacks.nvim) (image previews)

### note-taking
+ [obsidian-nvim/obsidian.nvim](https://dotfyle.com/plugins/obsidian-nvim/obsidian.nvim)

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
