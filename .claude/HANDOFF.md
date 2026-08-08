# Handoff — repo cleanup & Claude config home

Status: **planned, not started.** Nothing has been executed. Working tree still dirty.
Written 2026-08-09. Read this top-to-bottom before touching the repo.

## Goal

Turn this repo into something an agent can pick up cold: one trunk, clean tree,
a real README, and a single source of truth for the Claude setup.

## Decisions already made (do not re-litigate)

- **Claude config lives in THIS repo.** Not a separate one. Repo is public but not a
  showcase; Claude setup is already entangled with the shell config
  (`config/zsh/zsh/plugins/claude.plugin.zsh` is untracked in the tree right now).
- **No history rewrite.** Measured: `.git` is 836K, 129 commits since 2018, largest
  blob ever is `.p10k.zsh` at 90KB, no secrets (grepped every path ever committed for
  key/token/credential/pem/env patterns, and the current tree for assignment-shaped
  secrets — clean). The only junk is `profile.log` / `profile2.log`, ~20KB, already
  deleted in the working tree. Rewriting 129 commits to prettify `--wip--` messages
  would break every clone and the archive tags below, for cosmetics. Don't.

## Measured branch state

`main` is already the real trunk. Nothing needs merging — branches need deleting.
Tip-to-tip diff `git diff main..<branch>`:

| Branch | SHA | vs `main` |
|---|---|---|
| `backup-20250607` | cfc81c8 | fully merged, zero unique content |
| `rebuild-config` | 24cea63 | fully merged, zero unique content |
| `upgrade-nvim_0.10.0` | 3467ea6 | fully merged, zero unique content |
| `origin/original-main` | 3a84cc0 | fully merged, zero unique content |
| `_a01` | 60efc38 | 4,477 lines behind main; 309 main lacks |
| `_a02` | 5164b0b | 4,422 behind; 318 main lacks |
| `_a03` | 7930af3 | 4,062 behind; 200 main lacks |
| `_a04` | 0ab7f40 | 3,915 behind; 163 main lacks |
| `_backup` | 9ba0a9d | 8,074 behind; 91 main lacks |
| `origin/hana-wip` | c3bd030 | 369 lines main lacks |
| `origin/shoalter-env` | 548e2da | 1,243 lines main lacks — work-laptop env, separate purpose |
| `rebuild-workspace` | ff0266d | **1 line** + the 27 dirty files (current branch) |

## Two findings that shape the work

1. **`~/.claude/plugins` is not user content.** It is Claude Code's plugin-manager
   state — `cache/`, `repos/`, `marketplaces/`, `.last_inuse_sweep`. Symlinking it into
   the repo fights the tool every session. Track only `installed_plugins.json` and
   `known_marketplaces.json` (the declaration of what's installed).
2. **Existing duplication.** `coding-principles/SKILL.md` and `commit-style/SKILL.md`
   are byte-identical in both `~/.claude/skills/` and this repo's `.claude/skills/`.
   Two sources of truth. Dedupe via symlink (below).
   `~/.claude/skills/goal-prompt` exists only in home, not in the repo.

## Plan

### Phase 1 — Archive, then flatten to one trunk
Tag every branch tip `archive/<name>` FIRST. Tags keep commits permanently reachable,
making every delete zero-risk and reversible — which is why `shoalter-env` and
`hana-wip` need no decision. Then delete all local + remote branches except `main`.
Deleting remote branches is outward-facing: **confirm with Hana before pushing deletes.**

### Phase 2 — Land the working tree
Commit the 27 dirty files onto `main` in coherent chunks (nvim/lsp, zsh plugins, yazi
theme, Brewfile), per the short-commit rule. Commit the `profile*.log` deletions and add
`*.log` to `.gitignore`. Fold in `rebuild-workspace`'s one-line delta.

### Phase 3 — `claude/` package, deduplicated
Create `claude/` at repo top level: `skills/` (all three incl. `goal-prompt`),
`CLAUDE.md`, `settings.json`, `hooks/`, and the two plugin manifests. Delete the
duplicate copies under `.claude/skills/` and symlink `~/.claude/skills` → `claude/skills`,
matching the existing style (`~/.config/nvim` → `repo/config/nvim`).
Keep `.claude/CLAUDE.md` — it is project-scoped and legitimately differs from the global
one (it has `SHORT COMMITS`; the global has 7 other principles).
**Check `settings.json` for API keys before committing it**; anything sensitive goes in a
gitignored local override.

### Phase 4 — Handoff entry point
`README.md` is currently two lines (`.config` / `=======`). Replace with the cold-start
doc: what the repo is, directory map, symlink table (source → target), tracked vs
runtime, new-machine bootstrap. Add a root `CLAUDE.md` with conventions: trunk-based on
`main`, no long-lived branches, short commits, where Claude config lives.

## Install mechanism (existing)

Hand-made per-directory symlinks, no stow, no Makefile, no CI:

    ~/.config/nvim  -> <repo>/config/nvim
    ~/.config/yazi  -> <repo>/config/yazi
    ~/.config/zsh   -> <repo>/config/zsh/zsh

## Next step

Phase 1, after confirming the remote-branch deletion with Hana.
