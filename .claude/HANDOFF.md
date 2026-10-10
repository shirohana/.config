# Handoff — repo cleanup

Status 2026-10-10: **Claude package landed and linked; two merge diffs await Hana's approval;
Phases 2 and 3 open.** `main` is the only branch. Read [README.md](../README.md) first for the
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

## Awaiting Hana's approval (uncommitted in the working trees)

- `.config`: `claude/CLAUDE.md` gains A DEFERRED DECISION after FAN OUT; `claude/skills/coordinate/SKILL.md`
  gains VERIFY THE REPORT, PREPARE THE WORKTREE, A PORT NAMES ITS OVERRIDES before A PATTERN FLAGGED
  TWICE; `claude/CLAUDE.work.md` is new with PIN THE UPSTREAM. `fold-commits` needed nothing.
  MEMORY IS REWRITTEN AT EVERY CHECKPOINT stays in CLAUDE.md only; the gist had moved it into the
  coordinate skill, and keeping it global was chosen so it applies outside fan-out runs too.
- `claude-private`: `english/patterns.md` gains the 11 rows the gist had and home lacked, appended
  at the table end. Both sides had edited independently since 2026-09-17.

Approve: `git commit` in each repo. Reject: `git checkout -- <file>` and say which rule to drop.

## Hand checks

- `~/.zshrc.local` is sourced since 2026-10-09, after the repo plugins, and it is a 144-line
  leftover of the old `.zshrc`: two secret exports plus 59 git aliases and 6 functions. 52 of
  the aliases also exist in the repo plugins and 20 differ, so the local copy silently wins
  (`g` is `git status` again, `gms` lists merged branches instead of `merge --squash`, `gcom`
  checks out local main instead of `origin/main`). Proposal: cut the file down to the two
  exports; move the 5 local-only aliases and any wanted function into the repo's `git.plugin.zsh`.
  Hana's call, the file is untracked.
- `~/.config/ghostty` is a plain directory, not a symlink; the repo copy has an extra `config` file.
  Compare before linking.
- `todo-comments-nvim.md` (untracked) is an upstream bug report, not config. File it or move it.

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
- `claude-private`: `main` is fast-forwarded to the old `shoalter` content and is 54 ahead of
  origin, unpushed. Delete remote `shoalter` and `worktree-slim-code-review-base` after the push.

## Not pushed

`.config` main is ahead of origin (Phase 1 plus the Claude package and README).
`claude-private` main is ahead of origin. Pushing is Hana's.

## Secrets

`claude/settings.json` was grepped for token, key, secret, password before commit: clean. Re-run
that grep before any later settings commit; anything sensitive goes to a gitignored local override.

## Next step

Hana approves or rejects the two merge diffs above. Then Phase 3 in a confirmed delete session.
Delete this file once Phases 2 and 3 close; the README already carries the layout.
