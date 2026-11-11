# Yoink.nvim

![Yoink](yoink.nvim.png)

*Professionally acquired configurations.*

A modular Neovim configuration for macOS and Linux over SSH, based on
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

## Features

- File search with Telescope; file navigation with nvim-tree and Yazi.
- Language servers, Blink completion, formatting, and debugging.
- Git signs, blame, and Lazygit integration.
- Catppuccin theme, buffer tabs, editing helpers, and a terminal.
- Obsidian integration on macOS.

## Requirements

- **Neovim 0.11.3+**; tested on macOS with **0.12.6**.
- Git, a C compiler, and Make for plugin installation/builds.
- Node.js/npm and Python with venv support for Mason tools.
- Go and Rust toolchains if you use those languages.
- A Nerd Font is recommended for terminal icons, including over SSH.

### macOS

Install Apple's command-line developer tools with `xcode-select --install` if needed, then:

```sh
brew install neovim git ripgrep fd node python go yazi lazygit pngpaste imagemagick
```

Install [rustup](https://rustup.rs/) for Rust development.

### Proxmox / Debian

Run as root, or prefix with `sudo`:

```sh
apt update
apt install -y git curl unzip tar gzip build-essential ripgrep fd-find nodejs npm python3 python3-venv python3-pip
```

Check `nvim --version`. See the [Linux setup guide](docs/setup.md#proxmox--linux)
for installing a suitable Neovim release, Yazi, Lazygit, and language toolchains.

## Install

Back up any existing `~/.config/nvim` directory, then run as your Neovim user:

```sh
git clone https://github.com/Psylar87/yoink.nvim.git ~/.config/nvim
nvim
```

After Lazy finishes installing plugins, run inside Neovim:

```vim
:Lazy restore
:MasonToolsInstall
:TSUpdate
```

Wait for installation to finish, then restart Neovim.
For a separate configuration alongside your current one, use the
[side-by-side instructions](docs/setup.md#side-by-side-installation).

## Update

Close Neovim and preserve any local configuration edits before pulling:

```sh
git -C ~/.config/nvim pull --ff-only
nvim
```

Run **`:Lazy restore`** to use the committed plugin versions. Rerun
`:MasonToolsInstall` and `:TSUpdate` when tools or parsers change.
Use `:Lazy sync` only when intentionally updating plugin versions and the lockfile.

## Essential shortcuts

The leader key is **Space**. Press a prefix and pause to see Which-key suggestions.

| Key | Action |
|-----|--------|
| `<C-s>` | Save file |
| `<C-f>` | Toggle file tree |
| `<leader>sf` | Find files |
| `<leader>sg` | Search text |
| `<leader><leader>` | Find open buffers |
| `<leader>bd` | Delete buffer |
| `<leader>f` | Format buffer |
| `<leader>gg` | Open Lazygit |
| `<leader>-` | Open Yazi |
| `<A-t>` | Toggle terminal |
| `<leader>ee` | Show diagnostic |
| `<leader>l` | Open Lazy |

See the [full keybinding reference](docs/keybindings.md) for LSP, debugging,
Git hunks, window navigation, Obsidian, and more.

## Mac and SSH behavior

| Feature | Mac | Proxmox over SSH |
|---------|-----|------------------|
| Obsidian | iCloud `Dev` vault, with a local fallback | Disabled |
| Text clipboard | Native macOS clipboard | OSC52 copy with a local paste cache |
| Clipboard images | Enabled with `pngpaste` | Disabled |
| Image previews | Depends on terminal support | Depends on terminal support |
| Yazi directory shortcuts | Open the requested directory | Fall back to home if missing |

For SSH copying, your Mac terminal must support and permit **OSC52**.
Paste new Mac clipboard text using the terminal's paste shortcut, usually **Cmd-V**.
Neovim `p`/`P` reuses the last text copied in that session.

## Reference and troubleshooting

- [Detailed setup, compatibility notes, health checks, and Yazi recovery](docs/setup.md)
- [Full keybindings](docs/keybindings.md)
- [Plugin configuration](lua/config/plugins) and [locked plugin versions](lazy-lock.json)
- [Go regression checks](docs/setup.md#regression-checks)

The Mac setup and simulated Linux/SSH checks have been tested; verify tools and
terminal behavior on the actual Proxmox host after installation.
