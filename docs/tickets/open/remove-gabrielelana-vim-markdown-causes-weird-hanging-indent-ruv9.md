---
id: dl-ruv9
title: Remove gabrielelana/vim-markdown (causes weird hanging indent in Markdown)
kind: bug
created: 2026-10-15
created_by: external:aide
repos: [dotfiles-local]
changes: []
specs: []
blocked_by: []
related: []
---

## The ask

The human, 2026-10-15 ~5:50 PM ET (to aide, verbatim): "this Markdown plugin that's causing the weird hanging indent. I think we can just remove it" ... "Yeah, let's fix that markdown thing immediately and then evaluate."

The plugin: `Plug 'gabrielelana/vim-markdown'` in vimrc.bundles.local (under the "2023-12-02" block, next to psf/black). Remove that line, leaving a dated why-comment per CLAUDE.md. Keep bullets.vim and the markdown-table mapping in vimrc.local.

Done = the Plug line is gone, a dated comment says why, and opening a .md file in vim no longer gives the hanging indent (vim -c PlugClean optional; the human runs :PlugClean).

Later (not this ticket): the human will email the plugin list they use at work; we will compare all plugins against it then.
