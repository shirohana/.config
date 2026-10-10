# save — explicit handoff journal

`/save` + these hooks + the `saves` CLI are one unit; none is useful alone.

`~/.claude/saves/` holds one file per folder — the latest handoff explicitly
saved for it. Nothing is written passively: a row exists because a session
ran `/save` and chose to hand that folder off (or someone ran `saves add`).

File name: the folder path with every non-alphanumeric character replaced by
`-` (close to the `~/.claude/projects/` slug scheme, so save ↔ transcript-dir
mapping is eyeball-able). Content: one TSV line:

```
saved-at <TAB> folder <TAB> branch <TAB> safe-flag <TAB> repo <TAB> purpose <TAB> detail
```

- `purpose` (≤80) is the tier every session sees; `detail` (≤300) is read
  only by sessions in the same repo or on request. Two tiers because 20+
  rows of full handoffs cost ~2k tokens per session start, but a folder still
  has to be *known* to exist even when idle for a month.
- `repo` is the git common dir. Worktrees of one repo share it, and it
  survives the worktree folder being deleted — that is what lets a `[gone]`
  worktree's detail still expand for its siblings.
- Rows written before the purpose column (5 fields) are read as
  purpose="" and render the head of detail until the next save rewrites them.

## Pieces

- `bin/saves` — the one reader/writer: `list [--brief] [--limit N]
  [--expand <dir>]`, `inject [<dir>]`, `show <ref>`, `add`, `set <ref>`,
  `retire <ref>… | gone`. Both hooks call it, so slug, normalization,
  markers, the injected header and rendering exist once. `saves inject
  <dir>` prints byte-for-byte what a session launched in `<dir>` receives —
  the way to judge what to reword (`saves set`) or retire. `SAVES_DIR`
  overrides the state dir (used for testing against a copy).
- `stop.sh` (Stop hook) harvests `recap(<path>): <purpose>` and the matching
  `detail(<path>): <text>` lines from the turn's final assistant message —
  emitted by the `/save` skill. No recap lines → it writes nothing. Per
  folder it prepends `+N commits ·` to detail when that worktree's HEAD moved
  since session start, takes the safe-flag from the safe-stop line's verdict
  (`safe` / `unsafe` / `?`), and calls `saves add`. Retire is deliberately
  not harvested: it is a direct `saves retire`, by agent or human.
- `session-start.sh` (SessionStart hook) snapshots every worktree HEAD of the
  launch repo into `saves/.heads/<session-id>` (the `+N` baseline) and injects
  `saves inject <cwd>` verbatim: header + newest 15 rows, purpose only, with
  `↳ detail` under rows that belong to the launch repo (same common dir, so
  sibling worktrees — the co-work case).
- Markers on the folder column: `[gone]` = folder missing (worktree removed,
  commits picked by hand; kept until retired, never aged out — an idle repo
  must stay known); `[branch now X]` = live folder reused for another
  branch (the `mma-N` slots), so the row is history.
- Subagents never write: Claude Code fires `Stop` only for the main agent.
- Concurrency: two sessions saving the same folder race benignly — last write
  wins, which is the semantic anyway.

## Maintenance

`saves list` to see, `saves inject <dir>` to see what a session there gets,
`saves set <ref> --purpose …` to reword, `saves retire <#|path|substring>` or
`saves retire gone` to drop. Files are plain single-line TSV; editing or deleting them by hand is
also fine. The only contract: latest file per folder wins.

## Porting (macOS)

1. Copy the whole `skills/save/` folder to `~/.claude/skills/save/` and
   `chmod +x hooks/*.sh bin/saves`; `sudo ln -s ~/.claude/skills/save/bin/saves /usr/local/bin/saves`.
2. Install `jq` (`brew install jq`) — the only dependency.
3. Merge into `~/.claude/settings.json` (top-level `hooks` key; merge with
   existing hooks, don't replace):

```json
{
  "hooks": {
    "SessionStart": [
      { "hooks": [ { "type": "command", "command": "bash ~/.claude/skills/save/hooks/session-start.sh", "timeout": 10, "statusMessage": "Loading saved handoffs" } ] }
    ],
    "Stop": [
      { "hooks": [ { "type": "command", "command": "bash ~/.claude/skills/save/hooks/stop.sh", "timeout": 10, "statusMessage": "Harvesting /save recap" } ] }
    ]
  }
}
```

4. Add the `# Saves` section and the safe-stop `/save` nudge to
   `~/.claude/CLAUDE.md` (see the gist's CLAUDE.md for exact text).
5. Restart Claude Code sessions.

State (`~/.claude/saves/`) is per-machine; never port it.
