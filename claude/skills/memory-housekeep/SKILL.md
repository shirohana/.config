---
name: memory-housekeep
description: Audit and prune the project's memory files — verify every memory against ground truth, consolidate all status into one backlog, delete rot, rebuild the index. Use when asked to clean up, audit, or housekeep memory, when a track closes (ticket merged, worktree gone) and its backlog section should go, when memories are found contradicting each other or the repo, or when a safe-stop line reported `housekeep due`.
---

# Memory Housekeeping

Converge this project's memory to the target state: **exactly one backlog memory holds all status; every other memory holds knowledge only; MEMORY.md matches the files one-to-one and stays a pointer list.**

Memories are hearsay — a past agent's paraphrase frozen at write time. Never keep, act on, or delete one on its own word; verify against ground truth first (repo code, git log, specs/tracker). A stale "NEXT" doesn't read as stale — it reads as an instruction — so unverified status is the most dangerous content in the store.

## Procedure

1. **Inventory.** Locate the memory directory (its path is in your system prompt). Read MEMORY.md and every memory file. Identify the backlog memory; if none exists, plan to create one (`backlog.md`).
2. **Verify.** For each claim, check ground truth: does the code/config still say this? Does git log show the work already done? Does the spec/tracker already own this status? Record the evidence.
3. **Disposition.** Assign every file exactly one verdict:
   - **KEEP** — true knowledge: traps, verified facts, decisions with their reasons.
   - **REWRITE** — true but carries status ("NEXT", pending, deferred, done): move the status into the backlog, keep only the knowledge; or knowledge that's partly stale: rewrite to current truth.
   - **DELETE** — wrong, superseded, or derivable from the repo/git history/CLAUDE.md.
4. **Propose before editing.** Show the disposition table — file, verdict, one-line evidence — and wait for the go. Deletion is destructive; the table is the review gate.
5. **Apply.**
   - Consolidate status into the single backlog: which changes exist, their priority, what gates them. Prune entries for closed work. Do NOT restate per-task tick-state a tracker already owns (e.g. OpenSpec tasks.md).
   - Rewrite/delete per the table. When stripping status, never strip the why — rationale and traps are the value.
   - Fix `[[links]]` pointing at deleted or renamed files.
   - Stamp the backlog's frontmatter with `housekept: YYYY-MM-DD` so the next reader can tell how stale the status is.
   - Rebuild MEMORY.md per **Index shape** below: backlog pointer first, then one line per surviving file, nothing else.

## Index shape

MEMORY.md is loaded whole into every session, unconditionally, and the harness silently truncates it past its limit — entries past the cut never reach the agent, and nobody is told. So the index is a pointer list, never a second copy of the content:

- One line per memory file: `- [Title](file.md) — hook`, under 250 chars (the same cap as a `/save` handoff — one convention). The hook says when to open the file, not what it says.
- The backlog line is exactly `- [Backlog](backlog.md) — N open; top: <one item>`. Ticket state, MR numbers, review notes belong in backlog.md; no other session needs them, and every session pays for them.
- Everything else goes in the file. Files have no cap; the index does.

`hooks/memory-index-guard.sh` (PostToolUse on Write/Edit/Bash) enforces the caps at write time and hands the reason back to the agent; the numeric limits live there, nowhere else. When it fires, shorten the line and move the content into the file — do not argue with it.

## Closing a track

Invoked with a ticket or track name (`/memory-housekeep MS-1234`), run the procedure on that backlog section only: verify it closed against ground truth (merged, worktree removed, tracker done), move any trap or decision worth keeping into a topic memory, delete the section, and fix the backlog line in MEMORY.md. This is the cheap, per-close prune that keeps the full run rare; a backlog that is mostly closed sections means the per-close prune was skipped.

## Done criteria

- No file outside the backlog contains NEXT / pending / deferred / in-progress.
- Every backlog entry was verified open against ground truth this run.
- MEMORY.md lists exactly the files that exist, backlog first.
- Every kept memory would still be true if read cold a month from now.

- MEMORY.md passes `hooks/memory-index-guard.sh` (run it by hand if in doubt: `echo '{"tool_name":"Write","tool_input":{"file_path":"<path>/MEMORY.md"}}' | bash hooks/memory-index-guard.sh`).

Report: counts per verdict, what the backlog now says is open, and anything you couldn't verify (flag it, don't guess).

## Porting (macOS)

1. Copy `skills/memory-housekeep/` to `~/.claude/skills/memory-housekeep/`, `chmod +x hooks/memory-index-guard.sh`. Needs `jq`.
2. Merge into `~/.claude/settings.json` `hooks` (keep existing entries):

```json
{ "hooks": { "PostToolUse": [
  { "matcher": "Write|Edit|MultiEdit|Bash", "hooks": [ { "type": "command", "command": "bash ~/.claude/skills/memory-housekeep/hooks/memory-index-guard.sh", "timeout": 10, "statusMessage": "Checking MEMORY.md index" } ] }
] } }
```
3. Restart sessions. Existing oversized indexes still need one `/memory-housekeep` run; the hook only stops regrowth.
