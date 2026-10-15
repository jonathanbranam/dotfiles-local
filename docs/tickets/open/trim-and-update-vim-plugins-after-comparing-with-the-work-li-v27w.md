---
id: dl-v27w
title: Trim and update vim plugins after comparing with the work list
kind: chore
created: 2026-10-15
created_by: external:aide
repos: [dotfiles-local]
changes: []
specs: []
blocked_by: []
related: []
---

## The ask

The human, 2026-10-15 (to aide, verbatim excerpts, after the aide compared vimrc.bundles.local with their work plugin list, mail m-0068):
- "We should use the new home of the bullet stat vim. That sounds good. Get unplugged all the Ruby and Elixir stuff."
- "Dadbot, I think, is for connecting to databases from Vim, and I don't do that ever, so it can be removed."
- "I don't know what that autocomplete stuff is. It could be removed."
- "Color schemes: I just use the one I have defined."
- "Scala: I don't use that, and I don't know what the black plugin does, but I've stopped using black and use rough anyway."

Changes, all in vimrc.bundles.local, each with a dated why-comment (CLAUDE.md):
1. `dkarter/bullets.vim` -> `bullets-vim/bullets.vim` (the project moved).
2. Add `UnPlug` for thoughtbot's Ruby/Elixir plugins: vim-elixir, vim-rails, vim-rake, vim-bundler, vim-ruby (short names, as for vim-mkdir).
3. Remove `tpope/vim-dadbod`.
4. Remove the "Scala plugins" block: derekwyatt/vim-scala, Shougo/deoplete.nvim, roxma/nvim-yarp, roxma/vim-hug-neovim-rpc.
5. Remove `psf/black` (the human uses ruff).
6. Themes: remove all except `catppuccin/vim` (vimrc.local g:UpdateColorScheme uses catppuccin-latte for light; dark is the built-in habamax). Removes gruvbox, awesome-vim-colorschemes, vscode.nvim, tokyonight-vim, papercolor-theme, vim-atom-dark, sonokai, vim-late_evening, both onehalf lines, night_owl_light. Also drop the commented `onehalfdark` line in vimrc.local only if it is dead. Leave seoul256 (goyo/limelight setup).

Keep: junegunn/fzf (Ctrl-P), vader.vim (the human uses it), benizi/vim-automkdir.
Not adding (human declined or undecided): vim-bbye, vim-highlighter, vim-plugin-AnsiEsc, vim-gnupg.

Done = vim starts with no errors (`vim +qa` clean, `:PlugStatus` shows no removed plugin), colours unchanged in dark mode. The human runs :PlugClean afterwards.
