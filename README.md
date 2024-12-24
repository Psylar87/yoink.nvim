# Yoink.nvim (Multi-File Edition)
![Yoink](yoink.nvim.png)
## "Professionally acquired configurations"
<a href="https://dotfyle.com/MillerApps/yoinknvim"><img src="https://dotfyle.com/MillerApps/yoinknvim/badges/plugins?style=for-the-badge" /></a>
<a href="https://dotfyle.com/MillerApps/yoinknvim"><img src="https://dotfyle.com/MillerApps/yoinknvim/badges/leaderkey?style=for-the-badge" /></a>
<a href="https://dotfyle.com/MillerApps/yoinknvim"><img src="https://dotfyle.com/MillerApps/yoinknvim/badges/plugin-manager?style=for-the-badge" /></a>

A fun fork of [kickstart.nvim by MillerApps](https://github.com/nvim-lua/kickstart.nvim).

## Introduction

**Yoink.nvim** is a **multi-file** configuration inspired by the original [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It maintains the original goal of offering a teaching tool and reference config, but in a **more modular and maintainable** structure.

> [!INFO] Default Neovim config paths:

 | OS                     | Path                                          |
 |------------------------|-----------------------------------------------|
 | Linux, MacOS          | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim`      |
 | Windows (cmd)         | `%userprofile%\AppData\Local\nvim\`            |
 | Windows (PowerShell)  | `$env:USERPROFILE\AppData\Local\nvim\`         |


#### Why Fork?
Forking the repo ensures you have a personal copy to modify at will. See [GitHub docs on forking][gh-fork-docs].

Replace `MillerApps/kickstart.nvim` with **your fork URL** if you fork the repo.

> Q: I already have a Neovim config. What do I do?**
> A: Back up your existing config, then remove it:

```sh 
mv ~/.config/nvim ~/.config/nvim.old
rm -rf ~/.local/share/nvim/
``````

> Q: Can I use multiple Neovim configs?
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


## Plugins

### colorscheme

+ [catppuccin/nvim](https://dotfyle.com/plugins/catppuccin/nvim)
### comment

+ [folke/todo-comments.nvim](https://dotfyle.com/plugins/folke/todo-comments.nvim)
+ [numToStr/Comment.nvim](https://dotfyle.com/plugins/numToStr/Comment.nvim)
### completion

+ [Saghen/blink.cmp](https://dotfyle.com/plugins/Saghen/blink.cmp)
### debugging

+ [mfussenegger/nvim-dap](https://dotfyle.com/plugins/mfussenegger/nvim-dap)
+ [rcarriga/nvim-dap-ui](https://dotfyle.com/plugins/rcarriga/nvim-dap-ui)
### editing-support

+ [nvim-treesitter/nvim-treesitter-context](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter-context)
+ [windwp/nvim-autopairs](https://dotfyle.com/plugins/windwp/nvim-autopairs)
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
### indent

+ [lukas-reineke/indent-blankline.nvim](https://dotfyle.com/plugins/lukas-reineke/indent-blankline.nvim)
### keybinding

+ [folke/which-key.nvim](https://dotfyle.com/plugins/folke/which-key.nvim)
### lsp

+ [mfussenegger/nvim-lint](https://dotfyle.com/plugins/mfussenegger/nvim-lint)
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
+ [folke/neodev.nvim](https://dotfyle.com/plugins/folke/neodev.nvim)
### plugin-manager

+ [folke/lazy.nvim](https://dotfyle.com/plugins/folke/lazy.nvim)
### snippet

+ [rafamadriz/friendly-snippets](https://dotfyle.com/plugins/rafamadriz/friendly-snippets)
### startup

+ [goolord/alpha-nvim](https://dotfyle.com/plugins/goolord/alpha-nvim)
### syntax

+ [nvim-treesitter/nvim-treesitter](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter)
+ [nvim-treesitter/nvim-treesitter-textobjects](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter-textobjects)
### tabline

+ [romgrk/barbar.nvim](https://dotfyle.com/plugins/romgrk/barbar.nvim)
### utility

+ [folke/noice.nvim](https://dotfyle.com/plugins/folke/noice.nvim)
+ [rcarriga/nvim-notify](https://dotfyle.com/plugins/rcarriga/nvim-notify)
+ [echasnovski/mini.nvim](https://dotfyle.com/plugins/echasnovski/mini.nvim)
## Language Servers

+ html
+ tflint


 This readme was generated by [Dotfyle](https://dotfyle.com)
