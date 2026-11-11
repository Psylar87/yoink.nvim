# Keybindings

[README](../README.md) · [Setup and troubleshooting](setup.md)

The leader and local leader keys are **Space**. `<C-…>` means Ctrl; `<A-…>` and
`<M-…>` mean Alt/Option. Most mappings below use Normal mode unless noted.
Pause after a prefix to see Which-key suggestions.

## General and windows

| Key | Action |
|-----|--------|
| `<Esc>` | Clear search highlighting |
| `<C-s>` | Save file |
| `<C-x>` | Save and quit |
| `<C-q>` | Quit all |
| `<C-h/j/k/l>` | Move between windows |
| `<C-Arrow>` | Resize window |
| `<` / `>` | Indent and retain selection (Visual mode) |
| `J` / `K` | Move selected lines down/up (Visual mode) |
| `<leader>l` | Open Lazy |

## Search — Telescope

| Key | Action |
|-----|--------|
| `<leader>sh` | Search help |
| `<leader>sk` | Search keymaps |
| `<leader>sf` | Find files |
| `<leader>ss` | Search Telescope pickers |
| `<leader>sw` | Search current word |
| `<leader>sg` | Search by grep |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Resume previous search |
| `<leader>s.` | Search recent files |
| `<leader><leader>` | Find open buffers |
| `<leader>/` | Fuzzy search current buffer |
| `<leader>s/` | Live grep in open files |
| `<leader>sn` | Search Neovim configuration |

## LSP and formatting

LSP navigation and actions are installed when a language server attaches.

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gD` | Go to declaration |
| `K` | Hover documentation |
| `<leader>D` | Type definition |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |
| `<leader>ds` | Document symbols |
| `<leader>ws` | Workspace symbols |
| `<leader>f` | Format with Conform |
| `<leader>gt` | Run `go test ./...` in a terminal |

## Diagnostics and quickfix

| Key | Action |
|-----|--------|
| `<leader>ee` | Show diagnostic float |
| `<leader>qd` | Open diagnostic location list |
| `[d` / `]d` | Previous/next diagnostic |
| `[q` / `]q` | Previous/next quickfix item |
| `<leader>qf` | Open quickfix |
| `<leader>qc` | Close quickfix |

## File tree — nvim-tree

| Key | Action |
|-----|--------|
| `<C-f>` | Toggle file tree |
| `<leader>nt` | Focus file tree |
| `<leader>nf` | Find current file in tree |

## Buffers — Barbar

| Key | Action |
|-----|--------|
| `<A-,>` / `<A-.>` | Previous/next buffer |
| `<A-<>` / `<A->>` | Move buffer left/right |
| `<A-1>` … `<A-9>` | Go to buffer 1–9 |
| `<A-0>` | Go to last buffer |
| `<A-p>` | Pin buffer |
| `<A-q>` | Close buffer |
| `<C-p>` | Pick buffer |
| `<leader>bb` | Sort by buffer number |
| `<leader>bod` | Sort by directory |
| `<leader>bl` | Sort by language |
| `<leader>bw` | Sort by window number |
| `<leader>bd` | Delete buffer with mini.bufremove |

## Git

| Key | Action |
|-----|--------|
| `<leader>gb` | Toggle line blame |
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gp` | Preview hunk |
| `[g` / `]g` | Previous/next hunk |
| `<leader>gg` | Open Lazygit |
| `<leader>gl` | Lazygit log for working directory |
| `<leader>gf` | Lazygit file history |
| `<leader>gB` | Open Git URL in browser (Normal/Visual mode) |

## Yazi

| Key | Action |
|-----|--------|
| `<leader>-` | Open at current file |
| `<leader>cw` | Open in working directory |
| `<C-y>` | Resume last session |
| `<leader>yh` | Open home directory |
| `<leader>yn` | Open Neovim configuration directory |
| `<leader>yw` | Open Downloads |
| `<leader>yk` | Open Desktop |
| `<leader>yc` | Open `.config` |

Missing directories fall back to home. Press `<F1>` inside Yazi for integration help.

## Debugging — DAP

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

## Editing — Mini.nvim

| Key | Action |
|-----|--------|
| `sa` | Add surround |
| `sd` | Delete surround |
| `sr` | Replace surround |
| `sh` | Highlight surround |
| `gS` | Toggle split/join |
| `<M-h/j/k/l>` | Move lines or selection |

## Treesitter

| Key | Action |
|-----|--------|
| `<C-space>` | Initialize/increment selection |
| `<C-s>` | Expand selection to scope (selection mode) |
| `<C-backspace>` | Decrement selection |
| `af` / `if` | Around/inside function |
| `ac` / `ic` | Around/inside class |
| `]m` / `[m` | Next/previous function start |
| `]M` / `[M` | Next/previous function end |
| `]]` / `[[` | Next/previous class start |
| `][` / `[]` | Next/previous class end |

Treesitter mappings are buffer-local. Where its class motions are not active,
Snacks also maps `]]` / `[[` to next/previous LSP reference.

## Terminal and UI

| Key | Action |
|-----|--------|
| `<A-t>` | Toggle terminal (Normal/Terminal mode) |
| `<Esc>` | Exit Terminal mode |
| `<C-h/j/k/l>` | Navigate from Terminal mode |
| `<leader>un` | Dismiss Snacks notifications |
| `<leader>dd` | Enable dimming |
| `<leader>do` | Disable dimming |
| `<leader>nl` | Last Noice message |
| `<leader>nh` | Noice history |
| `<leader>xl` | Execute current buffer as Lua and show output |

## Obsidian — macOS only

| Key | Action |
|-----|--------|
| `<leader>of` | Search notes |
| `<leader>os` | Quick switch note |
| `<leader>on` | New note |
| `<leader>ol` | Follow link |
| `<leader>ob` | Backlinks |
| `<leader>ot` | Browse tags |
