# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Neovim configuration using **VimScript** as the primary language with embedded Lua blocks for newer plugins. Uses **vim-plug** for plugin management and **CoC.nvim** as the LSP/completion engine.

## Architecture

### Bootstrap Order (init.vim)

```
plugins.vim → settings.vim → functions.vim → modules/functions/* → keys/map-nvim.vim → modules/* → themes/*
```

All files are sourced via absolute paths (`$HOME/.config/nvim/...`). This is a dotfiles repo symlinked to `~/.config/nvim`.

### Key Directories

- `modules/` — One file per plugin/feature config (50+ files). Each module is self-contained with its own mappings and settings.
- `modules/functions/` — Custom VimScript functions for line manipulation (delete, copy, duplicate, move, yank, visual select by relative line numbers).
- `modules/macross-dir/` — Language-specific macro definitions (Python, Bash, Blade).
- `keys/` — Keybinding definitions. `map-nvim.vim` is the main keymap file.
- `themes/` — Colorscheme (Nordic) and statusline (Airline) config.
- `snips/` — Custom UltiSnips snippets per filetype (php, vue, javascriptreact, scss, vim, all).
- `UltiSnips/` — UltiSnips plugin snippet directory.

### LSP & Completion

**CoC.nvim** is the sole LSP client. Language servers are configured via:
- `coc-settings.json` — Server settings, formatting rules, Emmet config, spell checking
- `modules/coc.vim` — CoC extensions list and completion keybindings
- Extensions include: intelephense (PHP/WordPress), tsserver, pyright, volar (Vue), eslint, tailwindcss, prettier

### Plugin Manager

**vim-plug** with auto-install. Plugins declared in `plugins.vim`, installed to `~/.config/nvim/autoload/plugged/`.

Commands: `:PlugInstall`, `:PlugUpdate`, `:PlugClean`

### Conventions

- **Leader key**: `<Space>`
- **Indentation**: 2 spaces (tabstop=2, shiftwidth=2, expandtab)
- **Folding**: indent-based, starts fully unfolded (foldlevelstart=99)
- **Relative line numbers**: on in normal mode, off in insert mode
- **Clipboard**: system clipboard via `unnamedplus`
- **Snippet engine**: UltiSnips (`<Tab>` to expand/jump, `<S-Tab>` to jump back)
- **Surround mappings**: Custom vim-surround bindings for code fences (e.g., `ts` for TypeScript, `py` for Python, `ph` for PHP)

### Primary Language Targets

PHP/WordPress/Laravel, Vue, TypeScript/JavaScript, Python, SCSS — reflected in CoC extensions, snippets, and custom macros.

## Working with This Config

- To add a new plugin: add the `Plug` line in `plugins.vim`, create a module file in `modules/`, source it from `init.vim`
- To add snippets: edit the appropriate file in `snips/` using UltiSnips syntax
- To add keybindings: prefer `keys/map-nvim.vim` for general mappings, or the relevant module file for plugin-specific mappings
- To reload config: `<leader>sn` sources init.vim, `<leader>sf` sources current file
- Lua config blocks are used inline (heredoc style `lua << EOF`) within .vim files for plugins that require Lua (bufferline, gitsigns, flash.nvim, yazi, colorizer)
