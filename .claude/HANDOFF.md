# Handoff — repo cleanup & Claude config home

Status 2026-10-09: **Phase 1 landed on `main`; Phases 2–5 deferred to the next session.**
Read top-to-bottom before touching the repo. `main` is the only branch you need; checkout
and work there.

## Goal

One trunk, clean tree, a real README, and this repo as the single source of truth for the
Claude setup that today lives in `~/.claude` and in the gist "Hana's Claude Setup".

## Decisions already made (do not re-litigate)

- **Claude config lives in THIS repo.** Repo is public but not a showcase.
- **No history rewrite.** `.git` is small, no secrets in history (re-checked 2026-10-09,
  see Secrets below). The `--wip--` messages stay.
- **Deletes are a separate, confirmed session.** Branch deletes, remote deletes, and file
  removals all wait for Hana's explicit go; this doc lists them so nothing is forgotten.

## What landed (2026-10-09)

- The 27 dirty paths are committed on `main` in four commits (nvim, zsh, Brewfile+lazygit+yazi,
  log removal + `*.log` ignored). `main` was fast-forwarded from `rebuild-workspace`; the two
  are the same commit. **Not pushed.**
- Every branch tip is archive-tagged locally: `git tag -l 'archive/*'` lists 12. Tags are
  not pushed. They make the later branch deletes zero-risk.
- `~/.zshrc.local` is now sourced by `.zshrc` and holds the HuggingFace token that was
  sitting in the `.zshrc` diff (never committed). Side effect: that file's older
  `GITHUB_AUTH` export is now live in every shell. Hand check: confirm that is wanted.

## Open in the tree

- `todo-comments-nvim.md` (untracked): an upstream bug report for folke/todo-comments.nvim.
  Not config. Decide: file it as an issue and remove, or move to notes.
- `~/.config/alacritty` symlink is broken (points to `<repo>/alacritty`). Moot once alacritty
  is removed (Phase 2).
- `~/.config/ghostty` is a plain directory, not a symlink; the repo copy has an extra `config`
  file the live dir lacks. Compare before linking.

## Phase 2 — Platform trim (Hana's call, 2026-10-09: do it)

Hana no longer needs Linux/Windows support and no longer uses alacritty or wezterm.
Measured 2026-10-09:

- **nvim** OS branching is one table: `Keys` in `lua/shirohana/core/constants.lua`, every
  entry `macos and '<glyph>' or '<M-x>'`. Collapse to the macOS glyph and drop the `macos`
  constant. Nothing else in nvim or zsh branches on OS.
- **tmux**: not in the repo (removed 2024). Only an empty `~/.tmux.conf` remains. Nothing to do.
- **wezterm**: never tracked. Nothing to do.
- **alacritty**: `config/alacritty/` (5 files), `cask "alacritty"` in Brewfile, broken symlink.
  Remove all three.
- Gate: `nvim --headless +q` exits 0; `zsh -ic true` exits 0.

## Phase 3 — One trunk (delete session)

Tags exist. Remaining: delete all local branches except `main`; push tags; delete remote
branches `backup-20250607 hana-wip original-main rebuild-config rebuild-workspace
shoalter-env upgrade-nvim_0.10.0`. Remote deletes are outward-facing on a public repo:
**confirm with Hana first, then push.**

## Phase 4 — Claude package (three decisions pending, Hana defers to next session)

Measured 2026-10-09. The gist `d2735eee7707340368f8f796e94d8114` (public, 44 revisions,
flattened filenames, CHANGELOG as a manual sync log) and `~/.claude` have drifted BOTH ways:

| Side | Has that the other lacks |
|---|---|
| Gist only (work laptop) | PIN THE UPSTREAM (work-only rule), A DEFERRED DECISION, 3 `coordinate` rules |
| Home only | PLAN RE-COUNTS, REMOTE CONTROL, MEMORY AT EVERY CHECKPOINT, BRIEF NAMES FOLDERS, SEARCH FROM REPO; `fold-commits` conflicts paragraph |

So the migration is a union merge. Produce the merged `CLAUDE.md`, `coordinate/SKILL.md` and
`fold-commits/SKILL.md` as a diff for Hana to approve before committing. Keep the gist's
`# Scope` section (per-machine drop list).

Decisions Hana must make first (recommendation first):

1. **Location**: `config/claude/` (matches `config/nvim`) — or top-level `claude/`.
2. **Gist history**: copy current content only (flattened names make history useless as a
   tree; CHANGELOG carries the narrative) — or `git subtree add` the 44 revisions.
3. **settings.json**: symlink the whole file so both machines share one — or track only the
   hooks fragment as the gist did (`settings.hooks.json`).

Layout once decided: `CLAUDE.md`, `settings.json`, `statusline-command.sh`, `skills/<name>/`
as real directories, `plugins/installed_plugins.json` + `known_marketplaces.json`.
Symlink **per skill** into `~/.claude/skills/` — that directory also holds Claude Code's own
`synced/` state and the external `write-doc` link, so never link the whole dir.
Delete the repo's `.claude/skills/coding-principles` (drifted duplicate of the home skill).
Keep `.claude/CLAUDE.md` and `.claude/skills/commit-style`: project-scoped, legitimately differ.
Gate: a fresh `claude` session shows the saves banner and lists the skills.

## Phase 5 — Retire the gist, write the entry point

Replace the gist README with a pointer to this repo; leave it as a read-only archive.
Rewrite `README.md` (currently two lines) as the cold-start doc: directory map, symlink table
(source → target), tracked vs runtime, new-machine bootstrap. Then delete this file once the
README carries what it needs.

## Secrets

Re-checked 2026-10-09: `git log --all -S'HF_TOKEN'` empty; the working-tree diff held one
token (`.zshrc`, now in `~/.zshrc.local`). Before committing any `settings.json`, grep it for
keys; anything sensitive goes to a gitignored local override.

## Install mechanism (existing)

Hand-made per-directory symlinks, no stow, no Makefile, no CI:

    ~/.zshrc           -> <repo>/config/zsh/.zshrc
    ~/.config/zsh      -> <repo>/config/zsh/zsh
    ~/.config/nvim     -> <repo>/config/nvim
    ~/.config/yazi     -> <repo>/config/yazi
    ~/.config/lazygit  -> <repo>/config/lazygit

## Next step

Phase 2 (platform trim) needs no decision and is safe to start. Phase 4 starts with the
three decisions above; ask Hana, then produce the merge diff.
