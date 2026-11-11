# Setup and troubleshooting

[README](../README.md) · [Keybindings](keybindings.md)

## Proxmox / Linux

Start with the [Debian prerequisites](../README.md#proxmox--debian). Debian calls
the fd executable `fdfind`; Telescope supports it. Python's venv package is needed
for Mason's isolated Debugpy environment.

### Install Neovim

Use Neovim **0.11.3+**. The Mac configuration has been tested with **0.12.6**;
using the same release on Proxmox reduces version differences.

If the packaged Neovim is too old, run these commands as the account that will use
Neovim to install an official release under its home directory:

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

Add `$HOME/.local/bin` to your shell's persistent `PATH`.

### Install external tools

Install current [Go](https://go.dev/doc/install) and [Rust](https://rustup.rs/)
toolchains for development and for building the utilities below. Check that your
Node.js release meets the requirements reported by `:checkhealth mason`.

Follow the [Yazi](https://yazi-rs.github.io/docs/installation/) and
[Lazygit](https://github.com/jesseduffield/lazygit#installation) installation guides,
or build them with those toolchains:

```sh
cargo install --locked yazi-fm yazi-cli
go install github.com/jesseduffield/lazygit@latest
export PATH="$HOME/.cargo/bin:$HOME/go/bin:$PATH"
```

Persist those paths, adjusting the Go path if you use a custom `GOBIN` or `GOPATH`.
Both `yazi` and its companion `ya` must be on `PATH`.

## Configuration locations

The default paths on Mac and Linux are `~/.config/nvim` for configuration and
`~/.local/share/nvim` for installed plugins and Mason tools. `XDG_CONFIG_HOME` and
`XDG_DATA_HOME` override these locations.

Back up an existing configuration before cloning. To customize your own copy,
[fork the repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo)
and replace `Psylar87/yoink.nvim` in the clone commands with your fork.

### Side-by-side installation

```sh
git clone https://github.com/Psylar87/yoink.nvim.git ~/.config/nvim-yoink
NVIM_APPNAME=nvim-yoink nvim
```

An optional shell alias:

```sh
alias nvim-yoink='NVIM_APPNAME="nvim-yoink" nvim'
```

This uses `~/.config/nvim-yoink` and `~/.local/share/nvim-yoink`. Adjust the paths
in recovery commands if you use this installation or custom XDG directories.

## Plugin and tool versions

Share the configuration and [lazy-lock.json](../lazy-lock.json) between machines.
Install plugins and Mason tools separately on each machine so native binaries match
the OS and CPU.

Use `:Lazy restore` to deploy committed plugin versions. `:Lazy sync` includes
updates and can rewrite the lockfile; use it when intentionally updating and
testing plugins before sharing the new lockfile.

Run `:MasonToolsInstall` after the initial plugin installation and whenever the
configured tool list changes. Wait for completion, then restart Neovim. The general
tool installer does not run at every startup, though Mason's LSP integration can
install missing configured servers. Use `:Mason` for status and `:MasonLog` for failures.

### Languages and formatters

| Language | Configured server | Formatting |
|----------|-------------------|------------|
| Bash | `bashls` | shfmt |
| Lua | `lua_ls` | StyLua |
| Go | `gopls` | LSP fallback; import organization on save |
| Rust | `rust_analyzer` | LSP fallback |
| Python | `pyright` | Ruff |
| JS/TS, HTML, CSS, JSON | — | Prettierd, with Prettier fallback |
| YAML | — | yamlfmt |

Mason also installs Debugpy, Delve, CodeLLDB, and additional Go tools. Debugging
requires the relevant language runtime; CodeLLDB launches need a compiled debug build.

## Platform options

Set these globals **before initialization**, for example with `nvim --cmd 'lua …'`:

| Global | Set to `false` to… |
|--------|-------------------|
| `vim.g.have_nerd_font` | Disable font-dependent icons where supported; some decorative glyphs still need a Nerd Font |
| `vim.g.yoink_images` | Disable image previews |
| `vim.g.yoink_open_tree_on_start` | Skip the file tree on an empty start |
| `vim.g.yoink_notify_startup_time` | Disable the startup-time notification |

- **Obsidian:** enabled only on macOS. Uses the iCloud `Dev` vault when available,
  otherwise a local vault under Neovim's data directory.
- **SSH clipboard:** OSC52 copies to a compatible client terminal. `p`/`P` uses
  the session's copy cache; paste new Mac text with the terminal's paste shortcut.
  A custom `vim.g.clipboard` set before initialization takes precedence.
- **Clipboard images:** need `pngpaste` on Mac. Local Linux desktops can use
  Wayland's `wl-paste` or X11's `xclip`; this feature is disabled over Linux SSH.
- **Image previews:** Snacks detects terminal graphics support and can transfer
  images over SSH. Kitty and Ghostty are supported; WezTerm support is limited.
  ImageMagick handles conversion of formats other than PNG.
- **Fonts:** rendered by the client terminal, including over SSH.
- **Yazi shortcuts:** missing directories fall back to home without changing the
  editor's working directory.

## Compatibility and save behavior

Treesitter and textobjects use the legacy `master` branches. The legacy Treesitter
branch is not officially supported upstream on Neovim 0.12. Existing guards disable
Markdown Treesitter highlighting, render-markdown, context-commentstring integration,
Snacks indent guides, and document image previews on 0.12+. Migrating to the rewritten
Treesitter API is a separate change.

Telescope and DAP load on demand. Treesitter loads at startup; Conform loads when
opening/creating a file or using the format shortcut.

Format-on-save skips Markdown, plain text, and Git commit messages. Manual formatting
uses Conform with LSP fallback. Generic whitespace cleanup also skips Markdown to
preserve hard line breaks.

Go import organization uses the attached `gopls` client with bounded waits. Failures
produce warnings and allow saving to continue.

## Health checks

```vim
:checkhealth mason
:checkhealth vim.lsp
:checkhealth yazi
:checkhealth snacks
:ConformInfo
```

View a diagnostic with `<leader>ee`. On Neovim 0.12+, restart language servers with
`:lsp restart`; on 0.11, use `:LspRestart`.

Compare `nvim --version`, `yazi --version`, and `ya --version` between machines
when investigating differences.

## Yazi recovery

If Lazy reports local changes in the installed plugin checkout, inspect it on Proxmox:

```sh
git -C ~/.local/share/nvim/lazy/yazi.nvim status --short
git -C ~/.local/share/nvim/lazy/yazi.nvim diff --stat HEAD
```

For a clean reinstall, close Neovim. These commands assume the default config/data
directories. They back up the plugin checkout and current lockfile outside Lazy's
managed directory before restoring the committed lockfile:

```sh
backup_dir="$(mktemp -d "$HOME/nvim-recovery.XXXXXXXX")"
cp "$HOME/.config/nvim/lazy-lock.json" "$backup_dir/lazy-lock.json"
mv "$HOME/.local/share/nvim/lazy/yazi.nvim" "$backup_dir/yazi.nvim"
git -C "$HOME/.config/nvim" restore --source=HEAD -- lazy-lock.json
printf 'Recovery backup: %s\n' "$backup_dir"
nvim
```

Lazy installs the missing plugin on startup. After it finishes, run `:Lazy restore`
and `:checkhealth yazi`. Confirm `yazi` and `ya` are installed separately on the server.
The backup retains any plugin edits for inspection or recovery.

## Verify an installation

- Open representative projects and confirm the expected LSP server attaches.
- Test `<leader>f` and format-on-save using `:ConformInfo` to check availability.
- Test file search, live grep, Yazi file selection, Lazygit, and terminal navigation.
- Test breakpoints and debug launch in a supported project.
- Confirm `Alt-l` moves a line right, including after using `:LuaOutput`.
- Save a Go file with an unused import and a missing standard-library import;
  verify the corrected file builds.
- On Mac, check Obsidian commands, metadata on a test note, and image/clipboard behavior.
- On Proxmox, confirm Obsidian shortcuts are absent, copy to a Mac app over SSH,
  and paste Mac text through the terminal.

SSH clipboard and graphics checks require the actual terminal session. The Linux/SSH
configuration has simulated coverage on Mac; these host-specific checks remain necessary.

### Regression checks

From the configuration root:

```sh
nvim --headless -u NONE -i NONE -l tests/go.lua
```

These checks use in-memory buffers and simulated server responses to cover request
structure, workspace-edit encoding, both command response forms, command completion,
disabled actions, and save-safe error handling. Verify actual `gopls` behavior in a
Go project on each machine as well.
