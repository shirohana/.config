# Handoff — repo cleanup

Status 2026-10-13: **both laptops run from `main`; Phases 2 and 3 open.** The work laptop
merged its `shoalter-env` branch on 2026-10-13 (nvim + zsh, work side winning on collisions,
Brewfile left as the work list) and links `~/.claude` the same way as home. Read [README.md](../README.md) first for the
layout; this file holds only what is still open.

## Decisions already made (do not re-litigate)

- **Claude config lives in this repo** at `claude/`, never `.claude/` (Claude Code would load it
  twice as project config). Private or work content lives in `shirohana/claude-private`.
- **Home and work keep two CLAUDE.md files.** Home is `claude/CLAUDE.md` with no `# Scope`
  section; the work delta is `claude/CLAUDE.work.md`. A single file with "work only" markers was
  rejected: the model reads a marked section anyway.
- **Gists are retired**, both carry a pointer entry. Copy-current-only, no history import.
- **No history rewrite.** The `--wip--` messages stay.
- **Deletes are a separate, confirmed session.** Branch, remote and file deletes wait for Hana's go.
- **Phase 2 (platform trim) is deferred**, Hana 2026-10-10: not blocking, do it later.

## Hand checks

- `~/.zshrc.local` is a 144-line leftover of the old `.zshrc`, sourced after the repo plugins
  since 2026-10-09. Its 20 differing git aliases overrode the repo ones until Hana commented them
  out on 2026-10-10. Still to do, Hana's call: cut the file to the two secret exports and move the
  5 local-only aliases (`gclone`, `gclone1`, `gcoom`, `gla`, `gwip`) and any wanted function into
  `git.plugin.zsh`.
- `~/.config/ghostty` is a plain directory, not a symlink; the repo copy has an extra `config` file.
  Compare before linking.
- `Brewfile` is the work laptop's list since the 2026-10-13 merge; the home additions (`awscli`,
  `stats`) and the casks work commented out (`ghostty`, `kitty`, `wezterm`, `tree-sitter-cli`,
  `asimov`) are untidied. Hana's call which machine's set is canonical, or whether to split.
- Work laptop: `~/.config/btop` and `~/.config/tmux` still point into the old clone
  `~/@shirohana/config-3`; `~/@shirohana/config-2`, `config-3`, `new-config` are stale clones.

## Phase 2 — Platform trim (deferred)

Measured 2026-10-09, still true 2026-10-10:

- nvim: the `Keys` table in `config/nvim/lua/shirohana/core/constants.lua` reads
  `USE_MACOS_OPT_KEYMAPS` from `shirohana.config`; every entry is `macos and '<glyph>' or '<M-x>'`.
  Collapse to the glyph, drop the flag. Nothing else branches on OS.
- alacritty: `config/alacritty/` (5 files), `cask "alacritty"` in Brewfile, broken `~/.config/alacritty`
  symlink. Remove all three.
- Gate: `nvim --headless +q` exits 0; `zsh -ic true` exits 0.

## Phase 3 — One trunk (delete session)

- `.config`: 12 `archive/*` tags exist locally. Delete the 9 local branches other than `main`, push
  the tags, delete the remote branches `backup-20250607 hana-wip original-main rebuild-config
  rebuild-workspace shoalter-env upgrade-nvim_0.10.0`. Public repo: confirm, then push.
- `claude-private`: `main` holds everything; the work laptop's local `shoalter` equals `main`.
  Delete remote `shoalter` and `worktree-slim-code-review-base` after the push.

## Not pushed

`.config` main is ahead of origin (Phase 1 plus the Claude package and README).
`claude-private` main is ahead of origin. Pushing is Hana's.

## Secrets

`claude/settings.json` was grepped for token, key, secret, password before commit: clean. Re-run
that grep before any later settings commit; anything sensitive goes to a gitignored local override.

## Next step

Phase 3 in a confirmed delete session.
Delete this file once Phases 2 and 3 close; the README already carries the layout.
