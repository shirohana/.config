---
name: save
description: Save an explicit handoff for this session — end the final reply with recap(path) / detail(path) lines that the saves Stop hook harvests into ~/.claude/saves/. Use when the user invokes /save, alone or alongside other work in the same message. Also covers reading and retiring rows with the `saves` CLI.
---

# /save — explicit session handoff

`/save` may arrive alongside other instructions ("do X and also /save").
Finish ALL other requested work first. Then end the reply with the recap
block — it must be in the turn's FINAL assistant message, because the Stop
hook harvests only that message.

At the very end of the reply:

```
recap(<folder>): <purpose — what this folder is doing, ≤60 chars>
detail(<folder>): <handoff for a cold agent, ≤250 chars>
<safe-stop line per CLAUDE.md>
```

## Two tiers, two readers

- `recap` is what EVERY future session sees, for every folder, in one line:
  enough to know the folder exists and what it is for, e.g.
  `MR !2537 open, collapsed-brand sticky fix, awaiting Hana`. Write it as
  state, not activity. Start-of-line `recap(` is the trigger — never put an
  example `recap(` line at the start of a line in prose, the hook will save it.
- `detail` is read only when a session is in the same repo (its worktrees
  expand automatically) or asks for it (`saves show <folder>`). This is the
  full handoff: what landed, what's next, what gates. Optional, but a folder
  with open work should have one.

## Rules

- One `recap()` (plus optional `detail()`) per folder this session touched —
  the launch repo, every worktree written to (including by subagents), any
  non-git folder changed. Nothing touched anywhere → one recap for the launch
  folder describing its current state.
- `<folder>` = the repo/worktree ROOT or the plain folder; `~` allowed. Never
  an inner subdirectory (the hook normalizes to `git rev-parse --show-toplevel`
  anyway, but don't rely on it for non-git paths). Use the same spelling in
  the `recap()` and `detail()` of one folder — that is how they pair.
- Don't restate commit subjects or counts; the hook prepends `+N commits ·`
  to detail itself from git.
- The safe-stop line follows the recap lines; its verdict fills the row's
  safe-flag. Keep it a separate line — never merge it into a recap().
- Each save OVERWRITES that folder's previous row (memory is state, not
  log): write current truth, not a delta since the last save.

## Reading and retiring — the `saves` CLI

`~/.claude/skills/save/bin/saves` (also on PATH as `saves`) is the one
reader/writer; the hooks call it too.

```
saves list                 # table: #, age, folder [gone|branch now X], branch, safe, purpose
saves inject [<dir>]       # exactly what a session launched in <dir> gets injected
saves show <ref>           # every field of one row
saves set <ref> --purpose "…" [--detail "…"]   # edit a row, saved-at kept
saves retire <ref>… | gone # delete rows; `gone` = every row whose folder is missing
saves add <folder> <purpose> [detail] [--flag safe|unsafe]   # manual row (hook / pipelines)
```

`<ref>` = row # from `list`, a path, or a unique substring of the folder.

Only `recap`/`detail` lines are harvested from the reply; the agent never
runs `saves add` (that is the hook's write path and a pipeline entry point).
When asked to retire or reword a save, run `saves retire` / `saves set`
directly and report what it printed. A `[gone]` row is a
trail of a removed worktree whose commits were picked elsewhere by hand; it
stays until retired on purpose, never by age.
