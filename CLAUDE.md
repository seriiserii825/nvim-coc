# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Neovim configuration using **VimScript** as the primary language with embedded Lua blocks for newer plugins. Uses **vim-plug** for plugin management and **CoC.nvim** as the LSP/completion engine.

## Architecture

### Bootstrap Order (init.vim)

```
plugins.vim → settings.vim → functions.vim → modules/jsx-format.vim → modules/functions/* → keys/map-nvim.vim → modules/* → themes/*
```

All files are sourced via absolute paths (`$HOME/.config/nvim/...`). This is a dotfiles repo symlinked to `~/.config/nvim`.

**Note**: Writing `plugins.vim` auto-triggers `:PlugClean | :PlugInstall` via an autocmd.

### Key Directories

- `modules/` — One file per plugin/feature config (50+ files). Each module is self-contained with its own mappings and settings.
- `modules/functions/` — Custom VimScript functions for line manipulation (delete, copy, duplicate, move, yank, visual select by relative line numbers).
- `modules/macross-dir/` — Language-specific macro definitions. Only `python-macros.vim` is active; bash/blade variants are commented out in init.vim.
- `after/ftplugin/` — Filetype-specific overrides (e.g., `php.vim`).
- `keys/` — Keybinding definitions. `map-nvim.vim` is the main keymap file.
- `themes/` — Colorscheme (Nordic) and statusline (Airline) config.
- `snips/` — Custom UltiSnips snippets per filetype (php, vue, javascriptreact, scss, vim, all).
- `UltiSnips/` — UltiSnips plugin snippet directory.

### LSP & Completion

**CoC.nvim** is the sole LSP client. Language servers are configured via:
- `coc-settings.json` — Server settings, formatting rules, Emmet config, spell checking
- `modules/coc.vim` — CoC extensions list and completion keybindings
- Extensions include: intelephense (PHP/WordPress), tsserver, pyright, volar (Vue), eslint, tailwindcss, prettier

Key CoC mappings (all in `modules/coc.vim`):
- `K` — hover docs, `gd` — definition, `gy` — type definition, `gr` — references
- `[g` / `]g` — next/prev diagnostic, `<leader>;` — fix current diagnostic
- `<M-l>` — format document, `<leader>cp` — code action at cursor
- `<leader>ia` — fix all imports (add missing + remove unused + organize), `<leader>io/im/id` — individual import actions
- `<C-j>`/`<C-k>` in insert — navigate completion popup

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
- **Surround mappings**: Direct (no leader) mappings wrap N lines in fenced code blocks: `ts` (TypeScript), `py` (Python), `ph`/`mh` (HTML/PHP), `mb` (Bash), `mj` (JSON), `my` (YAML), `ms` (SQL), `mg` (GraphQL), `mm` (Vim), `mv` (Vue), `mz` (Prisma). Accepts a count prefix to wrap N lines.
- **File path copy**: `<leader>yr` (relative), `<leader>ya` (absolute), `<leader>yn` (name), `<leader>yd` (directory) — all yank to system clipboard

### Primary Language Targets

PHP/WordPress/Laravel, Vue, TypeScript/JavaScript, Python, SCSS — reflected in CoC extensions, snippets, and custom macros.

## Working with This Config

- To add a new plugin: add the `Plug` line in `plugins.vim` (saving the file auto-runs PlugClean + PlugInstall), create a module file in `modules/`, source it from `init.vim`
- To add snippets: edit the appropriate file in `snips/` using UltiSnips syntax
- To add keybindings: prefer `keys/map-nvim.vim` for general mappings, or the relevant module file for plugin-specific mappings
- To reload config: `<leader>sn` sources init.vim, `<leader>sf` sources current file
- Lua config blocks are used inline (heredoc style `lua << EOF`) within .vim files for plugins that require Lua (bufferline, gitsigns, flash.nvim, yazi, colorizer)
- FZF custom commands: `:Files` (file picker with preview), `:Rg` (ripgrep), `:RG` (interactive ripgrep with live reload), `:GGrep` (git grep)

## Troubleshooting: "Works on one machine, not another"

This repo only carries **declarative config** (`init.vim`, `modules/*.vim`, `coc-settings.json`). It does NOT carry, and `git pull` alone will NOT sync:
- Installed CoC extensions (live in `~/.config/coc/extensions/`, not this repo)
- Installed vim-plug plugins (live in `~/.config/nvim/autoload/plugged/`)
- Per-project `node_modules` (e.g. `@angular/language-service`, `typescript`) that language servers like coc-angular/coc-tsserver/volar delegate to
- Node.js version on the machine

When a CoC/LSP feature (e.g. coc-angular) works on one machine but not another on the same commit, check in this order:
1. `:source $MYVIMRC` or restart nvim after pulling — confirms the new config is actually loaded.
2. `:CocList extensions` — is the extension installed and active (no ✗/error)? If missing, run `:CocInstall <ext>` or `:CocUpdate` (declaring it in `g:coc_global_extensions` doesn't force-install on an existing CoC setup).
3. `:CocInfo` and `:CocCommand workspace.showOutput` (pick the relevant language server channel) — look for startup errors.
4. For TS/Angular/Vue: does the *project itself* (not this dotfiles repo) have `npm install` run, with the language server package present in its local `node_modules`?
5. `node -v` — compare Node version across machines; LSP extensions often require a recent minimum.
6. `:set filetype?` on the affected buffer — confirm filetype-detection autocmds (e.g. the `htmlangular` → `html.htmlangular` one in `modules/coc.vim`) actually fired as expected.
7. If step 3's Angular Language Service output channel shows `@angular/core could not be found for project ... ('@angular/core' could not be found)` or `No config file for <template>.html` even though `@angular/core` is genuinely installed — see the dedicated section below, this is a version-skew bug in coc-angular itself, not a config problem.

### coc-angular: template completion silently fails on modern Angular projects (17.0.2 vs Angular 18+/21)

> Short setup checklist (global patch + per-project `.vim/coc-settings.json` + verification): see `ANGULAR.md`.

**Symptom**: `:CocInfo` shows the Angular language server reaches `running` state, but member-access completion in templates (`item.` inside `{{ }}` / property bindings) never shows Angular results — only unrelated sources (UltiSnips/html snippets) pop up. `:CocCommand workspace.showOutput` → `Angular Language Service` repeats:
```
Disabling language service for .../tsconfig.app.json because project is not an Angular project ('@angular/core' could not be found).
No config file for .../some.component.html
```

**Root cause**: `coc-angular` (npm latest is `17.0.2`, matches upstream `vscode-ng-language-service` v17, not updated since ~Nov 2023) bundles its own **pinned** copies of `@angular/language-service` and `@angular/language-server` under `~/.config/coc/extensions/node_modules/coc-angular/node_modules/@angular/`. It ignores the project's own `@angular/language-service` entirely (by design, per the extension's README).

`@angular/language-server@17.0.2`'s project-detection heuristic (`isExternalAngularCore` in its compiled `index.js`) is a hardcoded suffix check:
```js
function isExternalAngularCore(path) {
  return path.endsWith("@angular/core/core.d.ts") || path.endsWith("@angular/core/index.d.ts");
}
```
Angular 18+ ships `@angular/core`'s type entry at `@angular/core/types/core.d.ts` (chunked exports layout) — that path never matches the old suffix check, so the server concludes "this isn't an Angular project" and disables itself for every `.html` template, even though the project is completely valid (`tsc` compiles it fine).

Separately, the *bundled* `typescript` inside `coc-angular` is `5.2.2`, which can't parse `"module": "preserve"` in `tsconfig.json` (a TS 5.4+ feature that Angular CLI now scaffolds by default) — this must also be overridden or the root `tsconfig.json` fails to parse before you even get to the `@angular/core` check.

**Fix** (redo after every `:CocUpdate coc-angular`, since that reinstalls its `node_modules` and wipes this):
```bash
cd ~/.config/coc/extensions/node_modules/coc-angular/node_modules
npm install @angular/language-server@latest --legacy-peer-deps
```
This pulls a matching, non-broken `@angular/language-service` as its dependency too (fixes the regex: newer `isExternalAngularCore` is `/@angular\/core\/.+\.d\.ts$/`, no longer suffix-pinned). `--legacy-peer-deps` is required because `coc-angular`'s own `package.json` pins a peer on `coc.nvim` that conflicts with unrelated `@types/node` versions — harmless to ignore here since this is a vendored extension dir, not a real workspace.

Also add a per-project `coc-settings.json` (NOT the global one in this repo — this is project-specific) so coc-angular's tsserver uses the *project's own* modern TypeScript instead of the bundled 5.2.2:
```jsonc
// <angular-project>/.vim/coc-settings.json
{
  "typescript.tsdk": "/absolute/path/to/<angular-project>/node_modules/typescript/lib"
}
```
Must be an **absolute** path — a relative one (`node_modules/typescript/lib`) is not resolved against the workspace root reliably.

**Verify**: `:CocRestart`, reopen the `.html` file, `:CocCommand workspace.showOutput` → Angular Language Service should show `Using @angular/language-service v2x.x.x` with no `could not be found` / `No config file` errors, and `item.` inside a template should list the interpolated object's real members.
